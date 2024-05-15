import 'package:flutter/material.dart';

import '../../Services/JsonApi.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  // late AnimationController controller;
  late AnimationController _controller;
  pushAfterLoad() async {
    await JsonApi().setJSONFiles();
    _controller.forward();
    Navigator.of(context).pushReplacementNamed("SignIn");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // / [AnimationController]s can be created with `vsync: this` because of
      // / [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        pushAfterLoad();
      }
      setState(() {});
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 140),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                fit: BoxFit.fill,
                'assets/images/logo.png',
                width: 150,
              ),
              const Text(
                "E-WALLET",
                style: TextStyle(
                    color: Color(0xFF3D6670),
                    fontSize: 46.55,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "A P L I C A T I O N",
                style: TextStyle(
                  color: Color(0xFF3D6670),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 90),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFDDDDDD)),
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(40),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    backgroundColor: Colors.transparent,
                    color: Theme.of(context).primaryColor,
                    value: _controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ),
              ),
              const Text("2019.All rigths reserved"),
            ],
          ),
        ),
      ),
    );
  }
}
