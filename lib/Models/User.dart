
import '../Services/JsonApi.dart';

class User {
  int iD;
  String fName;
  String lName;
  String email;
  String password;

  User(
    this.iD,
    this.fName,
    this.lName,
    this.email,
    this.password,
  );

  Future<bool> save() async {
    await JsonApi().setJSONData(
      "Users",
      {
        "iD": iD,
        "fName": fName,
        "lName": lName,
        "email": email,
        "password": password
      },
    );
    return true;
  }
}
