import '../Services/JsonApi.dart';

class WalletCard {
  int cID;
  String cardType;
  String cardNumber;
  String expiryDate;
  String nameOnCard;
  double balance;
  int wID;

  WalletCard(
    this.cID,
    this.cardType,
    this.cardNumber,
    this.nameOnCard,
    this.expiryDate,
    this.balance,
    this.wID,
  );

  Future<bool> save() async {
    await JsonApi().updateJSONData("Cards", {
      "cID": cID,
      "cardType": cardType,
      "CardNumber": cardNumber,
      "nameOnCard": nameOnCard,
      "expiryDate": expiryDate,
      "balance": balance,
      "wID": wID
    }, {
      "cID": cID
    });
    return true;
  }
}
