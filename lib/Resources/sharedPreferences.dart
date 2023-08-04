import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> addBoolToSF(String name, bool isLiked) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(name, isLiked);
}

Future<bool> checkBool(String name) async {
  final prefs = await SharedPreferences.getInstance();
  bool pdfIsLiked = prefs.getBool(name) ?? false;
  return pdfIsLiked;
}
// baad mei gauth semester add krdio