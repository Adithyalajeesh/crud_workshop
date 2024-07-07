
import 'package:flutter/cupertino.dart';

class ThemeServiceProvider extends ChangeNotifier{

  bool isDarkModeOn= false;

  void toggleTheme(){

    isDarkModeOn= !isDarkModeOn;
    notifyListeners();
  }

}