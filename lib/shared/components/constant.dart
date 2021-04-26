

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/local/chach_helper.dart';

void signOut(context)
{
  TextButton(
    onPressed: () {
      CacheHelper.clearData(key: 'token').then((value) {
        if (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
      });
    },
    child: Text('LOgout'),
  );
}

String token = '';