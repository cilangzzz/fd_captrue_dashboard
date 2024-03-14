import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shortcut {
  IconData scIcon = Icons.abc;
  final String scName;
  final String scUrl;
  String delay = "999";

  Shortcut(this.scName, this.scUrl);
}
