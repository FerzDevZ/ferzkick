/*
    ==================================================
    🔱 FERZKICK - PROFESSIONAL EXAMPLE SCRIPT
    Developed by: FERZDEVZ / FERDINAND
    ==================================================
    Banyak server RP yang minta fitur ini, jadi gue buatin
    contoh yang bener-bener "Full RP". 
*/

#define FILTERSCRIPT // Biar lo bisa tes sebagai FS

#include <a_samp>
#include <ferzkick> // Include sakti buatan Ferdinand
#include <zcmd>     // Pake ZCMD biar kenceng

#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
    print("------------------------------------------");
    print("  FERZKICK FS BY FERZDEVZ LOADED          ");
    print("  Status: READY TO KICK!                  ");
    print("------------------------------------------");
    return 1;
}
#else
main() 
{
    print("------------------------------------------");
    print("  FERZKICK GAMEMODE BY FERZDEVZ LOADED    ");
    print("  Status: READY TO KICK!                  ");
    print("------------------------------------------");
}
#endif

// --- Logic Callback (Opsional buat Dev) ---
public OnPlayerKickVehicle(playerid, vehicleid, Float:force)
{
    new string[128];
    format(string, sizeof(string), "[DEBUG]: Player ID %d baru aja nendang kendaraan ID %d.", playerid, vehicleid);
    // SendAdminMessage(string); // Lo bisa tambahin fungsi admin info di sini
    return 1;
}

// --- Perintah Utama ---
CMD:kickveh(playerid, params[])
{
    // 1. Cari mobil terdekat (radius 4.0 meter biar gak kejauhan)
    new vehid = GetNearestVehicle(playerid, 4.0);
    
    if(vehid == INVALID_VEHICLE_ID)
    {
        return SendClientMessage(playerid, 0xFF0000FF, "Error: Gak ada kendaraan di deket lo!");
    }
    
    // 2. Cek apakah player lagi di dalem mobil (masa nendang dari dalem?)
    if(IsPlayerInAnyVehicle(playerid))
    {
        return SendClientMessage(playerid, 0xFF0000FF, "Error: Turun dulu kalo mau nendang, Bang!");
    }

    // 3. Panggil API FerzKick (Logic fisik ada di Plugin .so)
    // Force 15.0 itu udah berasa banget guncangannya.
    new result = KickVehiclePro(playerid, vehid, 15.0);
    
    // 4. Handle Error dari Plugin C++
    switch(result)
    {
        case FK_ERROR_TOO_FAR: {
            SendClientMessage(playerid, 0xFF0000FF, "Error: Lo kurang nempel sama bodi mobilnya!");
        }
        case FK_ERROR_COOLDOWN: {
            SendClientMessage(playerid, 0xFF0000FF, "Error: Sabar, kaki lo masih capek (Cooldown)!");
        }
        case FK_SUCCESS: {
            // Kasih efek suara biar makin mantap
            PlayerPlaySound(playerid, 1131, 0.0, 0.0, 0.0); 
            SendClientMessage(playerid, 0x00FF00FF, "Sukses: Mobil kena mental!");
        }
    }
    
    return 1;
}

// --- Helper Functions ---

stock GetNearestVehicle(playerid, Float:range)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    new nearest = INVALID_VEHICLE_ID;
    new Float:minDist = range;

    for(new i = 1; i <= MAX_VEHICLES; i++)
    {
        if(GetVehicleModel(i) > 0)
        {
            new Float:vDist = GetVehicleDistanceFromPoint(i, x, y, z);
            if(vDist <= minDist)
            {
                minDist = vDist;
                nearest = i;
            }
        }
    }
    return nearest;
}
