import 'package:ewallet/Models/Transaction.dart';
import 'package:intl/intl.dart';
import '../Services/JsonApi.dart';

class TransactionController {
  getTransactions(List wID) async {
    List transaction = await JsonApi().loadJSONData("Transactions");
    List<Transaction> transactions = [];
    for (int j = 0; j < wID[0].length; j++) {
      for (int i = 0; i < transaction.length; i++) {
        if (transaction[i]["wID"] == wID[0][j]) {
          transactions.add(Transaction(
            transaction[i]["tID"],
            transaction[i]["type"],
            transaction[i]["day"],
            transaction[i]["month"],
            transaction[i]["time"],
            transaction[i]["direction"],
            transaction[i]["amount"],
            transaction[i]["wID"],
          ));
          // transactions.add(transaction[i]);
        }
      }
    }
    return transactions;
  }

  getTransactionsWithDate(List wID, DateTime fromDate, DateTime toDate) async {
    List transaction = await JsonApi().loadJSONData("Transactions");
    List<Transaction> transactions = [];
    DateTime now = DateTime.now();
    for (int j = 0; j < wID[0].length; j++) {
      for (int i = 0; i < transaction.length; i++) {
        String dateString =
            "${transaction[i]["month"]} ${transaction[i]["day"]}, ${now.year}";
        DateFormat format = DateFormat("MMMM dd, yyyy");
        DateTime formattedDate = format.parse(dateString);
        if (transaction[i]["wID"] == wID[0][j] &&
            formattedDate.compareTo(fromDate) == 1 &&
            formattedDate.compareTo(toDate) == -1) {
          transactions.add(Transaction(
            transaction[i]["tID"],
            transaction[i]["type"],
            transaction[i]["day"],
            transaction[i]["month"],
            transaction[i]["time"],
            transaction[i]["direction"],
            transaction[i]["amount"],
            transaction[i]["wID"],
          ));
        }
      }
    }
    return transactions;
  }
}
