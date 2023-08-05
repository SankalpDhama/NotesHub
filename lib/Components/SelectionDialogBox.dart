
import 'package:flutter/material.dart';

import '../Resources/sharedPreferences.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.list, required this.data,
  });
  final String data;
  final List<String> list;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              addStringToSF(data,"${list[index]}");
              Navigator.of(context, rootNavigator: true).pop();
            },
            child:
            // CircleAvatar(backgroundImage: AssetImage(imageAsset)),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                border: Border.all(),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Center(child: Text("${list[index]}")),
            ),
          );
        },
      ),
    );
  }
}
