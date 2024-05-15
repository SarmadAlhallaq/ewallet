import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ewallet/Screens/pages/SignIn.dart';
import 'package:ewallet/Screens/widget/DoubleButton.dart';
import 'package:ewallet/Screens/widget/LogoHeader.dart';
import 'package:flutter/material.dart';

import '../../controllers/UserController.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();

  afterValidator(validator) {
    if (validator == "User not found") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } else {
      AwesomeDialog(
          dialogType: DialogType.error,
          borderSide: const BorderSide(
            color: Color(0xFF404CB2),
            width: 2,
          ),
          padding: const EdgeInsets.only(bottom: 10),
          context: context,
          title: "Error",
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              validator,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )).show();
    }
  }

  signUpValidator() async {
    if (formKey.currentState!.validate()) {
      String validator = await UserController().getUserWithEmail(email.text);
      if (validator == "OK") {
        await UserController()
            .setUser(email.text, password.text, fName.text, lName.text);
        afterValidator("User not found");
      } else {
        afterValidator("User found");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: DoubleButton("SignUp", signUpValidator),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              LogoHeader("SIGN UP"),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Color(0xFF3D6670)),
                        controller: fName,
                        onSaved: (val) {
                          fName = val as TextEditingController;
                        },
                        validator: (val) {
                          if (val == "") {
                            return "Required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "First name",
                          prefixIcon: Icon(Icons.person_outline_outlined,
                              color: Color(0Xff94AFB6)),
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(color: Color(0xFFDDDDDD), thickness: 1),
                      TextFormField(
                        style: const TextStyle(color: Color(0xFF3D6670)),
                        controller: lName,
                        onSaved: (val) {
                          lName = val as TextEditingController;
                        },
                        validator: (val) {
                          if (val == "") {
                            return "Required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                          prefixIcon: Icon(Icons.person_outline_outlined,
                              color: Color(0Xff94AFB6)),
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(color: Color(0xFFDDDDDD), thickness: 1),
                      TextFormField(
                        style: const TextStyle(color: Color(0xFF3D6670)),
                        controller: email,
                        onSaved: (val) {
                          email = val as TextEditingController;
                        },
                        validator: (val) {
                          if (val == "") {
                            return "required";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(val!)) {
                            return "enter valid Email address";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined,
                              color: Color(0Xff94AFB6)),
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(color: Color(0xFFDDDDDD), thickness: 1),
                      TextFormField(
                        style: const TextStyle(color: Color(0xFF3D6670)),
                        obscureText: true,
                        controller: password,
                        onSaved: (val) {
                          password = val as TextEditingController;
                        },
                        validator: (val) {
                          if (val == "") {
                            return "Required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "password",
                          prefixIcon: Icon(Icons.lock_outline,
                              color: Color(0Xff94AFB6)),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
