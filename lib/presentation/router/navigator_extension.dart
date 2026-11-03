import 'package:flutter/material.dart';

extension NavigationExtention on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}
