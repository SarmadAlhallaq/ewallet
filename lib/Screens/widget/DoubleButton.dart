import 'package:flutter/material.dart';

class DoubleButton extends StatelessWidget {
  String page;
  final VoidCallback callback;

  DoubleButton(this.page, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: Center(
                child: InkWell(
                    onTap: page == "SignUp"
                        ? callback
                        : () {
                            Navigator.of(context)
                                .pushReplacementNamed("SignUp");
                          },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: page == "SignUp"
                            ? const Color(0xFF404CB2)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: page == "SignUp"
                                  ? Colors.white
                                  : const Color(0xFF404CB2)),
                        ),
                      ),
                    )),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: Center(
                child: InkWell(
                    onTap: page == "SignIn"
                        ? callback
                        : () {
                            Navigator.of(context)
                                .pushReplacementNamed("SignIn");
                          },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: page == "SignIn"
                            ? const Color(0xFF404CB2)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          "SIGN In",
                          style: TextStyle(
                              color: page == "SignIn"
                                  ? Colors.white
                                  : const Color(0xFF404CB2)),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
