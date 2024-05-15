import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ewallet/Controllers/CardController.dart';
import 'package:ewallet/Controllers/WalletController.dart';
import 'package:ewallet/Models/User.dart';
import 'package:ewallet/Screens/widget/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controllers/Provider.dart';

class AddWallet extends StatefulWidget {
  AddWallet({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController walletName = TextEditingController();
  TextEditingController cardNum = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController secureCode = TextEditingController();
  TextEditingController nOnCard = TextEditingController();
  TextEditingController paypalEmail = TextEditingController();
  TextEditingController paypalPassword = TextEditingController();
  final List<String> items = ['Bank Card', 'PayPal'];

  onSave() async {
    await addWallet();
  }

  addWallet() async {
    User user = context.read<Providers>().user;
    int uID = context.read<Providers>().uID;
    if (formKey.currentState!.validate()) {
      int iD = Random().nextInt(1000000);
      WalletController().setWallets(iD, walletName.text, walletType, uID);

      CardController().setCard(
          cardType, cardNum.text, nOnCard.text, expiryDate.text, 0.0, iD);

      await context.read<Providers>().setWallets(user.iD);
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return NavBar(user);
          },
        ),
        (_) => false,
      );
    }
  }

  validator(val) {
    if (val == "") {
      return "required";
    }
    return null;
  }

  String cardType = "Mastercard";
  String walletType = "Bank Card";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String title = "New Wallet";
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F6),
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
            ),
            onTap: () {
              User user = context.read<Providers>().user;
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return NavBar(user);
                    },
                  ),
                  (_) => false,
                );
              }
            },
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Color(0xFF3D6670), fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                onSave();
              },
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Wallet na me",
                    style: TextStyle(color: Color(0xFF94AFB6), fontSize: 12)),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: walletName,
                  onSaved: (val) {
                    walletName.text = val!;
                  },
                  validator: (val) => validator(val),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color(0xFF94AFB6)), //<-- SEE HERE
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Wallet type",
                      style: TextStyle(color: Color(0xFF94AFB6), fontSize: 12),
                    )),
                const SizedBox(
                  height: 5,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF94AFB6)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            walletType,
                            style: const TextStyle(
                              color: Color(0xFF3D6670),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF3D6670))
                        ],
                      ),
                    ),
                    dropdownStyleData: const DropdownStyleData(
                      decoration: BoxDecoration(
                        boxShadow: [],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: walletType == item
                                      ? Theme.of(context).primaryColor
                                      : const Color(0xFF3D6670),
                                ),
                              ),
                            ))
                        .toList(),
                    value: walletType,
                    onChanged: (value) {
                      setState(() {
                        walletType = value as String;
                        if (walletType == "Bank Card") {
                          cardType = "Mastercard";
                        } else if (walletType == "Cryptocurrency") {
                          cardType = "Bitcoin";
                        }
                      });
                    },
                    iconStyleData: IconStyleData(
                        iconEnabledColor: Theme.of(context).primaryColor),
                    buttonStyleData: const ButtonStyleData(),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
                walletType == "Bank Card"
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Card type",
                              style: TextStyle(
                                  color: Color(0xFF94AFB6), fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cardType == "Visa"
                                              ? Theme.of(context).primaryColor
                                              : const Color(0xFFF1F3F6),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(5)),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Center(
                                          child: Text(
                                        "Visa",
                                        style: TextStyle(
                                            color: cardType == "Visa"
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
                                            fontSize: 14),
                                      )),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        cardType = "Visa";
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cardType == "Mastercard"
                                              ? Theme.of(context).primaryColor
                                              : const Color(0xFFF1F3F6),
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Center(
                                          child: Text(
                                        "MasterCard",
                                        style: TextStyle(
                                            color: cardType == "Mastercard"
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
                                            fontSize: 14),
                                      )),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        cardType = "Mastercard";
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const DottedLine(
                              dashGapLength: 2,
                              dashColor: Color(0xFFDDDDDD),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Card number",
                              style: TextStyle(
                                  color: Color(0xFF94AFB6), fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  color: Color(0xFF3D6670), fontSize: 14),
                              controller: cardNum,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (val) {
                                if (val == "") {
                                  return "required";
                                }
                                if (val!.length < 19) {
                                  return "Card number must contain 16 digit";
                                }

                                return null;
                              },
                              onSaved: (val) {
                                cardNum = val as TextEditingController;
                              },
                              textInputAction: TextInputAction.done,
                              maxLength: 19,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFF94AFB6))),
                                counterText: "",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFF94AFB6)), //<-- SEE HERE
                                ),
                                hintText: "XXXX XXXX XXXX XXXX",
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                hintStyle:
                                    const TextStyle(color: Color(0Xff94AFB6)),
                                suffixIcon: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFDDDDDD)),
                                      color: const Color(0xFFF1F3F6),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Image.asset(
                                    'assets/images/$cardType.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Expiry Date",
                                      style: TextStyle(
                                          color: Color(0xFF94AFB6),
                                          fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: width / 2 - 45,
                                      child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        controller: expiryDate,
                                        onSaved: (val) {
                                          expiryDate =
                                              val as TextEditingController;
                                        },
                                        validator: (val) => validator(val),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        maxLength: 5,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF94AFB6))),
                                          counterText: "",
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFF94AFB6)),
                                          ),
                                          hintText: "MM / YY",
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.red)),
                                          hintStyle: TextStyle(
                                              color: Color(0Xff94AFB6)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Secure code",
                                      style: TextStyle(
                                          color: Color(0xFF94AFB6),
                                          fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: width / 2 - 45,
                                      child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        controller: secureCode,
                                        onSaved: (val) {
                                          secureCode =
                                              val! as TextEditingController;
                                        },
                                        keyboardType: TextInputType.number,
                                        validator: (val) {
                                          if (val == "") {
                                            return "required";
                                          }
                                          if (val!.length != 3) {
                                            return "Secure code  must  3 digits";
                                          }

                                          return null;
                                        },
                                        maxLength: 3,
                                        decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF94AFB6))),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 0),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(
                                                      0xFF94AFB6)), //<-- SEE HERE
                                            ),
                                            hintText: "***",
                                            errorBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.red)),
                                            counterText: "",
                                            hintStyle: const TextStyle(
                                                color: Color(0Xff94AFB6)),
                                            suffixIcon: GestureDetector(
                                              onTap: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (_) => Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: Container(
                                                            width: 200,
                                                            height: 200,
                                                            color: Colors
                                                                .transparent,
                                                            child: Image.asset(
                                                                "assets/images/CVV.png"),
                                                          ),
                                                        ));
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFDDDDDD)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color(
                                                        0xFFF1F3F6)),
                                                child: Icon(
                                                  Icons.info_outline,
                                                  size: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Text("Name on card",
                                style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: nOnCard,
                              onSaved: (val) {
                                nOnCard = val as TextEditingController;
                              },
                              validator: (val) => validator(val),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFF94AFB6))),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFF94AFB6)), //<-- SEE HERE
                                ),
                                hintText: "",
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                hintStyle: TextStyle(color: Color(0Xff94AFB6)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          const DottedLine(
                            dashGapLength: 2,
                            dashColor: Color(0xFFDDDDDD),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("E-Mail",
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyMedium,
                            controller: paypalEmail,
                            onSaved: (val) {
                              paypalEmail = val as TextEditingController;
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF94AFB6))),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF94AFB6)),
                                //<-- SEE HERE
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Password",
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: Theme.of(context).textTheme.bodyMedium,
                            controller: paypalPassword,
                            onSaved: (val) {
                              paypalPassword = val! as TextEditingController;
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF94AFB6))),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFF94AFB6)), //<-- SEE HERE
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            "ADD WALLET",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )),
                        ),
                        onTap: () async {
                          onSave();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
