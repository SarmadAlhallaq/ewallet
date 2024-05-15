import '../Services/JsonApi.dart';

class Wallet {
  int walletID;
  int userID;
  String walletType;
  String walletName;

  Wallet(
    this.walletID,
    this.userID,
    this.walletType,
    this.walletName,
  );



  Future<bool> save() async {
    await JsonApi().updateJSONData("Wallets", {
      "wID":walletID,
      "uID": userID,
      "wType":walletType,
      "wName": walletName,

    }, {"wID":walletID});

    return true;
  }
}
