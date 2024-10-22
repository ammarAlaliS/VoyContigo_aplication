import 'package:flutter/services.dart';

void setSystemUIOverlayStyle({
  required Color statusBarColor,
  required Color systemNavigationBarColor,
  required Brightness statusBarIconBrightness,
  required Brightness systemNavigationBarIconBrightness,
}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarIconBrightness: statusBarIconBrightness,
    systemNavigationBarColor: systemNavigationBarColor,
    systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
  ));
}
