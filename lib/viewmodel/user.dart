import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier
{
  int userHealth = 100;
  int userNum = 0;
  List<String> userCard = [];
  bool changeA1 = false;
  bool changeA2 = false;
  bool changeA3 = false;
  bool changeA4 = false;
  bool changeA5 = false;

  void updateHealth(int num)
  {
    userHealth += num;
    notifyListeners();
  }

  void updateUserNum(int uNum)
  {
    userNum += uNum;
    notifyListeners();
  }

  void updateUserCard(String card)
  {
    userCard.add(card);
    notifyListeners();
  }

  void restartStats()
  {
    userNum = 0;
    userCard = [];
    notifyListeners();
  }

  void modifyA1Val()
  {
    changeA1 ? userNum += 9 : userNum -= 9;
    notifyListeners();
  }

  void modifyA2Val()
  {
    changeA2 ? userNum += 9 : userNum -= 9;
    notifyListeners();
  }

  void modifyA3Val()
  {
    changeA3 ? userNum += 9 : userNum -= 9;
    notifyListeners();
  }

  void modifyA4Val()
  {
    changeA4 ? userNum += 9 : userNum -= 9;
    notifyListeners();
  }
  
  void modifyA5Val()
  {
    changeA5 ? userNum += 9 : userNum -= 9;
    notifyListeners();
  }
}