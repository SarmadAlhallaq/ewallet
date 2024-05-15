import 'dart:math';

import 'package:ewallet/Models/WalletCard.dart';

import '../Services/JsonApi.dart';

class CardController {
  getCard(int wID) async {
    List card = await JsonApi().loadJSONData("Cards");
    for (int i = 0; i < card.length; i++) {
      if (card[i]["wID"] == wID) {
        return card[i];
      }
    }
    return "No card in this Wallet";
  }

  setCard(String cardType, String cardNumber, String nameOnCard,
      String expiryDate, double balance, int wID) async {
    WalletCard walletCard = WalletCard(Random().nextInt(1000000), cardType,
        cardNumber, nameOnCard, expiryDate, balance, wID);
    walletCard.save();
  }
}
