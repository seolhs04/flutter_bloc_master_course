import 'dart:async';

class LicenseRepository {
  StreamController<bool> changeLicenseStatus =
      StreamController<bool>.broadcast();
  late Stream<bool> stream;
  LicenseRepository() {
    stream = changeLicenseStatus.stream;
  }
  Future<bool> buyLicense() async {
    await Future.delayed(const Duration(seconds: 1));
    changeLicenseStatus.sink.add(true);
    return true;
  }
}
