import 'package:dotted_line/dotted_line.dart';
import 'package:ewallet/Controllers/TransactionController.dart';
import 'package:ewallet/Models/Transaction.dart';
import 'package:ewallet/Models/WalletCard.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  History(this.wID, this.isMoreThanOneWallet, this.walletCard, {Key? key})
      : super(key: key);
  List wID;
  bool isMoreThanOneWallet;
  List<WalletCard> walletCard;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Map iconsMap = {
    "Store payment": Icons.shopping_cart,
    "Exchange payment": Icons.local_phone_outlined,
    "Salary": Icons.car_crash_rounded,
    "Transaction": Icons.compare_arrows,
    "Gasoline": Icons.car_crash_rounded,
    "Deposit": Icons.watch_later_outlined,
    "Online store payment": Icons.online_prediction,
  };

  List transactionMaps = [];
  bool isLoadRow = true;
  String current = "";
  String isSelected = "All";
  List<Transaction> _transactions = [];
  double directionAmount = 0;
  int iD = 0;
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();

  showAllHistory() {
    setState(() {
      fromDate = DateTime(1900);
      toDate = DateTime.now();
      _setTransactions();
    });
  }

  _setTransactions() async {
    directionAmount = 0;
    _transactions = await TransactionController()
        .getTransactionsWithDate([widget.wID], fromDate, toDate);

    List supTrans = [];
    transactionMaps = [];
    directionAmount = 0;
    String date = "";
    for (int i = 0; i < _transactions.length; i++) {
      bool y = i != 0 &&
          "${_transactions[i - 1].day} ${_transactions[i - 1].month}" ==
              "${_transactions[i].day} ${_transactions[i].month}";

      if (i == 0) {
        if (isSelected == "All") {
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";

          _dailyIncome(i);
        } else if (isSelected == "Income" &&
            _transactions[i].direction == "income") {
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";

          _dailyIncome(i);
        } else if (isSelected == "Spending" &&
            _transactions[i].direction == "spending") {
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";

          _dailyIncome(i);
        }
      } else if (y) {
        if (isSelected == "All") {
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";
          _dailyIncome(i);
        } else if (isSelected == "Income" &&
            _transactions[i].direction == "income") {
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";
          _dailyIncome(i);
        } else if (isSelected == "Spending" &&
            _transactions[i].direction == "spending") {
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";
          _dailyIncome(i);
        }
      } else {
        if (isSelected == "All") {
          if (supTrans.isNotEmpty) {
            transactionMaps.add(
                {"list": supTrans, "date": date, "income": directionAmount});
          }

          supTrans = [];
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";

          directionAmount = 0;
          _dailyIncome(i);
        } else if (isSelected == "Income" &&
            _transactions[i].direction == "income") {
          if (supTrans.isNotEmpty) {
            transactionMaps.add(
                {"list": supTrans, "date": date, "income": directionAmount});
          }

          supTrans = [];
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";

          directionAmount = 0;
          _dailyIncome(i);
        } else if (isSelected == "Spending" &&
            _transactions[i].direction == "spending") {
          if (supTrans.isNotEmpty) {
            transactionMaps.add(
                {"list": supTrans, "date": date, "income": directionAmount});
          }

          supTrans = [];
          supTrans.add(_transactions[i]);
          date = "${_transactions[i].day} ${_transactions[i].month}";

          directionAmount = 0;
          _dailyIncome(i);
        }
      }
    }
    if (supTrans.isNotEmpty) {
      transactionMaps
          .add({"list": supTrans, "date": date, "income": directionAmount});
    }

    setState(() {
      isLoadRow = false;
      iD = widget.wID[0];
    });
  }

  _dailyIncome(int index) {
    if (_transactions[index].direction == "income") {
      directionAmount += _transactions[index].amount;
    } else {
      directionAmount -= _transactions[index].amount;
    }
  }

  getCardType(List<WalletCard> walletCard, wID) {
    for (int i = 0; i < walletCard.length; i++) {
      if (walletCard[i].wID == wID) {
        return walletCard[i].cardType;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //to be sure that we call _setTransactions() one Time
    Map translationsMap = {
      "Store payment": "storePayment",
      "Salary": "salary",
    };

    iD != widget.wID[0] ? _setTransactions() : "";
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white)),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      color: isSelected == "All"
                          ? Theme.of(context).primaryColor
                          : const Color(0xFFF1F3F6),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(1000)),
                      border: Border.all(color: Colors.white)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "all",
                    style: TextStyle(
                        color: isSelected == "All"
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 14),
                  ),
                ),
                onTap: () {
                  isSelected = "All";
                  _setTransactions();
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: isSelected == "Income"
                          ? Theme.of(context).primaryColor
                          : const Color(0xFFF1F3F6),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(1000)),
                      border: Border.all(color: Colors.white)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "income",
                    style: TextStyle(
                        color: isSelected == "Income"
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 14),
                  ),
                ),
                onTap: () {
                  isSelected = "Income";
                  _setTransactions();
                },
              ),
              InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                      color: isSelected == "Spending"
                          ? Theme.of(context).primaryColor
                          : const Color(0xFFF1F3F6),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(1000)),
                      border: Border.all(color: Colors.white)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "spending",
                    style: TextStyle(
                        color: isSelected == "Spending"
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 14),
                  ),
                ),
                onTap: () {
                  isSelected = "Spending";
                  _setTransactions();
                },
              ),
            ],
          ),
          isLoadRow
              ? const CircularProgressIndicator()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: transactionMaps.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isIncome = transactionMaps[index]["income"] > 0;

                    return Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                index == 0
                                    ? Container()
                                    : const DottedLine(
                                        dashColor: Color(0xFFDDDDDD),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${transactionMaps[index]["date"]} ",
                                      style: const TextStyle(
                                          color: Color(0xFF94AFB6),
                                          fontSize: 13),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: isIncome
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "${isIncome ? "+" : "-"} \$${transactionMaps[index]["income"].abs()}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          isLoadRow
                              ? const CircularProgressIndicator()
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      transactionMaps[index]["list"].length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index2) {
                                    String cardType = "";
                                    cardType = getCardType(
                                        widget.walletCard,
                                        transactionMaps[index]["list"][index2]
                                            .wID);
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            const Color(0xFFF1F3F6),
                                        child: Icon(
                                          iconsMap[transactionMaps[index]
                                                  ["list"][index2]
                                              .type],
                                          color: const Color(0xFF94AFB6),
                                        ),
                                      ),
                                      title: widget.isMoreThanOneWallet
                                          ? Text(cardType,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF94AFB6)))
                                          : Text(
                                              "${translationsMap[transactionMaps[index]["list"][index2].type]}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF3D6670))),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            transactionMaps[index]["list"]
                                                    [index2]
                                                .time,
                                            style: const TextStyle(
                                                color: Color(0xFF94AFB6),
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "${transactionMaps[index]["list"][index2].direction == "income" ? "+" : "-"}${cardType == "Bitcoin" ? "" : " \$"}${transactionMaps[index]["list"][index2].amount}${cardType == "Bitcoin" ? " BTC" : ""}",
                                            style: TextStyle(
                                                color: transactionMaps[index]
                                                                ["list"][index2]
                                                            .direction ==
                                                        "income"
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      subtitle: widget.isMoreThanOneWallet
                                          ? Text(
                                              "${translationsMap[transactionMaps[index]["list"][index2].type]}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF3D6670)))
                                          : null,
                                    );
                                  }),
                        ],
                      ),
                    );
                  }),
          const Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              showAllHistory();
              // load All Data
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                fromDate == DateTime(1900) ? "noMoreHistory" : "showAllHistory",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
