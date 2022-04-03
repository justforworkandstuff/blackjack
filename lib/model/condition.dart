//this class depicts the condition to win and viewing it from the perspectve of the player 
class Condition 
{
  //playerNum > dealerNum || dealerNum > maxVal 
  final smolValue = 10;
  //playerNum < dealerNum || playerNum > maxVal
  final smolValueN = -10;
  //player blackjack || double 
  final medValue = 20;
  //player < 16 || 
  final medValueN = -20;
  //player 5 cards || double A
  final highValue = 30;
  //player 5 cards > maxVal
  final highValueN = -30;
  //player 5 cards blackjack
  final highestVal = 50;
  //dealer 5 cards blackjack
  final highestValN = -50;
}