import 'package:blackjackk/model/cardback.dart';
import 'package:blackjackk/model/cards.dart';
import 'package:blackjackk/model/cardtemplate.dart';
import 'package:blackjackk/viewmodel/dealer.dart';
import 'package:blackjackk/viewmodel/numcard.dart';
import 'package:blackjackk/viewmodel/user.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const rngMax = 52;
  int rngNum = 0;
  int rngDealer = 0;
  String endingText = 'Please start';
  var card = Cards();
  List<int> usedNum = [];
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
  bool hasWon = false;
  bool hasBeenPressed = false;
  bool hasBeenPressed2 = false;
  bool hasBeenPressed3 = false;
  bool hasBeenPressed4 = false;
  bool hasBeenPressed5 = false;

  void restartGame() {
    setState(() {
      card.userVal = 0;
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
      hasWon = false;
      hasBeenPressed = false;
      hasBeenPressed2 = false;
      hasBeenPressed3 = false;
      hasBeenPressed4 = false;
      hasBeenPressed5 = false;
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NumCard>(create: (context) => NumCard()),
        ChangeNotifierProvider<User>(create: (context) => User()),
        ChangeNotifierProvider<Dealer>(create: (context) => Dealer()),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      //dealer's health bar
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.blue,
                                ),
                              ),
                              Consumer<Dealer>(
                                builder: (context, dealer, child) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        dealer.dealerHealth /
                                        100,
                                    color: Colors.green,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Text('User Current Health'),
                      Consumer<User>(builder: (context, user, child) {
                        return Text(user.userHealth.toString());
                      }),
                      const SizedBox(height: 10.0),
                      Text(endingText),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //hit button
                          Consumer3<NumCard, User, Dealer>(
                            builder: (context, numCard, user, dealer, child) {
                              return ElevatedButton(
                                  child: const Text('Hit'),
                                  onPressed: firstButtonClick
                                      ? shouldDisableButton
                                          ? null
                                          : () {
                                              //as long as the card is not 5 and the val is less than 21, you can reroll
                                              if (user.userCard.length <= 4 &&
                                                  user.userNum < card.maxVal &&
                                                  user.userNum != card.maxVal) {
                                                setState(() => rngNum =
                                                    Random().nextInt(rngMax));

                                                //if the card is already taken it rerolls
                                                while (
                                                    usedNum.contains(rngNum)) {
                                                  setState(() => rngNum =
                                                      Random().nextInt(rngMax));
                                                }

                                                //if the card is not a duplicate, it keeps the card
                                                if (usedNum.contains(rngNum) ==
                                                    false) {
                                                  card.takeCards(rngNum);

                                                  //ensures card val 'A' is 11
                                                  if (rngNum == 0 ||
                                                      rngNum == 1 ||
                                                      rngNum == 2 ||
                                                      rngNum == 3) {
                                                    card.cardVal = 1;
                                                    user.userNum +=
                                                        card.cardVal;
                                                  } else {
                                                    user.userNum +=
                                                        card.cardVal;
                                                  }
                                                  user.userCard
                                                      .add(card.cardNum);
                                                  usedNum.add(rngNum);

                                                  //checks if user 5 cards burst
                                                  if (user.userCard.length ==
                                                          5 &&
                                                      user.userNum >
                                                          card.maxVal) {
                                                    user.userHealth -= 30;
                                                    dealer.dealerHealth += 30;
                                                    shouldDisableButton = true;
                                                    setState(() => endingText =
                                                        'You failed to survive 5 cards');
                                                    hasWon = true;
                                                  }
                                                  //checks if user burst
                                                  else if (user.userNum >
                                                      card.maxVal) {
                                                    shouldDisableButton = true;
                                                  }
                                                  //checks if user reach blackjack
                                                  else if (user.userNum ==
                                                      card.maxVal) {
                                                    shouldDisableButton = true;
                                                  }
                                                  //checks if user won by blackjack and 5 cards
                                                  else if (user.userCard
                                                              .length ==
                                                          5 &&
                                                      user.userNum == 21) {
                                                    user.userHealth += 50;
                                                    dealer.dealerHealth -= 50;
                                                    shouldDisableButton = true;
                                                    setState(() => endingText =
                                                        'You won by BlackJack and 5 cards!');
                                                    hasWon = true;
                                                  }
                                                  //checks if user won by 5 cards
                                                  else if (user.userCard
                                                              .length ==
                                                          5 &&
                                                      user.userNum <
                                                          card.maxVal) {
                                                    user.userHealth += 30;
                                                    dealer.dealerHealth -= 30;
                                                    shouldDisableButton = true;
                                                    setState(() => endingText =
                                                        'You won by 5 cards!');
                                                    hasWon = true;
                                                  }

                                                  // updates card depending on the card length
                                                  switch (
                                                      user.userCard.length) {
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
                                                      numOfCardsDealer(dealer
                                                          .dealerCard.length);
                                                      break;
                                                  }
                                                }

                                                //show the num of cards as per the current card length
                                                numOfCards(
                                                    user.userCard.length);
                                              } else {
                                                shouldDisableButton = true;
                                              }
                                            }
                                      : null);
                            },
                          ),
                          const SizedBox(width: 15.0),
                          //restart
                          Consumer2<User, Dealer>(builder: (context, user, dealer, child) {
                            return ElevatedButton(
                              child: const Text('Restart'),
                              onPressed: () {
                                restartGame();
                                user.restartStats();
                                dealer.restartDealerStats();
                              },
                            );
                          }),
                        ],
                      ),
                      //start button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer3<NumCard, User, Dealer>(
                              builder: (context, numCard, user, dealer, child) {
                            return ElevatedButton(
                              child: const Text('Start'),
                              onPressed: firstButtonClick
                                  ? null
                                  : () {
                                      setState(
                                          () => endingText = 'Competing..');
                                      //as long as the card is not 4 and the val is less than 21, it rerolls
                                      while (user.userCard.length != 2) {
                                        setState(() =>
                                            rngNum = Random().nextInt(rngMax));

                                        while (usedNum.contains(rngNum)) {
                                          setState(() => rngNum =
                                              Random().nextInt(rngMax));
                                        }

                                        if (usedNum.contains(rngNum) == false) {
                                          //makes sure everyone is getting dealed before ending with dealer
                                          switch (dealer.dealerCard.length) {
                                            case 0:
                                              //user's first turn for cards
                                              card.takeCards(rngNum);
                                              //ensures card val 'A' is 11
                                              if (rngNum == 0 ||
                                                  rngNum == 1 ||
                                                  rngNum == 2 ||
                                                  rngNum == 3) {
                                                card.cardVal = 1;
                                                user.userNum += card.cardVal;
                                              } else {
                                                user.userNum += card.cardVal;
                                              }
                                              user.userCard.add(card.cardNum);
                                              usedNum.add(rngNum);

                                              //updates first card of player
                                              numCard.doSomething(
                                                  card.flowerVal,
                                                  card.cardNum,
                                                  card.cardColor);

                                              //rerolls for dealer's card
                                              setState(() => rngNum =
                                                  Random().nextInt(rngMax));

                                              //check if its duplicate
                                              while (usedNum.contains(rngNum)) {
                                                setState(() => rngNum =
                                                    Random().nextInt(rngMax));
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
                                                  dealer.dealerNum +=
                                                      card.cardVal;
                                                } else {
                                                  dealer.dealerNum +=
                                                      card.cardVal;
                                                }

                                                dealer.dealerCard
                                                    .add(card.cardNum);
                                                usedNum.add(rngNum);
                                              }

                                              //updates first card of dealer
                                              numCard.doSomething6(
                                                  card.flowerVal,
                                                  card.cardNum,
                                                  card.cardColor);

                                              break;
                                            case 1:
                                              //user's second turn for cards
                                              card.takeCards(rngNum);

                                              //ensures card val 'A' is 11
                                              if (rngNum == 0 ||
                                                  rngNum == 1 ||
                                                  rngNum == 2 ||
                                                  rngNum == 3) {
                                                card.cardVal = 1;
                                                user.userNum += card.cardVal;
                                              } else {
                                                user.userNum += card.cardVal;
                                              }

                                              user.userCard.add(card.cardNum);
                                              usedNum.add(rngNum);

                                              //updates 2nd card for user
                                              numCard.doSomething2(
                                                  card.flowerVal,
                                                  card.cardNum,
                                                  card.cardColor);

                                              //2nd turn for dealer
                                              setState(() => rngNum =
                                                  Random().nextInt(rngMax));

                                              //check if its duplicate
                                              while (usedNum.contains(rngNum)) {
                                                setState(() => rngNum =
                                                    Random().nextInt(rngMax));
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
                                                  if (dealer.dealerNum <
                                                      11) // 10, 9, 8..
                                                  {
                                                    card.cardVal = 11;
                                                    dealer.dealerNum +=
                                                        card.cardVal;
                                                  } else if (dealer.dealerNum ==
                                                      11) {
                                                    card.cardVal = 10;
                                                    dealer.dealerNum +=
                                                        card.cardVal;
                                                  } else {
                                                    card.cardVal = 1;
                                                    dealer.dealerNum +=
                                                        card.cardVal;
                                                  }
                                                } else {
                                                  dealer.dealerNum +=
                                                      card.cardVal;
                                                }

                                                dealer.dealerCard
                                                    .add(card.cardNum);
                                                usedNum.add(rngNum);

                                                //updates second card of dealer
                                                numCard.doSomething7(
                                                    card.flowerVal,
                                                    card.cardNum,
                                                    card.cardColor);

                                                //checks if both double 'A'
                                                if (user.userCard[0] == 'A' &&
                                                    user.userCard[1] == 'A' &&
                                                    dealer.dealerCard[0] ==
                                                        'A' &&
                                                    dealer.dealerCard[1] ==
                                                        'A') {
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'A draw by double A!');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                                //checks if user double A
                                                else if (user.userCard[0] ==
                                                        'A' &&
                                                    user.userCard[1] == 'A') {
                                                  user.userHealth += 30;
                                                  dealer.dealerHealth -= 30;
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'You won by double A!');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                                //checks if dealer double A
                                                else if (dealer.dealerCard[0] ==
                                                        'A' &&
                                                    dealer.dealerCard[1] ==
                                                        'A') {
                                                  user.userHealth -= 30;
                                                  dealer.dealerHealth += 30;
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'Dealer won by double A!');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                                //checks if both are blackjack for draw
                                                else if (user.userNum == 21 &&
                                                    dealer.dealerNum == 21) {
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'A draw by BlackJack!');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                                //checks if both are double for draw
                                                else if (user.userCard[0] ==
                                                        user.userCard[1] &&
                                                    dealer.dealerCard[0] ==
                                                        dealer.dealerCard[1]) {
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'A draw by Double');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                                //checks if user blackjack
                                                else if (user.userCard.length ==
                                                            2 &&
                                                        user.userNum == 11 &&
                                                        user.userCard[0] ==
                                                            'A' ||
                                                    user.userCard.length == 2 &&
                                                        user.userNum == 11 &&
                                                        user.userCard[1] ==
                                                            'A') {
                                                  user.userHealth += 20;
                                                  dealer.dealerHealth -= 20;
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'You won by BlackJack!');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                                //checks if dealer blackjack
                                                else if (dealer.dealerCard
                                                            .length ==
                                                        2 &&
                                                    dealer.dealerNum == 21) {
                                                  user.userHealth -= 20;
                                                  dealer.dealerHealth += 20;
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'Dealer BlackJack');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                } //checks if user double
                                                else if (user.userCard.length ==
                                                        2 &&
                                                    user.userCard[0] ==
                                                        user.userCard[1]) {
                                                  user.userHealth += 20;
                                                  dealer.dealerHealth -= 20;
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'You won by double!');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                                //checks if dealer double
                                                else if (dealer.dealerCard
                                                            .length ==
                                                        2 &&
                                                    dealer.dealerCard[0] ==
                                                        dealer.dealerCard[1]) {
                                                  user.userHealth -= 20;
                                                  dealer.dealerHealth += 20;
                                                  shouldDisableButton = true;
                                                  setState(() => endingText =
                                                      'Dealer Double');
                                                  hasWon = true;
                                                  numOfCardsDealer(
                                                      dealer.dealerCard.length);
                                                }
                                              }
                                              break;
                                          }
                                        }
                                        //show the num of cards as per the current card length
                                        numOfCards(user.userCard.length);
                                      }
                                      firstButtonClick = true;
                                    },
                            );
                          }),
                          const SizedBox(width: 15.0),
                          //user hold
                          Consumer3<NumCard, User, Dealer>(
                              builder: (context, numCard, user, dealer, child) {
                            return ElevatedButton(
                                onPressed: firstButtonClick
                                    ? hasWon
                                        ? null
                                        : () {
                                            setState(() =>
                                                shouldDisableButton = true);

                                            //dealer's actions
                                            //smaller value stuff
                                            while (dealer.dealerNum <
                                                    card.minVal &&
                                                dealer.dealerCard.length <= 4) {
                                              setState(() => rngNum =
                                                  Random().nextInt(rngMax));

                                              //if the card is already taken it rerolls
                                              while (usedNum.contains(rngNum)) {
                                                setState(() => rngNum =
                                                    Random().nextInt(rngMax));
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
                                                  if (dealer.dealerNum < 12) {
                                                    card.cardVal = 10;
                                                    dealer.dealerNum +=
                                                        card.cardVal;
                                                    dealer.dealerCard
                                                        .add(card.cardNum);
                                                    usedNum.add(rngNum);
                                                  } else {
                                                    card.cardVal = 1;
                                                    dealer.dealerNum +=
                                                        card.cardVal;
                                                    dealer.dealerCard
                                                        .add(card.cardNum);
                                                    usedNum.add(rngNum);
                                                  }
                                                } else {
                                                  dealer.dealerNum +=
                                                      card.cardVal;
                                                  dealer.dealerCard
                                                      .add(card.cardNum);
                                                  usedNum.add(rngNum);
                                                }

                                                switch (
                                                    dealer.dealerCard.length) {
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
                                            if (dealer.dealerNum >=
                                                    card.minVal &&
                                                dealer.dealerNum <
                                                    card.dealerVal &&
                                                dealer.dealerCard.length <= 4) {
                                              setState(() => rngDealer =
                                                  Random().nextInt(2));
                                              switch (rngDealer) {
                                                case 0:
                                                  setState(() => rngNum =
                                                      Random().nextInt(rngMax));

                                                  while (usedNum
                                                      .contains(rngNum)) {
                                                    setState(() => rngNum =
                                                        Random()
                                                            .nextInt(rngMax));
                                                  }

                                                  if (usedNum
                                                          .contains(rngNum) ==
                                                      false) {
                                                    //dealer takes card
                                                    card.takeCards(rngNum);
                                                    //modifying card A value
                                                    if (rngNum == 0 ||
                                                        rngNum == 1 ||
                                                        rngNum == 2 ||
                                                        rngNum == 3) {
                                                      if (dealer.dealerNum <
                                                          12) {
                                                        card.cardVal = 10;
                                                        dealer.dealerCard
                                                            .add(card.cardNum);
                                                        dealer.dealerNum +=
                                                            card.cardVal;
                                                      } else {
                                                        card.cardVal = 1;
                                                        dealer.dealerCard
                                                            .add(card.cardNum);
                                                        dealer.dealerNum +=
                                                            card.cardVal;
                                                      }
                                                    } else {
                                                      dealer.dealerNum +=
                                                          card.cardVal;
                                                      dealer.dealerCard
                                                          .add(card.cardNum);
                                                      usedNum.add(rngNum);
                                                    }

                                                    switch (dealer
                                                        .dealerCard.length) {
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
                                                  null;
                                                  break;
                                              }
                                            }

                                            //if user has less than 16 and holds
                                            if (user.userNum < card.minVal) {
                                              user.userHealth -= 20;
                                              dealer.dealerHealth += 20;
                                              setState(() => endingText =
                                                  'You lost as your card number is less than 16!');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //check if dealer 5 cards burst
                                            else if (dealer.dealerCard.length ==
                                                    5 &&
                                                dealer.dealerNum >
                                                    card.maxVal) {
                                              user.userHealth += 30;
                                              dealer.dealerHealth -= 30;
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'Dealer 5 cards burst');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if both burst
                                            else if (user.userNum >
                                                    card.maxVal &&
                                                dealer.dealerNum >
                                                    card.maxVal) {
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'A draw! Both burst!');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if both are same number for draw
                                            else if (user.userNum ==
                                                dealer.dealerNum) {
                                              shouldDisableButton = true;
                                              setState(
                                                  () => endingText = 'A draw!');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if dealer won by blackjack and 5 cards
                                            else if (dealer.dealerCard.length ==
                                                    5 &&
                                                dealer.dealerNum == 21) {
                                              user.userHealth -= 50;
                                              dealer.dealerHealth += 50;
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'Dealer won by BlackJack and 5 cards!');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if dealer won by 5 cards
                                            else if (dealer.dealerCard.length ==
                                                    5 &&
                                                dealer.dealerNum >
                                                    card.minVal &&
                                                dealer.dealerNum <
                                                    card.maxVal) {
                                              user.userHealth -= 30;
                                              dealer.dealerHealth += 30;
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'Dealer won by 5 cards!');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if user won by blackjack
                                            else if (user.userNum == 21) {
                                              user.userHealth += 20;
                                              dealer.dealerHealth -= 20;
                                              shouldDisableButton = true;
                                              endingText =
                                                  'You won by BlackJack!';
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if dealer blackjack
                                            else if (dealer.dealerNum == 21) {
                                              user.userHealth -= 20;
                                              dealer.dealerHealth += 20;
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'Dealer BlackJack');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //user having higher score than dealer after everything
                                            else if (user.userNum >
                                                    dealer.dealerNum &&
                                                user.userNum < card.maxVal) {
                                              shouldDisableButton = true;
                                              user.userHealth += 10;
                                              dealer.dealerHealth -= 10;
                                              setState(() => endingText =
                                                  'You won the dealer by having a higher score!');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            } //dealer having higher score after everything
                                            else if (user.userNum <
                                                    dealer.dealerNum &&
                                                dealer.dealerNum <
                                                    card.maxVal) {
                                              shouldDisableButton = true;
                                              user.userHealth -= 10;
                                              dealer.dealerHealth += 10;
                                              setState(() =>
                                                  endingText = 'You lost');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            } //dealer burst
                                            else if (dealer.dealerNum >
                                                card.maxVal) {
                                              shouldDisableButton = true;
                                              user.userHealth += 10;
                                              dealer.dealerHealth -= 10;
                                              setState(() =>
                                                  endingText = 'Dealer burst.');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            } //user burst
                                            else if (user.userNum >
                                                card.maxVal) {
                                              shouldDisableButton = true;
                                              user.userHealth -= 10;
                                              dealer.dealerHealth += 10;
                                              setState(() =>
                                                  endingText = 'You burst');
                                              hasWon = true;
                                              //show the num of cards as per the current card length
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                          }
                                    : null,
                                child: const Text('Hold'));
                          }),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      //dealer's cards and dealerNum
                      Consumer2<NumCard, Dealer>(
                        builder: (context, numCard, dealer, child) {
                          return Stack(
                            children: [
                              Padding(
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
                              ),
                              //dealerNum text
                              Visibility(
                                visible: hasWon,
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      dealer.dealerNum.toString(),
                                      style: const TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 10.0),
                      //user's cards and userNum
                      Consumer2<NumCard, User>(
                          builder: (context, numCard, user, child) {
                        return Stack(
                          children: [
                            Consumer2<NumCard, User>(
                              builder: (context, numCard, user, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      card1
                                          ? Visibility(
                                              visible: card1,
                                              child: Column(
                                                children: [
                                                  CardTemplate(
                                                    flower: numCard.flower,
                                                    num: numCard.num,
                                                    color: numCard.color,
                                                  ),
                                                  Visibility(
                                                    maintainState: true,
                                                    maintainAnimation: true,
                                                    maintainSize: true,
                                                    visible:
                                                        user.userCard[0] == 'A',
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor: hasBeenPressed
                                                                ? MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .blue)
                                                                : MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.green
                                                                        .shade100)),
                                                        child: const Icon(
                                                            Icons.cached),
                                                        onPressed: hasWon
                                                            ? null
                                                            : () {
                                                                hasBeenPressed =
                                                                    !hasBeenPressed;
                                                                user.changeA1 =
                                                                    !user
                                                                        .changeA1;
                                                                user.modifyA1Val();
                                                              }),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const CardBack(),
                                      card2
                                          ? Visibility(
                                              visible: card2,
                                              child: Column(
                                                children: [
                                                  CardTemplate(
                                                    flower: numCard.flower2,
                                                    num: numCard.num2,
                                                    color: numCard.color2,
                                                  ),
                                                  Visibility(
                                                    maintainState: true,
                                                    maintainAnimation: true,
                                                    maintainSize: true,
                                                    visible:
                                                        user.userCard[1] == 'A',
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor: hasBeenPressed2
                                                                ? MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .blue)
                                                                : MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.green
                                                                        .shade100)),
                                                        child: const Icon(
                                                            Icons.cached),
                                                        onPressed: hasWon
                                                            ? null
                                                            : () {
                                                                hasBeenPressed2 =
                                                                    !hasBeenPressed2;
                                                                user.changeA2 =
                                                                    !user
                                                                        .changeA2;
                                                                user.modifyA2Val();
                                                              }),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const CardBack(),
                                      card3
                                          ? Visibility(
                                              visible: card3,
                                              child: Column(
                                                children: [
                                                  CardTemplate(
                                                    flower: numCard.flower3,
                                                    num: numCard.num3,
                                                    color: numCard.color3,
                                                  ),
                                                  Visibility(
                                                    maintainState: true,
                                                    maintainAnimation: true,
                                                    maintainSize: true,
                                                    visible:
                                                        user.userCard[2] == 'A',
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor: hasBeenPressed3
                                                                ? MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .blue)
                                                                : MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.green
                                                                        .shade100)),
                                                        child: const Icon(
                                                            Icons.cached),
                                                        onPressed: hasWon
                                                            ? null
                                                            : () {
                                                                hasBeenPressed3 =
                                                                    !hasBeenPressed3;
                                                                user.changeA3 =
                                                                    !user
                                                                        .changeA3;
                                                                user.modifyA3Val();
                                                              }),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const CardBack(),
                                      card4
                                          ? Visibility(
                                              visible: card4,
                                              child: Column(
                                                children: [
                                                  CardTemplate(
                                                    flower: numCard.flower4,
                                                    num: numCard.num4,
                                                    color: numCard.color4,
                                                  ),
                                                  Visibility(
                                                    maintainState: true,
                                                    maintainAnimation: true,
                                                    maintainSize: true,
                                                    visible:
                                                        user.userCard[3] == 'A',
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor: hasBeenPressed4
                                                                ? MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .blue)
                                                                : MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.green
                                                                        .shade100)),
                                                        child: const Icon(
                                                            Icons.cached),
                                                        onPressed: hasWon
                                                            ? null
                                                            : () {
                                                                hasBeenPressed4 =
                                                                    !hasBeenPressed4;
                                                                user.changeA4 =
                                                                    !user
                                                                        .changeA4;
                                                                user.modifyA4Val();
                                                              }),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const CardBack(),
                                      card5
                                          ? Visibility(
                                              visible: card5,
                                              child: Column(
                                                children: [
                                                  CardTemplate(
                                                    flower: numCard.flower5,
                                                    num: numCard.num5,
                                                    color: numCard.color5,
                                                  ),
                                                  Visibility(
                                                    maintainState: true,
                                                    maintainAnimation: true,
                                                    maintainSize: true,
                                                    visible:
                                                        user.userCard[4] == 'A',
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor: hasBeenPressed5
                                                                ? MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .blue)
                                                                : MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.green
                                                                        .shade100)),
                                                        child: const Icon(
                                                            Icons.cached),
                                                        onPressed: hasWon
                                                            ? null
                                                            : () {
                                                                hasBeenPressed5 =
                                                                    !hasBeenPressed5;
                                                                user.changeA5 =
                                                                    !user
                                                                        .changeA5;
                                                                user.modifyA5Val();
                                                              }),
                                                  ),
                                                ],
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
                                  user.userNum.toString(),
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        );
                      }),
                      //user's health bar
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.blue,
                                ),
                              ),
                              Consumer<User>(
                                builder: (context, user, child) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        user.userHealth /
                                        100,
                                    color: Colors.green,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
