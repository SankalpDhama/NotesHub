import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Please Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onCompleted: (pin) => print(pin),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/otp");
              },
              child: Text("Verify"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
              },
              child: Text("Edit Phone Number?"),
            ),
          ],
        ),
      ),
    );
  }
}
