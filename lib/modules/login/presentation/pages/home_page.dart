import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.brown,
              )),
        ),
        body: Center(
          child: Text('home'),
        ),
      ),
    );
  }
}
