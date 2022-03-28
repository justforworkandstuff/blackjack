import 'package:flutter/cupertino.dart';

class Dealer extends ChangeNotifier
{
  int dealerHealth = 100;
  int dealerNum = 0;
  List<String> dealerCard = [];

  void updateDealerHealth(int num)
  {
    dealerHealth += num;
    notifyListeners();
  }

  void updateDealerNum(int uNum)
  {
    dealerNum += uNum;
    notifyListeners();
  }

  void updateDealerCard(String card)
  {
    dealerCard.add(card);
    notifyListeners();
  }

  void restartDealerStats()
  {
    dealerNum = 0;
    dealerCard = [];
    notifyListeners();
  }
}