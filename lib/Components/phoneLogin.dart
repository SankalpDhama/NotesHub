import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class phoneLogin extends StatefulWidget {
  const phoneLogin({super.key});

  @override
  State<phoneLogin> createState() => _phoneLoginState();
}

class _phoneLoginState extends State<phoneLogin> {
  TextEditingController countryCode=TextEditingController();
  @override
  void initState(){
    countryCode.text="+91";
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Please Login",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        SizedBox(
          height: 50,
          width: 300,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    controller: countryCode,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Phone"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, "/otp");
            },
            child: Text("Get OTP"),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
