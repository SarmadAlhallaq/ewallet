import 'package:ewallet/Models/WalletCard.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  MyCard(this.walletCard, {Key? key}) : super(key: key);
  WalletCard walletCard;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF243972),
            Color(0xFF14234A),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/${widget.walletCard.cardType}.png",
                color:
                    widget.walletCard.cardType == "Visa" ? Colors.white : null,
                width: 50,
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Available balance",
                  style: TextStyle(color: Color(0xFF94AFB6), fontSize: 13),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/chip.png", height: 24),
              Text(
                "\$${widget.walletCard.balance}",
                style: const TextStyle(color: Colors.white, fontSize: 22),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.walletCard.cardNumber.substring(0, 4),
                  style:
                      const TextStyle(color: Color(0xFFA8ADDD), fontSize: 19),
                ),
                Text(
                  widget.walletCard.cardNumber.substring(5, 9),
                  style:
                      const TextStyle(color: Color(0xFFA8ADDD), fontSize: 19),
                ),
                Text(
                  widget.walletCard.cardNumber.substring(10, 14),
                  style:
                      const TextStyle(color: Color(0xFFA8ADDD), fontSize: 19),
                ),
                Text(
                  widget.walletCard.cardNumber.substring(15, 19),
                  style:
                      const TextStyle(color: Color(0xFFA8ADDD), fontSize: 19),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Text(
                  "EXPIRE ",
                  style: TextStyle(color: Color(0xFF94AFB6), fontSize: 12),
                ),
                Text(
                  widget.walletCard.expiryDate,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
