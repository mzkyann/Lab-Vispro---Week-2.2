import 'dart:io';
import 'adaadaji.dart' as color;
import 'dart:math';

// Kode escape ANSI untuk warna latar belakang ledakan
const List<String> explosionBackgroundColors = [
  "\x1B[41m", // Merah
  "\x1B[42m", // Hijau
  "\x1B[43m", // Kuning
  "\x1B[44m", // Biru
  "\x1B[45m", // Magenta
  "\x1B[46m", // Cyan
];

// Fungsi untuk menggerakkan kursor ke koordinat (baris, kolom) tertentu
void moveTo(int row, int col) {
  stdout.write('\x1B[${row};${col}H');
}

// Fungsi untuk mencetak kembang api sebelum meledak
void printFrame1(int centerX, int centerY, String colorSelect) {
  moveTo(centerY, centerX);
  stdout.write('${colorSelect}|${color.RESET}');
}

// Fungsi untuk mencetak ledakan kembang api dalam bentuk seperti kepingan salju (tahap awal)
void printFrame2(int centerX, int centerY, String colorSelect) {
  // Menggambar bentuk dasar kepingan salju
  moveTo(centerY - 1, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');

  // Menambahkan bagian diagonal untuk menyerupai lengan kepingan salju
  moveTo(centerY - 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY - 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');

  // Menambahkan lengan tambahan untuk kepingan salju
  moveTo(centerY - 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 2);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 2);
  stdout.write('${colorSelect}*${color.RESET}');
}

// Fungsi untuk mencetak ledakan kembang api dengan bentuk penuh kepingan salju
void printFrame3(int centerX, int centerY, String colorSelect) {
  // Ledakan di pusat
  moveTo(centerY, centerX);
  stdout.write('${colorSelect}*${color.RESET}');

  // Pola lengkap kepingan salju
  moveTo(centerY - 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 2);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 2);
  stdout.write('${colorSelect}*${color.RESET}');

  // Lengan diagonal untuk tampilan kepingan salju
  moveTo(centerY - 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY - 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');

  // Lengan kepingan salju yang diperpanjang
  moveTo(centerY - 3, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 3, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 3);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 3);
  stdout.write('${colorSelect}*${color.RESET}');
}

// Fungsi untuk membersihkan layar
void clearScreen() {
  stdout.write('\x1B[2J\x1B[0;0H');
}

// Fungsi untuk mencetak pesan HBD ANO
Future<void> printHBDMessage() async {
  const List<String> message = [
    " **  **  ******   *******           ***         ****     **    *****   ",
    " **  **  **    *  **    ***        **  **       ** **    **   **   **  ",
    " ******  ** ***   **       *      **    **      **  **   **   **   **  ",
    " **  **  **    *  **     **      **********     **   **  *    **   **  ",
    " **  **  ******   *******       **        **    **     **      *****   ",
  ];

  // Menggerakkan pesan dari bawah ke tengah layar
  for (int i = message.length - 1; i >= 0; i--) {
    moveTo(15 - (message.length - 1 - i), 10); // Mulai dari bawah
    stdout.write(message[i]);
    await Future.delayed(Duration(milliseconds: 300)); // Jeda antar baris
  }
  
  // Menahan pesan lebih lama di layar
  await Future.delayed(Duration(seconds: 3));
}

// Fungsi animasi kembang api
Future<void> kembangApi(centerX, centerY, String colorSelect) async {
  clearScreen();

  // Frame 1: Kembang api naik (titik pusat sebelum ledakan)
  for (int i = centerY; i > centerY - 5; i--) { // Gerakkan kursor ke atas
    printFrame1(centerX, i, colorSelect);
    await Future.delayed(Duration(milliseconds: 100)); // Kecepatan naik
    clearScreen();
  }

  // Setelah mencapai puncak
  printFrame1(centerX, centerY - 5, colorSelect);
  await Future.delayed(Duration(milliseconds: 500)); // Jeda sebelum ledakan

  // Frame 2: Ledakan mulai terjadi
  clearScreen();
  printFrame2(centerX, centerY - 5, colorSelect);
  String explosionBackground = explosionBackgroundColors[Random().nextInt(explosionBackgroundColors.length)];
  stdout.write(explosionBackground); // Mengubah latar belakang untuk ledakan
  await Future.delayed(Duration(milliseconds: 500));

  // Frame 3: Ledakan penuh dalam bentuk kepingan salju
  clearScreen();
  printFrame3(centerX, centerY - 5, colorSelect);
  await Future.delayed(Duration(milliseconds: 500));

  // Mencetak pesan HBD ANO
  clearScreen();
  await printHBDMessage(); // Memanggil fungsi untuk mencetak pesan HBD ANO

  // Mengembalikan warna latar belakang ke default setelah ledakan
  stdout.write("\x1B[0m"); // Reset ke latar belakang default
}
