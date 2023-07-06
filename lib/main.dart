import 'package:flutter/material.dart';
import 'package:journal/core/di.dart';

import 'app.dart';

void main() {
  setUpServiceLocator();
  runApp(const MyApp());
}
