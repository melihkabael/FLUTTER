import 'dart:convert';
import 'dart:math';

void main(List<String> args) {
  List<int> sayilar = [5, 23, 32, 48, 51, 59];
  List<int> kasasayilar = [];
  int tahmin = 0;

  for (var i = 0; i < 6; i++) {
    kasasayilar.add(Random().nextInt(60));
  }

  for (var i = 0; i < sayilar.length; i++) {
    for (var j = 0; j < kasasayilar.length; j++) {
      sayilar[i] == kasasayilar[j] ? tahmin++ : null;
    }
  }
  print("$tahmin adet sayi tutturdunuz");
  print("Kasanin Sayilari: ${kasasayilar.toString()}");
}
