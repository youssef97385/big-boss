

import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../app/logic/app_settings.dart';
import '../../injection.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {

        String? token = serviceLocator<AppSettings>().token;

        if (token?.isEmpty ?? true) {
          context.router.replace(const LoginPageAppRouter());
        } else {
          context.router.replace(const MainAppRouter());
        }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 300,
              child: Image.asset(
                "assets/images/big-boss-splash-logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

        ],
      ),
    );
  }

}
