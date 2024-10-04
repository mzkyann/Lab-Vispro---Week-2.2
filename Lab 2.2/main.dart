import 'adaadaji.dart' as clr; // Menggunakan alias yang lebih singkat
import 'meledak.dart' as fireworks; // Import file untuk animasi
import 'dart:async';
import 'dart:math';
import 'dart:io';

// Definisi warna latar belakang terminal menggunakan kode ANSI
const List<String> bgColors = [
  "\x1B[40m", // Warna hitam
  "\x1B[41m", // Warna merah
  "\x1B[42m", // Warna hijau
  "\x1B[43m", // Warna kuning
  "\x1B[44m", // Warna biru
  "\x1B[45m", // Warna magenta
  "\x1B[46m", // Warna cyan
  "\x1B[47m", // Warna putih
];

// Fungsi untuk mengambil ukuran layar terminal
List<int> screenDimensions() {
  return [stdout.terminalColumns, stdout.terminalLines];
}

// Fungsi untuk membersihkan layar terminal
void resetScreen() {
  stdout.write("\x1B[2J\x1B[H"); // Membersihkan layar dan mengembalikan kursor ke atas kiri
}

// Fungsi jeda dengan durasi dalam milidetik
Future<void> waitFor(int millis) async {
  await Future.delayed(Duration(milliseconds: millis));
}

// Fungsi untuk menghasilkan bilangan acak dalam rentang tertentu
int generateRandom(int start, int end) {
  return start + Random().nextInt(end - start);
}

// Fungsi untuk menghasilkan bilangan acak hingga batas tertentu
int randomUpTo(int limit) {
  return Random().nextInt(limit);
}

void main() async {
  resetScreen(); // Bersihkan layar sebelum memulai program
  stdout.write("Berapa banyak kembang api yang ingin ditampilkan? ");
  
  // Baca input dari pengguna untuk jumlah kembang api
  int? fireworksCount = int.parse(stdin.readLineSync()!);
  
  // Jika jumlah kembang api kurang dari 1, set ke 1
  fireworksCount = fireworksCount < 1 ? 1 : fireworksCount;

  // Pilih warna latar belakang secara acak dari daftar
  String chosenBackground = bgColors[Random().nextInt(bgColors.length)];
  stdout.write(chosenBackground); // Set warna latar belakang

  resetScreen(); // Bersihkan layar setelah warna diatur
  
  // Looping untuk menampilkan kembang api sesuai jumlah yang diinput
  for (int i = 0; i < fireworksCount; i++) {
    int minHeight = screenDimensions()[1] ~/ 3; // Batas minimal tinggi kembang api
    int xPosition = randomUpTo(screenDimensions()[0]); // Posisi acak di sumbu X
    int yPosition = generateRandom(minHeight, screenDimensions()[1] - minHeight); // Posisi acak di sumbu Y
    String randomClr = clr.getRandomColor(); // Mendapatkan warna acak untuk kembang api
    
    // Kembang api pertama muncul di tengah layar
    if (i == 0) {
      xPosition = screenDimensions()[0] ~/ 2;
      yPosition = screenDimensions()[1] ~/ 2;
    }

    // Panggil animasi kembang api dari file kembangApi.dart
    await fireworks.kembangApi(xPosition, yPosition, randomClr);
  }

  resetScreen(); // Bersihkan layar setelah semua animasi selesai
}
