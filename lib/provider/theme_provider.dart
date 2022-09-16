import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  ThemeProvider({@required this.sharedPreferences}) {
    // _loadCurrentTheme();
  }

  // bool _darkTheme = false;
  bool get darkTheme => Get.isDarkMode;

  // void setTheme(bool dart) {
  //   if (dart) {
  //     _darkTheme = true;
  //   } else {
  //     _darkTheme = false;
  //   }
  //   sharedPreferences.setBool(AppConstants.THEME, _darkTheme);
  //   notifyListeners();
  // }
  //
  void toggleTheme() {
    //   _darkTheme = !_darkTheme;
    //   sharedPreferences.setBool(AppConstants.THEME, _darkTheme);
    //   notifyListeners();
  }
  //
  // void _loadCurrentTheme() async {
  //   _darkTheme =Get.isDarkMode;
  //   notifyListeners();
  // }
}
