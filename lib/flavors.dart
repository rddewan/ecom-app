enum Flavor {
  DEV,
  QA,
  UAT,
  PROD,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'EcomApp';
      case Flavor.QA:
        return 'EcomApp';
      case Flavor.UAT:
        return 'EcomApp';
      case Flavor.PROD:
        return 'EcomApp';
      default:
        return 'title';
    }
  }

}
