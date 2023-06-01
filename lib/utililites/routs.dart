import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushAndRemoveUntil(
      {required BuildContext context, required Widget newScreen}) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => newScreen), (route) => false);
  }

  Future<dynamic> push(
      {required BuildContext context, required Widget newScreen}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }
}
