import 'package:blackjackk/model/cardback.dart';
import 'package:blackjackk/model/cards.dart';
import 'package:blackjackk/model/cardtemplate.dart';
import 'package:blackjackk/viewmodel/numcard.dart';
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
  int rngDealer = 0;
  int userMoney = 1000;
  String endingText = 'Please start';
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
  bool card6 = false;
  bool card7 = false;
  bool card8 = false;
  bool card9 = false;
  bool card10 = false;
  bool shouldDisableButton = false;
  bool firstButtonClick = false;
  bool choose10 = false;
  bool choose1 = false;
  bool chosenOption = true;
  bool hasWon = false;

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
      card6 = false;
      card7 = false;
      card8 = false;
      card9 = false;
      card10 = false;
      usedNum = [];
      shouldDisableButton = false;
      firstButtonClick = false;
      endingText = 'Please start';
      choose10 = false;
      choose1 = false;
      chosenOption = true;
      hasWon = false;
    });
  }

  void numOfCards(int num) {
    switch (num) {
      case 1:
        card1 = true;
        break;
      case 2:
        card2 = true;
        break;
      case 3:
        card3 = true;
        break;
      case 4:
        card4 = true;
        break;
      case 5:
        card5 = true;
        break;
    }
  }

  void numOfCardsDealer(int num) {
    switch (num) {
      case 1:
        card6 = true;
        break;
      case 2:
        card6 = true;
        card7 = true;
        break;
      case 3:
        card6 = true;
        card7 = true;
        card8 = true;
        break;
      case 4:
        card6 = true;
        card7 = true;
        card8 = true;
        card9 = true;
        break;
      case 5:
        card6 = true;
        card7 = true;
        card8 = true;
        card9 = true;
        card10 = true;
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
                    Text(endingText),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //hit button
                        Consumer<NumCard>(
                          builder: (context, numCard, child) {
                            return ElevatedButton(
                                child: const Text('Hit'),
                                onPressed: firstButtonClick
                                    ? shouldDisableButton
                                        ? null
                                        : () {
                                            //as long as the card is not 5 and the val is less than 21, you can reroll
                                            if (userCard.length <= 4 &&
                                                userNum < card.maxVal &&
                                                userNum != card.maxVal) {
                                              setState(() => rngNum =
                                                  Random().nextInt(52));

                                              //if the card is already taken it rerolls
                                              while (usedNum.contains(rngNum)) {
                                                setState(() => rngNum =
                                                    Random().nextInt(52));
                                              }

                                              print('RNG Num Hit: $rngNum');

                                              //if the card is not a duplicate, it keeps the card
                                              if (usedNum.contains(rngNum) ==
                                                  false) {
                                                card.takeCards(rngNum);

                                                //ensures card val 'A' is 11
                                                if (rngNum == 0 ||
                                                    rngNum == 1 ||
                                                    rngNum == 2 ||
                                                    rngNum == 3) {
                                                  if (userNum < 12) {
                                                    chosenOption = false;
                                                  } else {
                                                    card.cardVal = 1;
                                                    userNum += card.cardVal;
                                                  }
                                                } else {
                                                  userNum += card.cardVal;
                                                }
                                                userCard.add(card.cardNum);
                                                usedNum.add(rngNum);

                                                print('User Val: $userNum');
                                                print('User Card: $userCard');
                                                print('Used Num: $usedNum');

                                                //checks if user 5 cards burst
                                                if (userCard.length == 5 &&
                                                    userNum > card.maxVal) {
                                                  print(userMoney);
                                                  userMoney -= 30;
                                                  shouldDisableButton = true;
                                                  print('5 cards burst');
                                                  setState(() => endingText =
                                                      'You failed to survive 5 cards');
                                                  hasWon = true;
                                                }
                                                //checks if user burst
                                                else if (userNum >
                                                    card.maxVal) {
                                                  shouldDisableButton = true;
                                                }
                                                //checks if user reach blackjack
                                                else if (userNum ==
                                                    card.maxVal) {
                                                  shouldDisableButton = true;
                                                }
                                                //checks if user won by blackjack and 5 cards
                                                else if (userCard.length == 5 &&
                                                    userNum == 21) {
                                                  print(userMoney);
                                                  userMoney += 50;
                                                  shouldDisableButton = true;
                                                  print('blackjack 5 cards');
                                                  setState(() => endingText =
                                                      'You won by BlackJack and 5 cards!');
                                                  hasWon = true;
                                                }
                                                //checks if user won by 5 cards
                                                else if (userCard.length == 5 &&
                                                    userNum < card.maxVal) {
                                                  print(userMoney);
                                                  userMoney += 30;
                                                  shouldDisableButton = true;
                                                  print('5 cards');
                                                  setState(() => endingText =
                                                      'You won by 5 cards!');
                                                  hasWon = true;
                                                }

                                                // updates card depending on the card length
                                                switch (userCard.length) {
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
                                                    numOfCardsDealer(
                                                        dealerCard.length);
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
                                    setState(() => endingText = 'Competing..');
                                    //as long as the card is not 4 and the val is less than 21, it rerolls
                                    while (userCard.length != 2) {
                                      print('----');
                                      setState(
                                          () => rngNum = Random().nextInt(52));

                                      print('RNG NUM: $rngNum');
                                      while (usedNum.contains(rngNum)) {
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
                                            //user's first turn for cards
                                            card.takeCards(rngNum);
                                            //ensures card val 'A' is 11
                                            if (rngNum == 0 ||
                                                rngNum == 1 ||
                                                rngNum == 2 ||
                                                rngNum == 3) {
                                              card.cardVal = 11;
                                              userNum += card.cardVal;
                                            } else {
                                              userNum += card.cardVal;
                                            }
                                            userCard.add(card.cardNum);
                                            usedNum.add(rngNum);

                                            print('User Val: $userNum');
                                            print('User Card: $userCard');
                                            print('Used Num: $usedNum');

                                            //updates first card of player
                                            numCard.doSomething(card.flowerVal,
                                                card.cardNum, card.cardColor);

                                            //rerolls for dealer's card
                                            setState(() =>
                                                rngNum = Random().nextInt(52));

                                            //check if its duplicate
                                            while (usedNum.contains(rngNum)) {
                                              print('did it #dealer');
                                              setState(() => rngNum =
                                                  Random().nextInt(52));
                                              print('RNG NUM 2: $rngNum');
                                              print('done it #dealer');
                                            }

                                            if (usedNum.contains(rngNum) ==
                                                false) {
                                              //dealer's first card
                                              card.takeCards(rngNum);
                                              //ensures card val 'A' is 11
                                              if (rngNum == 0 ||
                                                  rngNum == 1 ||
                                                  rngNum == 2 ||
                                                  rngNum == 3) {
                                                card.cardVal = 11;
                                                dealerNum += card.cardVal;
                                              } else {
                                                dealerNum += card.cardVal;
                                              }

                                              dealerCard.add(card.cardNum);
                                              usedNum.add(rngNum);

                                              print('Dealer Val: $dealerNum');
                                              print('Dealer Card: $dealerCard');
                                              print('Used Num: $usedNum');
                                            }

                                            //updates first card of dealer
                                            numCard.doSomething6(card.flowerVal,
                                                card.cardNum, card.cardColor);

                                            print('1st case');
                                            break;
                                          case 1:
                                            //user's second turn for cards
                                            card.takeCards(rngNum);

                                            //ensures card val 'A' is 11
                                            if (rngNum == 0 ||
                                                rngNum == 1 ||
                                                rngNum == 2 ||
                                                rngNum == 3) {
                                              if (userNum < 11) {
                                                card.cardVal = 11;
                                                userNum += card.cardVal;
                                              } else if (userNum == 11) {
                                                card.cardVal = 10;
                                                userNum += card.cardVal;
                                              } else {
                                                card.cardVal = 1;
                                                userNum += card.cardVal;
                                              }
                                            } else {
                                              userNum += card.cardVal;
                                            }

                                            userCard.add(card.cardNum);
                                            usedNum.add(rngNum);

                                            print('User Val: $userNum');
                                            print('User Card: $userCard');
                                            print('Used Num: $usedNum');

                                            //updates 2nd card for user
                                            numCard.doSomething2(card.flowerVal,
                                                card.cardNum, card.cardColor);

                                            //2nd turn for dealer
                                            setState(() =>
                                                rngNum = Random().nextInt(52));

                                            //check if its duplicate
                                            while (usedNum.contains(rngNum)) {
                                              print('did it #dealer');
                                              setState(() => rngNum =
                                                  Random().nextInt(52));
                                              print('RNG NUM 2: $rngNum');
                                              print('done it #dealer');
                                            }

                                            if (usedNum.contains(rngNum) ==
                                                false) {
                                              //dealer's second card
                                              card.takeCards(rngNum);

                                              //ensures card val 'A' is 11
                                              if (rngNum == 0 ||
                                                  rngNum == 1 ||
                                                  rngNum == 2 ||
                                                  rngNum == 3) {
                                                if (dealerNum <
                                                    11) // 10, 9, 8..
                                                {
                                                  card.cardVal = 11;
                                                  dealerNum += card.cardVal;
                                                } else if (dealerNum == 11) {
                                                  card.cardVal = 10;
                                                  dealerNum += card.cardVal;
                                                } else {
                                                  card.cardVal = 1;
                                                  dealerNum += card.cardVal;
                                                }
                                              } else {
                                                dealerNum += card.cardVal;
                                              }

                                              dealerCard.add(card.cardNum);
                                              usedNum.add(rngNum);

                                              print('Dealer Val: $dealerNum');
                                              print('Dealer Card: $dealerCard');
                                              print('Used Num: $usedNum');

                                              //updates second card of dealer
                                              numCard.doSomething7(
                                                  card.flowerVal,
                                                  card.cardNum,
                                                  card.cardColor);

                                              //checks if both double 'A'
                                              if (userCard[0] == 'A' &&
                                                  userCard[1] == 'A' &&
                                                  dealerCard[0] == 'A' &&
                                                  dealerCard[1] == 'A') {
                                                shouldDisableButton = true;
                                                print('both double A');
                                                setState(() => endingText =
                                                    'A draw by double A!');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                              //checks if user double A
                                              else if (userCard[0] == 'A' &&
                                                  userCard[1] == 'A') {
                                                print(userMoney);
                                                userMoney += 30;
                                                shouldDisableButton = true;
                                                print('double A');
                                                setState(() => endingText =
                                                    'You won by double A!');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                              //checks if dealer double A
                                              else if (dealerCard[0] == 'A' &&
                                                  dealerCard[1] == 'A') {
                                                print(userMoney);
                                                userMoney -= 30;
                                                shouldDisableButton = true;
                                                print('dealer double A');
                                                setState(() => endingText =
                                                    'Dealer won by double A!');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                              //checks if both are blackjack for draw
                                              else if (userNum == 21 &&
                                                  dealerNum == 21) {
                                                shouldDisableButton = true;
                                                print('both blackjack 2 cards');
                                                setState(() => endingText =
                                                    'A draw by BlackJack!');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                              //checks if both are double for draw
                                              else if (userCard[0] ==
                                                      userCard[1] &&
                                                  dealerCard[0] ==
                                                      dealerCard[1]) {
                                                shouldDisableButton = true;
                                                print('both double!');
                                                setState(() => endingText =
                                                    'A draw by Double');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                              //checks if user blackjack
                                              else if (userCard.length == 2 &&
                                                  userNum == 21) {
                                                print(userMoney);
                                                userMoney += 20;
                                                shouldDisableButton = true;
                                                print('blackjack by 2 cards');
                                                setState(() => endingText =
                                                    'You won by BlackJack!');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                              //checks if dealer blackjack
                                              else if (dealerCard.length == 2 &&
                                                  dealerNum == 21) {
                                                print(userMoney);
                                                userMoney -= 20;
                                                shouldDisableButton = true;
                                                print(
                                                    'dealer blackjack 2 cards');
                                                setState(() => endingText =
                                                    'Dealer BlackJack');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              } //checks if user double
                                              else if (userCard.length == 2 &&
                                                  userCard[0] == userCard[1]) {
                                                print(userMoney);
                                                userMoney += 20;
                                                shouldDisableButton = true;
                                                print('double');
                                                setState(() => endingText =
                                                    'You won by double!');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                              //checks if dealer double
                                              else if (dealerCard.length == 2 &&
                                                  dealerCard[0] ==
                                                      dealerCard[1]) {
                                                print(userMoney);
                                                userMoney -= 20;
                                                shouldDisableButton = true;
                                                print('dealer double');
                                                setState(() => endingText =
                                                    'Dealer Double');
                                                hasWon = true;
                                                numOfCardsDealer(
                                                    dealerCard.length);
                                              }
                                            }
                                            print('2nd case');
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
                        //user hold
                        Consumer<NumCard>(builder: (context, numCard, child) {
                          return ElevatedButton(
                              onPressed: firstButtonClick
                                  ? hasWon
                                      ? null
                                      : () {
                                          print('User start hold');
                                          setState(
                                              () => shouldDisableButton = true);

                                          //dealer's actions
                                          //smaller value stuff
                                          while (dealerNum < card.minVal &&
                                              dealerCard.length <= 4) {
                                            setState(() =>
                                                rngNum = Random().nextInt(52));

                                            //if the card is already taken it rerolls
                                            while (usedNum.contains(rngNum)) {
                                              setState(() => rngNum =
                                                  Random().nextInt(52));
                                            }

                                            //if the card is not a duplicate, it keeps the card
                                            if (usedNum.contains(rngNum) ==
                                                false) {
                                              //dealer takes card
                                              card.takeCards(rngNum);
                                              //ensures card val 'A' is 11
                                              if (rngNum == 0 ||
                                                  rngNum == 1 ||
                                                  rngNum == 2 ||
                                                  rngNum == 3) {
                                                if (dealerNum < 12) {
                                                  card.cardVal = 10;
                                                  dealerNum += card.cardVal;
                                                  dealerCard.add(card.cardNum);
                                                  usedNum.add(rngNum);
                                                } else {
                                                  card.cardVal = 1;
                                                  dealerNum += card.cardVal;
                                                  dealerCard.add(card.cardNum);
                                                  usedNum.add(rngNum);
                                                }
                                              } else {
                                                dealerNum += card.cardVal;
                                                dealerCard.add(card.cardNum);
                                                usedNum.add(rngNum);
                                              }
                                              print('Dealer Num: $dealerNum');
                                              print('Dealer Card: $dealerCard');
                                              print('Used Num: $usedNum');
                                              print('dealer<minVal');

                                              switch (dealerCard.length) {
                                                case 3:
                                                  numCard.doSomething8(
                                                      card.flowerVal,
                                                      card.cardNum,
                                                      card.cardColor);
                                                  break;
                                                case 4:
                                                  numCard.doSomething9(
                                                      card.flowerVal,
                                                      card.cardNum,
                                                      card.cardColor);
                                                  break;
                                                case 5:
                                                  numCard.doSomething10(
                                                      card.flowerVal,
                                                      card.cardNum,
                                                      card.cardColor);
                                                  break;
                                              }
                                            }
                                          }
                                          //higher value stuff
                                          if (dealerNum >= card.minVal &&
                                              dealerNum < card.dealerVal &&
                                              dealerCard.length <= 4) {
                                            setState(() => rngDealer =
                                                Random().nextInt(2));
                                            switch (rngDealer) {
                                              case 0:
                                                setState(() => rngNum =
                                                    Random().nextInt(52));

                                                while (
                                                    usedNum.contains(rngNum)) {
                                                  setState(() => rngNum =
                                                      Random().nextInt(52));
                                                }

                                                if (usedNum.contains(rngNum) ==
                                                    false) {
                                                  //dealer takes card
                                                  card.takeCards(rngNum);
                                                  //modifying card A value
                                                  if (rngNum == 0 ||
                                                      rngNum == 1 ||
                                                      rngNum == 2 ||
                                                      rngNum == 3) {
                                                    if (dealerNum < 12) {
                                                      card.cardVal = 10;
                                                      dealerCard
                                                          .add(card.cardNum);
                                                      dealerNum += card.cardVal;
                                                    } else {
                                                      card.cardVal = 1;
                                                      dealerCard
                                                          .add(card.cardNum);
                                                      dealerNum += card.cardVal;
                                                    }
                                                  } else {
                                                    dealerNum += card.cardVal;
                                                    dealerCard
                                                        .add(card.cardNum);
                                                    usedNum.add(rngNum);
                                                  }
                                                  print(
                                                      'Dealer Num: $dealerNum');
                                                  print(
                                                      'Dealer Card: $dealerCard');
                                                  print('Used Num: $usedNum');
                                                  print('dealer dare dare take');

                                                  switch (dealerCard.length) {
                                                    case 3:
                                                      numCard.doSomething8(
                                                          card.flowerVal,
                                                          card.cardNum,
                                                          card.cardColor);
                                                      break;
                                                    case 4:
                                                      numCard.doSomething9(
                                                          card.flowerVal,
                                                          card.cardNum,
                                                          card.cardColor);
                                                      break;
                                                    case 5:
                                                      numCard.doSomething10(
                                                          card.flowerVal,
                                                          card.cardNum,
                                                          card.cardColor);
                                                      break;
                                                  }
                                                }
                                                break;
                                              case 1:
                                                print('skip chance');
                                                break;
                                            }
                                          }

                                          //if user has less than 16 and holds
                                          if (userNum < card.minVal) {
                                            print(userMoney);
                                            userMoney -= 20;
                                            setState(() => endingText =
                                                'You lost as your card number is less than 16!');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //check if dealer 5 cards burst
                                          else if (dealerCard.length == 5 &&
                                              dealerNum > card.maxVal) {
                                            print(userMoney);
                                            userMoney += 30;
                                            shouldDisableButton = true;
                                            print('dealer 5 cards burst');
                                            setState(() => endingText =
                                                'Dealer 5 cards burst');
                                            hasWon = true;
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //checks if both burst
                                          else if (userNum > card.maxVal &&
                                              dealerNum > card.maxVal) {
                                            shouldDisableButton = true;
                                            print('both burst');
                                            setState(() => endingText =
                                                'A draw! Both burst!');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //checks if both are same number for draw
                                          else if (userNum == dealerNum) {
                                            shouldDisableButton = true;
                                            print('both same');
                                            setState(
                                                () => endingText = 'A draw!');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //checks if dealer won by blackjack and 5 cards
                                          else if (dealerCard.length == 5 &&
                                              dealerNum == 21) {
                                            print(userMoney);
                                            userMoney -= 50;
                                            shouldDisableButton = true;
                                            print('dealer blackjackk 5 cards');
                                            setState(() => endingText =
                                                'Dealer won by BlackJack and 5 cards!');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //checks if dealer won by 5 cards
                                          else if (dealerCard.length == 5 &&
                                              dealerNum > card.minVal &&
                                              dealerNum < card.maxVal) {
                                            print(userMoney);
                                            userMoney -= 30;
                                            shouldDisableButton = true;
                                            print('dealer 5 cards');
                                            setState(() => endingText =
                                                'Dealer won by 5 cards!');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //checks if user won by blackjack
                                          else if (userNum == 21) {
                                            print(userMoney);
                                            userMoney += 20;
                                            shouldDisableButton = true;
                                            print('blackjack');
                                            endingText =
                                                'You won by BlackJack!';
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //checks if dealer blackjack
                                          else if (dealerNum == 21) {
                                            print(userMoney);
                                            userMoney -= 20;
                                            shouldDisableButton = true;
                                            print('dealer blackjackk');
                                            setState(() => endingText =
                                                'Dealer BlackJack');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                          //user having higher score than dealer after everything
                                          else if (userNum > dealerNum &&
                                              userNum < card.maxVal) {
                                            shouldDisableButton = true;
                                            print(userMoney);
                                            userMoney += 10;
                                            setState(() => endingText =
                                                'You won the dealer by having a higher score!');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          } //dealer having higher score after everything
                                          else if (userNum < dealerNum &&
                                              dealerNum < card.maxVal) {
                                            shouldDisableButton = true;
                                            print(userMoney);
                                            userMoney -= 10;
                                            setState(
                                                () => endingText = 'You lost');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          } //dealer burst
                                          else if (dealerNum > card.maxVal) {
                                            shouldDisableButton = true;
                                            print(userMoney);
                                            userMoney += 10;
                                            setState(() =>
                                                endingText = 'Dealer burst.');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          } //userNum exceed maxVal
                                          else if (userNum > card.maxVal) {
                                            shouldDisableButton = true;
                                            print(userMoney);
                                            userMoney -= 10;
                                            setState(
                                                () => endingText = 'You burst');
                                            hasWon = true;
                                            //show the num of cards as per the current card length
                                            numOfCardsDealer(dealerCard.length);
                                          }
                                        }
                                  : null,
                              child: const Text('Hold'));
                        }),
                      ],
                    ),
                    //buttons for 'A' value selections
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //choose 10 button
                        Visibility(
                          visible: firstButtonClick,
                          child: ElevatedButton(
                            child: const Text('Choose as 10'),
                            onPressed: chosenOption
                                ? null
                                : userNum > 11
                                    ? null
                                    : () {
                                        setState(() => choose10 = true);
                                        setState(() => chosenOption = true);
                                        if (choose10 == true) {
                                          card.cardVal = 10;
                                          userNum += card.cardVal;
                                          choose10 = false;
                                        }
                                      },
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        //choose 1 button
                        Visibility(
                          visible: firstButtonClick,
                          child: ElevatedButton(
                            child: const Text('Choose as 1'),
                            onPressed: chosenOption
                                ? null
                                : () {
                                    setState(() => choose1 = true);
                                    setState(() => chosenOption = true);
                                    if (choose1 == true) {
                                      card.cardVal = 1;
                                      userNum += card.cardVal;
                                      choose1 = false;
                                    }
                                  },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    //dealer's cards and dealerNum
                    Stack(
                      children: [
                        Consumer<NumCard>(
                          builder: (context, numCard, child) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  card6
                                      ? Visibility(
                                          visible: card6,
                                          child: CardTemplate(
                                            flower: numCard.flower6,
                                            num: numCard.num6,
                                            color: numCard.color6,
                                          ),
                                        )
                                      : const CardBack(),
                                  card7
                                      ? Visibility(
                                          visible: card7,
                                          child: CardTemplate(
                                            flower: numCard.flower7,
                                            num: numCard.num7,
                                            color: numCard.color7,
                                          ),
                                        )
                                      : const CardBack(),
                                  card8
                                      ? Visibility(
                                          visible: card8,
                                          child: CardTemplate(
                                            flower: numCard.flower8,
                                            num: numCard.num8,
                                            color: numCard.color8,
                                          ),
                                        )
                                      : const CardBack(),
                                  card9
                                      ? Visibility(
                                          visible: card9,
                                          child: CardTemplate(
                                            flower: numCard.flower9,
                                            num: numCard.num9,
                                            color: numCard.color9,
                                          ),
                                        )
                                      : const CardBack(),
                                  card10
                                      ? Visibility(
                                          visible: card10,
                                          child: CardTemplate(
                                            flower: numCard.flower10,
                                            num: numCard.num10,
                                            color: numCard.color10,
                                          ),
                                        )
                                      : const CardBack(),
                                ],
                              ),
                            );
                          },
                        ),
                        //dealerNum text
                        Visibility(
                          visible: hasWon,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                dealerNum.toString(),
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    //user's cards and userNum
                    Stack(
                      children: [
                        Consumer<NumCard>(
                          builder: (context, numCard, child) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  card1
                                      ? Visibility(
                                          visible: card1,
                                          child: CardTemplate(
                                            flower: numCard.flower,
                                            num: numCard.num,
                                            color: numCard.color,
                                          ),
                                        )
                                      : const CardBack(),
                                  card2
                                      ? Visibility(
                                          visible: card2,
                                          child: CardTemplate(
                                            flower: numCard.flower2,
                                            num: numCard.num2,
                                            color: numCard.color2,
                                          ),
                                        )
                                      : const CardBack(),
                                  card3
                                      ? Visibility(
                                          visible: card3,
                                          child: CardTemplate(
                                            flower: numCard.flower3,
                                            num: numCard.num3,
                                            color: numCard.color3,
                                          ),
                                        )
                                      : const CardBack(),
                                  card4
                                      ? Visibility(
                                          visible: card4,
                                          child: CardTemplate(
                                            flower: numCard.flower4,
                                            num: numCard.num4,
                                            color: numCard.color4,
                                          ),
                                        )
                                      : const CardBack(),
                                  card5
                                      ? Visibility(
                                          visible: card5,
                                          child: CardTemplate(
                                            flower: numCard.flower5,
                                            num: numCard.num5,
                                            color: numCard.color5,
                                          ),
                                        )
                                      : const CardBack(),
                                ],
                              ),
                            );
                          },
                        ),
                        //userNum text
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
