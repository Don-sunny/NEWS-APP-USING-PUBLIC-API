import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

class GlobalMethod {
  static String formattedDateText(String publishedAt) {
    final parseData = DateTime.parse(publishedAt);
    String formatteDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(parseData);
    DateTime publilshedDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(formatteDate);
    return "${publilshedDate.day}/${publilshedDate.month}/${publilshedDate.year} ON ${publilshedDate.hour}:${publilshedDate.minute}";
  }

  static Future<void> errorDialog(
      {required String errorMessage, required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
            title: (const Row(
              children: [
                Icon(
                  IconlyBold.danger,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('An error occured')
              ],
            )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              )
            ],
          );
        });
  }
}
