import 'package:ewallet/Models/Wallet.dart';
import '../Services/JsonApi.dart';

class WalletController {
  getWallets(int uID) async {
    List wallet = await JsonApi().loadJSONData("Wallets");
    List wallets = [];
    for (int i = 0; i < wallet.length; i++) {
      if (wallet[i]["uID"] == uID) {
        wallets.add(wallet[i]);
      }
    }
    if (wallets.isEmpty) {
      return "You have no wallets";
    } else {
      return wallets;
    }
  }

  setWallets(int iD, String wName, String wType, int uID) async {
    await JsonApi().setJSONData(
      "Wallets",
      {"wID": iD, "wName": wName, "wType": wType, "uID": uID},
    );
  }
}
