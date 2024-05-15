import 'dart:math';
import '../Models/User.dart';
import '../Services/JsonApi.dart';

class UserController{

  getUserWithEmailAndPassword(String email,String password) async {
    List user=await JsonApi().loadJSONData("Users");
    for (int i=0; i<user.length;i++){
      if (user[i]["email"]==email && user[i]["password"]==password){
        return user[i];
      }
      else if (user[i]["email"]==email && user[i]["password"]!=password){

        return "Wrong password";

      }
    }

    return "User not found";

  }

  getUserWithEmail(String email) async {
    List user=await JsonApi().loadJSONData("Users");
    for (int i=0; i<user.length;i++){
      if (user[i]["email"]==email){
        return "Email is already used";
      }

    }
    return "OK";

  }
  setUser(String email,String password,String fName,String lName) async {
    User u = User(Random().nextInt(1000000), fName, lName, email, password);
    u.save();
  }
}
