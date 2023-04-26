import 'dart:math';

void main(List<String> args) {
  DateTime tarih = DateTime.now();
  //int ay = tarih.month;

  Random rnd = Random();

  int ay = rnd.nextInt(12);
  switch (ay) {
    case 12:
    case 1:
    case 2:
      print("$ay.Ay - Mevsim Kış");
      break;

    case 3:
    case 4:
    case 5:
      print("$ay.Ay - Mevsim İlkbahar");
      break;

    case 6:
    case 7:
    case 8:
      print("$ay.Ay - Mevsim Yaz");
      break;

    case 9:
    case 10:
    case 11:
      print("$ay.Ay - Mevsim Sonbahar");
      break;

    default:
      print("$ay.Ay - Mevsim Bulunamadı");
  }
}
