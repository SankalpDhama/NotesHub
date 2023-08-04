import 'package:flutter/material.dart';

import '../Resources/AuthService.dart';
class DiffSignInComponent extends StatefulWidget {
  const DiffSignInComponent({super.key});

  @override
  State<DiffSignInComponent> createState() => _DiffSignInComponentState();
}

class _DiffSignInComponentState extends State<DiffSignInComponent> {
  final AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Sign in with other methods animated rotate to use"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async{
                  bool res= await AuthService().signInWithGoogle(context);
                  if(res){
                    Navigator.pushNamed(context,'/select');
                  }else{

                  }
                },
                child: Image.asset('assets/images/logo/googlelogo.png',
                    height: 20, width: 20),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Image.asset('assets/images/logo/githublogo.png',
                    height: 20, width: 20),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Image.asset('assets/images/logo/facebooklogo.png',
                    height: 20, width: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
