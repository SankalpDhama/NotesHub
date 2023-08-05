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
addStringToSF(String key,String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key,value);
}
Future<String?> getStringValuesSF(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? stringValue = prefs.getString(name);
  return stringValue;
}
// baad mei gauth semester add krdio

removeValuesSF(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove(value);
}