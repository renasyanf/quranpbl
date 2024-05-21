class ZakatCalculator {
  // Misalnya, kita ingin menghitung zakat mal (2.5% dari harta yang telah mencapai nisab)
  double calculateZakatMal(double totalWealth) {
    return totalWealth * 0.025;
  }

  // Zakat Fitrah (Misal, 2.5 kg beras atau uang senilai 2.5 kg beras per orang)
  double calculateZakatFitrah(int numberOfPeople, double ricePricePerKg) {
    return numberOfPeople * 2.5 * ricePricePerKg;
  }
}
