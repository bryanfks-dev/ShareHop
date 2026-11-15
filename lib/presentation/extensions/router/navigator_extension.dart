import 'package:flutter/material.dart';

extension NavigatorExtention on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}
