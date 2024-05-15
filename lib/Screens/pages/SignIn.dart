import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ewallet/Models/User.dart';
import 'package:ewallet/Screens/widget/DoubleButton.dart';
import 'package:ewallet/Screens/widget/LogoHeader.dart';
import 'package:ewallet/Screens/widget/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Provider.dart';
import '../../controllers/UserController.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var userdata;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  awesomeDialog() {
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
            userdata,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        )).show();
  }

  signInValidator() async {
    if (formKey.currentState!.validate()) {
      userdata = await UserController()
          .getUserWithEmailAndPassword(email.text, password.text);
      if (userdata == "Wrong password") {
        awesomeDialog();
      } else if (userdata == "User not found") {
        awesomeDialog();
      } else {
        // do the work

        User user = User(
          userdata["iD"],
          userdata["fName"],
          userdata["lName"],
          userdata["email"],
          userdata["password"],
        );
        await context.read<Providers>().setUser(user);

        await context.read<Providers>().setWallets(user.iD);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavBar(user)),
        );
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
        child: DoubleButton("SignIn", signInValidator),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LogoHeader("SIGN IN"),
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
                          controller: email,
                          onSaved: (val) {
                            email = val as TextEditingController;
                          },
                          validator: (val) {
                            if (val == "") {
                              return "required";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                        const Divider(
                          color: Color(0xFFDDDDDD),
                          height: 30,
                        ),
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
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xFF404CB2)),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
