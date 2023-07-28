import 'package:flutter/material.dart';

import '../Resources/AuthService.dart';
class diffSignInComponent extends StatefulWidget {
  const diffSignInComponent({super.key});

  @override
  State<diffSignInComponent> createState() => _diffSignInComponentState();
}

class _diffSignInComponentState extends State<diffSignInComponent> {
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
                onPressed: () => AuthService().signInWithGoogle(),
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
