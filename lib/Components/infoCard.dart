import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SelectionDialogBox.dart';

class infoCard extends StatelessWidget {
  infoCard(
      {super.key,
      required this.name,
      required this.list, required this.imageLoc,
      });
  final String name;
  final String imageLoc;
  final List<String> list;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return DialogWidget(data:name,list: list);
          },
        );
      },
      child: Container(
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
                    border: Border.all(
                        width: 10,
                        color: Colors
                            .transparent), //color is transparent so that it does not blend with the actual color specified
                    color: const Color.fromRGBO(0, 0, 0,
                        0.5) // Specifies the background color and the opacity
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