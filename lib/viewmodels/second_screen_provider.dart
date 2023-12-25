import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suitmedia_mobile_intern/utils/constants/loading_states.dart';
import 'package:suitmedia_mobile_intern/utils/constants/prefs_keys.dart';

class SecondScreenProvider with ChangeNotifier {
  LoadingState loadingState = LoadingState.initial;
  String? username;

  void getUserName() async {
    try {
      loadingState = LoadingState.loading;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      username = prefs.getString(PrefsKeys.user);

      loadingState = LoadingState.success;
      notifyListeners();
    } catch (e) {
      loadingState = LoadingState.failed;
      notifyListeners();
    }
  }

  void nextScreen(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PrefsKeys.user);

    if (context.mounted) {
      Navigator.pushNamed(context, '/third');
    }
  }
}
