# 🔱 FerzKick: The Most Realistic Vehicle Kick Plugin for SA-MP

Selamat datang di project **FerzKick**! Project ini gue bangun buat kalian para scriptmaker dan owner server SA-MP yang bosen sama fitur `/kickveh` yang gitu-gitu aja. Di sini, gue pake mesin C++ buat simulasiin fisika tendangan yang beneran berasa nendang mobil—ada dorongannya, ada efek angkatnya, dan pastinya sinkron sama animasi.

**🛠️ Developed by: FERZDEVZ / FERDINAND**
**🌐 Discord: https://discord.gg/U3WeJxXy3D**

---

## 🚀 Kenapa Harus Pake FerzKick?

Kalo lo liat di FiveM atau MTA, nendang mobil itu berasa ada "impact"-nya. Nah, FerzKick bawa teknologi itu ke SA-MP 0.3.7 Legacy lewat hibrida C++ dan Pawn.

### ✨ Fitur Unggulan (Full Native Logic):
*   **🏎️ Super Physics Vector**: Gak cuma sekedar gerakin mobil, tapi plugin ini ngitung sudut dan kekuatan tendangan secara real-time di level memori (C++).
*   **⚡ Internal C++ Cooldown**: Gue tanemin sistem cooldown langsung di plugin. Jadi player gak bisa spam nendang sampe mobil terbang. Ini jauh lebih enteng daripada bikin timer di Pawn.
*   **🛡️ Developer API (Callbacks)**: Gue sediain callback `OnPlayerKickVehicle`. Lo bisa pake ini buat bikin log admin, sistem Greenzone, atau efek damage tambahan.
*   **📐 Smart Proximity Validation**: Plugin otomatis nge-cek jarak. Kalo player gak nempel sama mobil, tendangan gak bakal tembus. Gak perlu lagi ribet pake `IsPlayerInRangeOfPoint` di script lo.
*   **💥 Realistic Damage**: Setiap mobil yang ditendang bakal berkurang HP-nya dikit (0.5 HP), nambah kesan realistis kalo besi ditendang itu pasti penyok dikit.

---

## 📂 Struktur Project

Gue udah susun filenya biar lo tinggal pasang:
*   `plugins/ferzkick.so` -> Plugin utama (untuk Linux/VPS).
*   `include/ferzkick.inc` -> Include sakti yang lo panggil di script.
*   `ferzkick.pwn` -> Contoh penggunaan buat lo pelajari.

---

## 🛠️ Cara Pasang (Gampang Banget!)

1.  Download filenya dan taro `ferzkick.so` di folder **plugins** server lo.
2.  Buka `server.cfg`, tambahin `ferzkick.so` di baris plugins (pake spasi kalo ada banyak).
3.  Copy `ferzkick.inc` ke **pawno/include**.
4.  Di paling atas Gamemode lo, tulis:
    ```pawn
    #include <ferzkick>
    ```
5.  Compile (F5) dan lo udah resmi jadi owner server yang punya fitur sekelas FiveM!

---

## 📖 API & Functions

Gue buat fungsinya se-simple mungkin biar nggak pusing:

| Function | Deskripsi |
| --- | --- |
| `KickVehiclePro(playerid, vehid, force)` | Fungsi buat nendang mobil (Native). |
| `OnPlayerKickVehicle(playerid, vehid, force)` | Callback yang kepanggil kalo tendangan sukses. |

**Error Codes yang bisa lo pake:**
- `FK_SUCCESS (1)`: Berhasil nendang.
- `FK_ERROR_TOO_FAR (-1)`: Player kejauhan dari mobil.
- `FK_ERROR_COOLDOWN (-2)`: Player lagi capek/cooldown.

---

## 📜 Pesan dari Ferdinand
Project ini gue kasih gratis buat komunitas. Gue cuma minta satu hal: **Jangan hapus credit-nya!** Hargai capeknya gue ngitung matematika fisika di C++ buat kalian semua.

Kalo ada bug atau mau request fitur, langsung aja mampir ke Discord gue.

**🚩 FERZDEVZ: Powering Your Server with Next-Gen Tech.**
