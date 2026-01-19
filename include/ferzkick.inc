/* 
    ==================================================
    ferzkick PROFESSIONAL - SUPER PHYSICS SUITE
    Developed by: FERZDEVZ / FERDINAND
    ==================================================
*/

#if defined _FERZKICK_INCLUDED
    #endinput
#endif
#define _FERZKICK_INCLUDED

#include <YSI_Coding\y_hooks>

/**
 * @section Error Codes
 */
enum {
    FK_SUCCESS = 1,
    FK_ERROR_TOO_FAR = -1,
    FK_ERROR_COOLDOWN = -2,
    FK_ERROR_INVALID_PARAM = -3
};

// --- Full Native Engine ---
/**
 * @native FK_ProcessKickPro
 * @brief Calculates intense physical impulse and handles internal cooldowns.
 */
native FK_ProcessKickPro(playerid, Float:pX, Float:pY, Float:pZ, Float:pA, Float:vX, Float:vY, Float:vZ, Float:force, &Float:vx, &Float:vy, &Float:vz);

// --- Forwards ---
/**
 * @forward OnPlayerKickVehicle
 * @brief Called after a vehicle is successfully kicked.
 */
forward OnPlayerKickVehicle(playerid, vehicleid, Float:force);

// --- High Level API ---

/**
 * @function KickVehiclePro
 * @param playerid The player performing the kick
 * @param vehicleid The vehicle being kicked
 * @param force The intensity of the kick (default 14.0)
 * @return 1 on success, -1 if too far, -2 if on cooldown.
 */
stock KickVehiclePro(playerid, vehicleid, Float:force = 14.0)
{
    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);
    
    new Float:vx, Float:vy, Float:vz;
    GetVehiclePos(vehicleid, vx, vy, vz);
    
    new Float:out_vx, Float:out_vy, Float:out_vz;
    new status = FK_ProcessKickPro(playerid, px, py, pz, pa, vx, vy, vz, force, out_vx, out_vy, out_vz);
    
    if(status == FK_SUCCESS) 
    {
        ApplyAnimation(playerid, "FIGHT_D", "FightD_Kick", 4.1, 0, 1, 1, 0, 0, 1);
        SetVehicleVelocity(vehicleid, out_vx, out_vy, out_vz);
        
        // Realistic touch: Reduce HP a bit (kicking a car hurts it)
        new Float:hp;
        GetVehicleHealth(vehicleid, hp);
        SetVehicleHealth(vehicleid, hp - 0.5); // Subtle damage
        
        // Trigger forward for other developers
        CallLocalFunction("OnPlayerKickVehicle", "ddf", playerid, vehicleid, force);
        return FK_SUCCESS;
    }
    return status; 
}

// Internal hook for branding
hook OnGameModeInit()
{
    print("========================================");
    print("   ferzkick SUPER PHYSICS SUITE V2     ");
    print("   Owner: FERZDEVZ / FERDINAND         ");
    print("   Status: ALL SYSTEMS NOMINAL         ");
    print("========================================");
    return 1;
}

hook OnFilterScriptInit()
{
    print("========================================");
    print("   ferzkick SUPER PHYSICS SUITE V2     ");
    print("   Owner: FERZDEVZ / FERDINAND         ");
    print("   Status: ALL SYSTEMS NOMINAL         ");
    print("========================================");
    return 1;
}
