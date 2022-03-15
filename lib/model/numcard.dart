import 'package:flutter/material.dart';

class NumCard extends ChangeNotifier
{
  //1st
  String flower = '♠';
  String num = '0';
  Color color = Colors.black;
  //2nd
  String flower2 = '♠';
  String num2 = '0';
  Color color2 = Colors.black;
  //3rd
  String flower3 = '♠';
  String num3 = '0';
  Color color3 = Colors.black;
  //4th
  String flower4 = '♠';
  String num4 = '0';
  Color color4 = Colors.black;
  //5th
  String flower5 = '♠';
  String num5 = '0';
  Color color5 = Colors.black;

  void doSomething(String flower1st, String num1st, Color color1st)
  {
    flower = flower1st;
    num = num1st; 
    color = color1st;
    notifyListeners();
  }

  void doSomething2(String flower2nd, String num2nd, Color color2nd)
  {
    flower2 = flower2nd;
    num2 = num2nd; 
    color2 = color2nd;
    notifyListeners();
  }

  void doSomething3(String flower3rd, String num3rd, Color color3rd)
  {
    flower3 = flower3rd;
    num3 = num3rd; 
    color3 = color3rd;
    notifyListeners();
  }

  void doSomething4(String flower4th, String num4th, Color color4th)
  {
    flower4 = flower4th;
    num4 = num4th; 
    color4 = color4th;
    notifyListeners();
  }

  void doSomething5(String flower5th, String num5th, Color color5th)
  {
    flower5 = flower5th;
    num5 = num5th; 
    color5 = color5th;
    notifyListeners();
  }
}