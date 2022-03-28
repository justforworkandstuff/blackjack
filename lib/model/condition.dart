//this class depicts the condition to win and viewing it from the perspectve of the player 
class Condition 
{
  //playerNum > dealerNum || dealerNum > maxVal 
  static const smolValue = 10;
  //playerNum < dealerNum || playerNum > maxVal
  static const smolValueN = -10;
  //player blackjack || double 
  static const medValue = 20;
  //player < 16 || 
  static const medValueN = -20;
  //player 5 cards || double A
  static const highValue = 30;
  //player 5 cards > maxVal
  static const highValueN = -30;
  //player 5 cards blackjack
  static const highestVal = 50;
  //dealer 5 cards blackjack
  static const highestValN = -50;
}