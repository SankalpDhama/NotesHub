import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteshub/constant/colors.dart';
import 'package:noteshub/selectFetchFirebase.dart';


class infoCard extends StatelessWidget {
   infoCard({super.key, required this.name, required this.imageLoc, required this.collectionName});
  final String name;
  final String imageLoc;
  final String collectionName;
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              elevation: 16,
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    selectFetch(s:collectionName),
                  ],
                ),
              ),
            );
          },
        );
      },
      child:  Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imageLoc,
                // color: Colors.pinkAccent,
                // colorBlendMode: BlendMode.darken,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              Align(
                // baad mei dekhlio center mei kese kre
                alignment: Alignment.bottomRight,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 10 ,color: Colors.transparent), //color is transparent so that it does not blend with the actual color specified
                      color: const Color.fromRGBO(0, 0, 0, 0.5) // Specifies the background color and the opacity
                  ),
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

Widget _buildRow(String imageAsset, String name, double score) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12),
        Container(height: 2, color: Colors.redAccent),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            CircleAvatar(backgroundImage: AssetImage(imageAsset)),
            SizedBox(width: 12),
            Text(name),
            Spacer(),
            Container(
              decoration: BoxDecoration(color: Colors.yellow[900], borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text('$score'),
            ),
          ],
        ),
      ],
    ),
  );
}