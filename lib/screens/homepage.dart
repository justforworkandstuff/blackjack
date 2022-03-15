import 'package:blackjackk/model/cards.dart';
import 'package:blackjackk/model/cardtemplate.dart';
import 'package:blackjackk/model/numcard.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rngNum = 0;
  var card = Cards();
  List<int> usedNum = [];
  int userNum = 0;
  List<String> userCard = [];
  int dealerNum = 0;
  List<String> dealerCard = [];
  bool card1 = false;
  bool card2 = false;
  bool card3 = false;
  bool card4 = false;
  bool card5 = false;
  int userMoney = 1000;
  bool shouldDisableButton = false;
  bool firstButtonClick = false;
  String endingText = 'Please start';

  void restartGame() {
    setState(() {
      card.userVal = 0;
      userNum = 0;
      userCard = [];
      dealerNum = 0;
      dealerCard = [];
      card1 = false;
      card2 = false;
      card3 = false;
      card4 = false;
      card5 = false;
      usedNum = [];
      shouldDisableButton = false;
      firstButtonClick = false;
      endingText = 'Please start';
    });
  }

  void numOfCards(int num) {
    switch (num) {
      case 1:
        card1 = true;
        print('show card1');
        break;
      case 2:
        card2 = true;
        print('show card2');
        break;
      case 3:
        card3 = true;
        print('show card3');
        break;
      case 4:
        card4 = true;
        print('show card4');
        break;
      case 5:
        card5 = true;
        print('show card5');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NumCard(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blackjack'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('RNG Number'),
                    Text('$rngNum'),
                    const SizedBox(height: 10.0),
                    const Text('User Current Money'),
                    Text(userMoney.toString()),
                    const SizedBox(height: 10.0),
                    Stack(
                      children: [
                        Consumer<NumCard>(
                          builder: (context, numCard, child) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: card1,
                                    child: CardTemplate(
                                      flower: numCard.flower,
                                      num: numCard.num,
                                      color: numCard.color,
                                    ),
                                  ),
                                  Visibility(
                                    visible: card2,
                                    child: CardTemplate(
                                      flower: numCard.flower2,
                                      num: numCard.num2,
                                      color: numCard.color2,
                                    ),
                                  ),
                                  Visibility(
                                    visible: card3,
                                    child: CardTemplate(
                                      flower: numCard.flower3,
                                      num: numCard.num3,
                                      color: numCard.color3,
                                    ),
                                  ),
                                  Visibility(
                                    visible: card4,
                                    child: CardTemplate(
                                      flower: numCard.flower4,
                                      num: numCard.num4,
                                      color: numCard.color4,
                                    ),
                                  ),
                                  Visibility(
                                    visible: card5,
                                    child: CardTemplate(
                                      flower: numCard.flower5,
                                      num: numCard.num5,
                                      color: numCard.color5,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              userNum.toString(),
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(endingText),
                    // userNum > card.maxVal
                    //     ? const Text('You lost.')
                    //     : userNum < card.maxVal && userCard.length == 5
                    //         ? const Text('You won by max card length!')
                    //         : userCard.length == 2 &&
                    //                 userCard[0] == userCard[1]
                    //             ? const Text('You won by Double!')
                    //             : userNum == card.maxVal
                    //                 ? const Text('You won by BlackJack!')
                    //                 : const Text('You have a chance!'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //hit button
                        Consumer<NumCard>(
                          builder: (context, numCard, child) {
                            return ElevatedButton(
                                child: const Text('Click'),
                                onPressed: firstButtonClick
                                    ? shouldDisableButton
                                        ? null
                                        : () {
                                            //as long as the card is not 5 and the val is less than 21, you can reroll
                                            if (userCard.length<= 4 &&
                                                userNum < card.maxVal) {
                                              setState(() => rngNum =
                                                  Random().nextInt(52));

                                              //if the card is already taken it rerolls
                                              if (usedNum.contains(rngNum)) {
                                                setState(() => rngNum =
                                                    Random().nextInt(52));
                                              }

                                              //if the card is not a duplicate, it keeps the card
                                              if (usedNum.contains(rngNum) ==
                                                  false) {
                                                card.takeCards(rngNum);
                                                userNum += card.cardVal;
                                                userCard.add(card.cardNum);
                                                usedNum.add(rngNum);

                                                if (userNum > card.maxVal) {
                                                  userMoney -= 10;
                                                  shouldDisableButton = true;
                                                  print('lose');
                                                }
                                                if (userCard.length == 5 &&
                                                    userNum == 21) {
                                                  print(userMoney);
                                                  userMoney += 50;
                                                  shouldDisableButton = true;
                                                  print('blackjack 5 cards');
                                                }
                                                if (userNum == 21) {
                                                  print(userMoney);
                                                  userMoney += 20;
                                                  shouldDisableButton = true;
                                                  print('blackjack');
                                                }
                                                if (userCard.length == 5 &&
                                                    userNum <
                                                        card.maxVal) {
                                                  print(userMoney);
                                                  userMoney += 30;
                                                  shouldDisableButton = true;
                                                  print('5 cards');
                                                }

                                                // updates card depending on the card length
                                                switch (userCard.length) 
                                                {
                                                  case 3:
                                                    numCard.doSomething3(
                                                        card.flowerVal,
                                                        card.cardNum,
                                                        card.cardColor);
                                                    break;
                                                  case 4:
                                                    numCard.doSomething4(
                                                        card.flowerVal,
                                                        card.cardNum,
                                                        card.cardColor);
                                                    break;
                                                  case 5:
                                                    numCard.doSomething5(
                                                        card.flowerVal,
                                                        card.cardNum,
                                                        card.cardColor);
                                                    break;
                                                }
                                              }

                                              //show the num of cards as per the current card length
                                              numOfCards(userCard.length);
                                            } else {
                                              shouldDisableButton = true;
                                            }
                                          }
                                    : null);
                          },
                        ),
                        const SizedBox(width: 15.0),
                        //restart
                        ElevatedButton(
                          child: const Text('Restart'),
                          onPressed: () {
                            restartGame();
                          },
                        ),
                      ],
                    ),
                    //start button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<NumCard>(builder: (context, numCard, child) {
                          return ElevatedButton(
                            child: const Text('Start'),
                            onPressed: firstButtonClick
                                ? null
                                : () {
                                    //as long as the card is not 4 and the val is less than 21, it rerolls
                                    while(userCard.length != 2) {
                                      print('----');
                                      setState(
                                          () => rngNum = Random().nextInt(52));

                                      print('RNG NUM: $rngNum');    
                                      if (usedNum.contains(rngNum)) {
                                        print('did it');
                                        setState(() =>
                                            rngNum = Random().nextInt(52));
                                        print('RNG NUM 2: $rngNum');
                                        print('done it');    
                                      }  

                                      if (usedNum.contains(rngNum) == false) {
                                        //makes sure everyone is getting dealed before ending with dealer
                                        switch (dealerCard.length) {
                                          case 0:
                                            card.takeCards(rngNum);
                                            userNum += card.cardVal;
                                            userCard.add(card.cardNum);
                                            usedNum.add(rngNum);

                                            print('User Val: $userNum');
                                            print('User Card: $userCard');
                                            print('Used Num: $usedNum');

                                            //shows first card of player
                                            numCard.doSomething(card.flowerVal,
                                                card.cardNum, card.cardColor);

                                            //rerolls for dealer's card
                                            setState(() =>
                                                rngNum = Random().nextInt(52));
                                            card.takeCards(rngNum);
                                            dealerNum += card.cardVal;
                                            dealerCard.add(card.cardNum);
                                            usedNum.add(rngNum);

                                            print('Dealer Val: $dealerNum');
                                            print('Dealer Card: $dealerCard');
                                            print('Used Num: $usedNum');

                                            print('1st case');
                                            break;
                                          case 1:
                                            card.takeCards(rngNum);
                                            userNum += card.cardVal;
                                            userCard.add(card.cardNum);
                                            usedNum.add(rngNum);

                                            print('User Val: $userNum');
                                            print('User Card: $userCard');
                                            print('Used Num: $usedNum');

                                            numCard.doSomething2(card.flowerVal,
                                                card.cardNum, card.cardColor);

                                            setState(() =>
                                                rngNum = Random().nextInt(52));
                                            card.takeCards(rngNum);
                                            dealerNum += card.cardVal;
                                            dealerCard.add(card.cardNum);
                                            usedNum.add(rngNum);

                                            print('Dealer Val: $dealerNum');
                                            print('Dealer Card: $dealerCard');
                                            print('Used Num: $usedNum');

                                            print('2nd case');

                                            if (userCard.length == 2 &&
                                                userNum == 21) {
                                              print(userMoney);
                                              userMoney += 20;
                                              shouldDisableButton = true;
                                              print('blackjack 2 cards');
                                              setState(() => endingText = 'You won by BlackJack!');
                                            } else if (userCard.length == 2 &&
                                                userCard[0] == userCard[1]) {
                                              print(userMoney);
                                              userMoney += 20;
                                              shouldDisableButton = true;
                                              print('double');
                                              setState(() => endingText = 'You won by double!');
                                            } else if (dealerCard.length == 2 &&
                                                dealerNum == 21) {
                                              shouldDisableButton = true;
                                              print('dealer blackjack 2 cards');
                                              setState(() => endingText = 'Dealer BlackJack');
                                            } else if (dealerCard.length == 2 &&
                                                dealerCard[0] ==
                                                    dealerCard[1]) {
                                              shouldDisableButton = true;
                                              print('dealer double');
                                              setState(() => endingText = 'Dealer Double');
                                            }
                                            break;
                                        }
                                      }

                                      //show the num of cards as per the current card length
                                      numOfCards(userCard.length);
                                    }
                                    firstButtonClick = true;
                                  },
                          );
                        }),
                        const SizedBox(width: 15.0),
                        //hold cards
                        ElevatedButton(
                            onPressed: firstButtonClick
                                ? () {
                                    setState(() => shouldDisableButton = true);
                                    if(userNum > dealerNum && userNum < card.maxVal)
                                    {
                                      setState(() => endingText = 'You won the dealer by having a higher score!');
                                    }
                                    if(userNum < dealerNum)
                                    {
                                      setState(() => endingText = 'You lost');
                                    }
                                  }
                                : null,
                            child: const Text('Hold')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
