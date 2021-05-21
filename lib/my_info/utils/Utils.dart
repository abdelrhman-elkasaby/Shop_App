import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop_app2/my_info/Alerts/AlertsServices.dart';
import 'package:shop_app2/my_info/base/Injection/Locator.dart';
import 'package:shop_app2/my_info/services/Network/ApiService.dart';
import 'package:shop_app2/my_info/services/Sql/PrefService.dart';


class Utils {
  PrefService pref() => locator<PrefService>();

  ApiService api() => locator<ApiService>();

  AlertsServices alert()=>AlertsServices();



  double onScreenHeight(BuildContext context, {double multiplyBy = 1}) =>
      MediaQuery.of(context).size.height * multiplyBy;

  double onScreenWidth(BuildContext context, {double dividedBy = 1}) =>
      MediaQuery.of(context).size.width / dividedBy;

  String getPlatForm() {
    if (Platform.isAndroid) {
      return "android";
    } else {
      return "ios";
    }
  }

  String convertDigitsToLatin(String s) {
    var sb = new StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
        //Arabic digits
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }


}

// extension translate on String {
//   String localize(BuildContext context) {
//     return AppLocalizations.of(context).translate(this);
//   }
// }

extension image on String {
  String get png => 'assets/icons/$this.png';
  String get svg => 'assets/icons/$this.svg';
  String get jpeg => 'assets/icons/$this.jpeg';
}
