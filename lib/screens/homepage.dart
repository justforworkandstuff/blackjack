import 'package:blackjackk/model/cardback.dart';
import 'package:blackjackk/model/cards.dart';
import 'package:blackjackk/model/cardtemplate.dart';
import 'package:blackjackk/model/condition.dart';
import 'package:blackjackk/viewmodel/dealer.dart';
import 'package:blackjackk/viewmodel/numcard.dart';
import 'package:blackjackk/viewmodel/player.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var constantsVal = Condition();
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
        ChangeNotifierProvider<Player>(create: (context) => Player()),
        ChangeNotifierProvider<Dealer>(create: (context) => Dealer()),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //dealer's health bar
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.red,
                        ),
                        Consumer<Dealer>(
                          builder: (context, dealer, child) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.10,
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
                  //hit and restart button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //hit button
                      Consumer3<NumCard, Player, Dealer>(
                        builder: (context, numCard, player, dealer, child) {
                          return ElevatedButton(
                              child: const Text('Hit'),
                              onPressed: firstButtonClick
                                  ? shouldDisableButton
                                      ? null
                                      : () {
                                          //as long as the card is not 5 and the val is less than 21, you can reroll
                                          if (player.playerCard.length <= 4 &&
                                              player.playerNum < card.maxVal &&
                                              player.playerNum != card.maxVal) {
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
                                              card.takeCards(rngNum);

                                              //ensures card val 'A' is 11
                                              if (rngNum == 0 ||
                                                  rngNum == 1 ||
                                                  rngNum == 2 ||
                                                  rngNum == 3) {
                                                card.cardVal = 1;
                                                player.updatePlayerNum(
                                                    card.cardVal);
                                              } else {
                                                player.updatePlayerNum(
                                                    card.cardVal);
                                              }
                                              player.updatePlayerCard(
                                                  card.cardNum);
                                              usedNum.add(rngNum);

                                              //checks if player 5 cards burst
                                              if (player.playerCard.length ==
                                                      5 &&
                                                  player.playerNum >
                                                      card.maxVal) {
                                                player.updateHealth(
                                                    constantsVal.highValueN);
                                                dealer.updateDealerHealth(
                                                    constantsVal.highValue);
                                                shouldDisableButton = true;
                                                setState(() => endingText =
                                                    'You failed to survive 5 cards');
                                                hasWon = true;
                                              }
                                              //checks if player won by blackjack and 5 cards
                                              else if (player
                                                          .playerCard.length ==
                                                      5 &&
                                                  player.playerNum == 21) {
                                                player.updateHealth(
                                                    constantsVal.highestVal);
                                                dealer.updateDealerHealth(
                                                    constantsVal.highestValN);
                                                shouldDisableButton = true;
                                                setState(() => endingText =
                                                    'You won by BlackJack and 5 cards!');
                                                hasWon = true;
                                              }
                                              //checks if player won by 5 cards
                                              else if (player
                                                          .playerCard.length ==
                                                      5 &&
                                                  player.playerNum <
                                                      card.maxVal) {
                                                player.updateHealth(
                                                    constantsVal.highValue);
                                                dealer.updateDealerHealth(
                                                    constantsVal.highValueN);
                                                shouldDisableButton = true;
                                                setState(() => endingText =
                                                    'You won by 5 cards!');
                                                hasWon = true;
                                              }
                                              //checks if player burst
                                              else if (player.playerNum >
                                                  card.maxVal) {
                                                shouldDisableButton = true;
                                              }
                                              //checks if player reach blackjack
                                              else if (player.playerNum ==
                                                  card.maxVal) {
                                                shouldDisableButton = true;
                                              }

                                              // updates card depending on the card length
                                              switch (
                                                  player.playerCard.length) {
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
                                                      dealer.dealerCard.length);
                                                  break;
                                              }
                                            }

                                            //show the num of cards as per the current card length
                                            numOfCards(
                                                player.playerCard.length);

                                            //checks if player or dealer has no more health left
                                            if (player.playerHealth <= 0) {
                                              Navigator.pushReplacementNamed(
                                                  context, '/gameover',
                                                  arguments: {
                                                    'decision': 'lose'
                                                  });
                                            } else if (dealer.dealerHealth <=
                                                0) {
                                              Navigator.pushReplacementNamed(
                                                  context, '/gameover',
                                                  arguments: {
                                                    'decision': 'win'
                                                  });
                                            }
                                          } else {
                                            shouldDisableButton = true;
                                          }
                                        }
                                  : null);
                        },
                      ),
                      const SizedBox(width: 15.0),
                      //restart
                      Consumer2<Player, Dealer>(
                          builder: (context, player, dealer, child) {
                        return ElevatedButton(
                          child: const Text('Restart'),
                          onPressed: () {
                            restartGame();
                            player.restartStats();
                            dealer.restartDealerStats();
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Text('Player Current Health'),
                  Consumer<Player>(builder: (context, player, child) {
                    return Text(player.playerHealth.toString());
                  }),
                  const SizedBox(height: 10.0),
                  Text(endingText),
                  const SizedBox(height: 10.0),
                  //start and hold button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //start button
                      Consumer3<NumCard, Player, Dealer>(
                          builder: (context, numCard, player, dealer, child) {
                        return ElevatedButton(
                          child: const Text('Start'),
                          onPressed: firstButtonClick
                              ? null
                              : () {
                                  setState(() => endingText = 'Competing..');
                                  //as long as the card is not 4 and the val is less than 21, it rerolls
                                  while (player.playerCard.length != 2) {
                                    setState(() =>
                                        rngNum = Random().nextInt(rngMax));

                                    while (usedNum.contains(rngNum)) {
                                      setState(() =>
                                          rngNum = Random().nextInt(rngMax));
                                    }

                                    if (usedNum.contains(rngNum) == false) {
                                      //makes sure everyone is getting dealed before ending with dealer
                                      switch (dealer.dealerCard.length) {
                                        case 0:
                                          //player's first turn for cards
                                          card.takeCards(rngNum);
                                          //ensures card val 'A' is 11
                                          if (rngNum == 0 ||
                                              rngNum == 1 ||
                                              rngNum == 2 ||
                                              rngNum == 3) {
                                            card.cardVal = 1;
                                            player
                                                .updatePlayerNum(card.cardVal);
                                          } else {
                                            player
                                                .updatePlayerNum(card.cardVal);
                                          }
                                          player.updatePlayerCard(card.cardNum);
                                          usedNum.add(rngNum);

                                          //updates first card of player
                                          numCard.doSomething(card.flowerVal,
                                              card.cardNum, card.cardColor);

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
                                              dealer.updateDealerNum(
                                                  card.cardVal);
                                            } else {
                                              dealer.updateDealerNum(
                                                  card.cardVal);
                                            }
                                            dealer
                                                .updateDealerCard(card.cardNum);
                                            usedNum.add(rngNum);
                                          }

                                          //updates first card of dealer
                                          numCard.doSomething6(card.flowerVal,
                                              card.cardNum, card.cardColor);

                                          break;
                                        case 1:
                                          //player's second turn for cards
                                          card.takeCards(rngNum);

                                          //ensures card val 'A' is 11
                                          if (rngNum == 0 ||
                                              rngNum == 1 ||
                                              rngNum == 2 ||
                                              rngNum == 3) {
                                            card.cardVal = 1;
                                            player
                                                .updatePlayerNum(card.cardVal);
                                          } else {
                                            player
                                                .updatePlayerNum(card.cardVal);
                                          }
                                          player.updatePlayerCard(card.cardNum);
                                          usedNum.add(rngNum);

                                          //updates 2nd card for player
                                          numCard.doSomething2(card.flowerVal,
                                              card.cardNum, card.cardColor);

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
                                                dealer.updateDealerNum(
                                                    card.cardVal);
                                              } else if (dealer.dealerNum ==
                                                  11) {
                                                card.cardVal = 10;
                                                dealer.updateDealerNum(
                                                    card.cardVal);
                                              } else {
                                                card.cardVal = 1;
                                                dealer.updateDealerNum(
                                                    card.cardVal);
                                              }
                                            } else {
                                              dealer.updateDealerNum(
                                                  card.cardVal);
                                            }
                                            dealer
                                                .updateDealerCard(card.cardNum);
                                            usedNum.add(rngNum);

                                            //updates second card of dealer
                                            numCard.doSomething7(card.flowerVal,
                                                card.cardNum, card.cardColor);

                                            //checks if both double 'A'
                                            if (player.playerCard[0] == 'A' &&
                                                player.playerCard[1] == 'A' &&
                                                dealer.dealerCard[0] == 'A' &&
                                                dealer.dealerCard[1] == 'A') {
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'A draw by double A!');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if player double A
                                            else if (player.playerCard[0] ==
                                                    'A' &&
                                                player.playerCard[1] == 'A') {
                                              player.updateHealth(
                                                  constantsVal.highValue);
                                              dealer.updateDealerHealth(
                                                  constantsVal.highValueN);
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
                                                dealer.dealerCard[1] == 'A') {
                                              player.updateHealth(
                                                  constantsVal.highValueN);
                                              dealer.updateDealerHealth(
                                                  constantsVal.highValue);
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'Dealer won by double A!');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if both are blackjack for draw
                                            else if (player.playerCard.length ==
                                                        2 &&
                                                    player.playerNum == 11 &&
                                                    player.playerCard[0] ==
                                                        'A' &&
                                                    dealer.dealerCard.length ==
                                                        2 &&
                                                    dealer.dealerNum == 11 &&
                                                    dealer.dealerCard[0] ==
                                                        'A' ||
                                                player.playerCard.length == 2 &&
                                                    player.playerNum == 11 &&
                                                    player.playerCard[0] ==
                                                        'A' &&
                                                    dealer.dealerCard.length ==
                                                        2 &&
                                                    dealer.dealerNum == 11 &&
                                                    dealer.dealerCard[1] ==
                                                        'A' ||
                                                player.playerCard.length == 2 &&
                                                    player.playerNum == 11 &&
                                                    player.playerCard[1] ==
                                                        'A' &&
                                                    dealer.dealerCard.length ==
                                                        2 &&
                                                    dealer.dealerNum == 11 &&
                                                    dealer.dealerCard[0] ==
                                                        'A' ||
                                                player.playerCard.length == 2 &&
                                                    player.playerNum == 11 &&
                                                    player.playerCard[1] ==
                                                        'A' &&
                                                    dealer.dealerCard.length ==
                                                        2 &&
                                                    dealer.dealerNum == 11 &&
                                                    dealer.dealerCard[1] ==
                                                        'A') {
                                              player.updatePlayerNum(
                                                  constantsVal.smolValue);
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'A draw by BlackJack!');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if both are double for draw
                                            else if (player.playerCard[0] ==
                                                    player.playerCard[1] &&
                                                dealer.dealerCard[0] ==
                                                    dealer.dealerCard[1]) {
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'A draw by Double');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if player blackjack
                                            else if (player.playerCard.length ==
                                                        2 &&
                                                    player.playerNum == 11 &&
                                                    player.playerCard[0] ==
                                                        'A' ||
                                                player.playerCard.length == 2 &&
                                                    player.playerNum == 11 &&
                                                    player.playerCard[1] ==
                                                        'A') {
                                              player.updatePlayerNum(
                                                  constantsVal.smolValue);
                                              player.updateHealth(
                                                  constantsVal.medValue);
                                              dealer.updateDealerHealth(
                                                  constantsVal.medValueN);
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'You won by BlackJack!');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if dealer blackjack
                                            else if (dealer.dealerCard.length ==
                                                    2 &&
                                                dealer.dealerNum == 21) {
                                              player.updateHealth(
                                                  constantsVal.medValueN);
                                              dealer.updateDealerHealth(
                                                  constantsVal.medValue);
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'Dealer BlackJack');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            } //checks if player double
                                            else if (player.playerCard.length ==
                                                    2 &&
                                                player.playerCard[0] ==
                                                    player.playerCard[1]) {
                                              player.updateHealth(
                                                  constantsVal.medValue);
                                              dealer.updateDealerHealth(
                                                  constantsVal.medValueN);
                                              shouldDisableButton = true;
                                              setState(() => endingText =
                                                  'You won by double!');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                            //checks if dealer double
                                            else if (dealer.dealerCard.length ==
                                                    2 &&
                                                dealer.dealerCard[0] ==
                                                    dealer.dealerCard[1]) {
                                              player.updateHealth(
                                                  constantsVal.medValueN);
                                              dealer.updateDealerHealth(
                                                  constantsVal.medValue);
                                              shouldDisableButton = true;
                                              setState(() =>
                                                  endingText = 'Dealer Double');
                                              hasWon = true;
                                              numOfCardsDealer(
                                                  dealer.dealerCard.length);
                                            }
                                          }
                                          break;
                                      }
                                    }
                                    //show the num of cards as per the current card length
                                    numOfCards(player.playerCard.length);

                                    //checks if player or dealer has no more health left
                                    if (player.playerHealth <= 0) {
                                      Navigator.pushReplacementNamed(
                                          context, '/gameover',
                                          arguments: {'decision': 'lose'});
                                    } else if (dealer.dealerHealth <= 0) {
                                      Navigator.pushReplacementNamed(
                                          context, '/gameover',
                                          arguments: {'decision': 'win'});
                                    }
                                  }
                                  firstButtonClick = true;
                                },
                        );
                      }),
                      const SizedBox(width: 15.0),
                      //player hold
                      Consumer3<NumCard, Player, Dealer>(
                          builder: (context, numCard, player, dealer, child) {
                        return ElevatedButton(
                            onPressed: firstButtonClick
                                ? hasWon
                                    ? null
                                    : () {
                                        setState(
                                            () => shouldDisableButton = true);

                                        //dealer's actions
                                        //smaller value stuff
                                        while (dealer.dealerNum < card.minVal &&
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
                                                dealer.updateDealerNum(
                                                    card.cardVal);
                                                dealer.updateDealerCard(
                                                    card.cardNum);
                                                usedNum.add(rngNum);
                                              } else {
                                                card.cardVal = 1;
                                                dealer.updateDealerNum(
                                                    card.cardVal);
                                                dealer.updateDealerCard(
                                                    card.cardNum);
                                                usedNum.add(rngNum);
                                              }
                                            } else {
                                              dealer.updateDealerNum(
                                                  card.cardVal);
                                              dealer.updateDealerCard(
                                                  card.cardNum);
                                              usedNum.add(rngNum);
                                            }

                                            switch (dealer.dealerCard.length) {
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
                                        if (dealer.dealerNum >= card.minVal &&
                                            dealer.dealerNum < card.dealerVal &&
                                            dealer.dealerCard.length <= 4) {
                                          setState(() =>
                                              rngDealer = Random().nextInt(2));
                                          switch (rngDealer) {
                                            case 0:
                                              setState(() => rngNum =
                                                  Random().nextInt(rngMax));

                                              while (usedNum.contains(rngNum)) {
                                                setState(() => rngNum =
                                                    Random().nextInt(rngMax));
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
                                                  if (dealer.dealerNum < 12) {
                                                    card.cardVal = 10;
                                                    dealer.updateDealerNum(
                                                        card.cardVal);
                                                    dealer.updateDealerCard(
                                                        card.cardNum);
                                                  } else {
                                                    card.cardVal = 1;
                                                    dealer.updateDealerNum(
                                                        card.cardVal);
                                                    dealer.updateDealerCard(
                                                        card.cardNum);
                                                  }
                                                } else {
                                                  dealer.updateDealerNum(
                                                      card.cardVal);
                                                  dealer.updateDealerCard(
                                                      card.cardNum);
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
                                              break;
                                            case 1:
                                              null;
                                              break;
                                          }
                                        }

                                        //if player has less than 16 and holds
                                        if (player.playerNum < card.minVal) {
                                          player.updateHealth(
                                              constantsVal.medValueN);
                                          dealer.updateDealerHealth(
                                              constantsVal.medValue);
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
                                            dealer.dealerNum > card.maxVal) {
                                          player.updateHealth(
                                              constantsVal.highValue);
                                          dealer.updateDealerHealth(
                                              constantsVal.highValueN);
                                          shouldDisableButton = true;
                                          setState(() => endingText =
                                              'Dealer 5 cards burst');
                                          hasWon = true;
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        }
                                        //checks if both burst
                                        else if (player.playerNum >
                                                card.maxVal &&
                                            dealer.dealerNum > card.maxVal) {
                                          shouldDisableButton = true;
                                          setState(() => endingText =
                                              'A draw! Both burst!');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        }
                                        //checks if dealer won by blackjack and 5 cards
                                        else if (dealer.dealerCard.length ==
                                                5 &&
                                            dealer.dealerNum == 21) {
                                          player.updateHealth(
                                              constantsVal.highestValN);
                                          dealer.updateDealerHealth(
                                              constantsVal.highestVal);
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
                                            dealer.dealerNum > card.minVal &&
                                            dealer.dealerNum < card.maxVal) {
                                          player.updateHealth(
                                              constantsVal.highValueN);
                                          dealer.updateDealerHealth(
                                              constantsVal.highValueN);
                                          shouldDisableButton = true;
                                          setState(() => endingText =
                                              'Dealer won by 5 cards!');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        }
                                        //checks if both are same number for draw
                                        else if (player.playerNum ==
                                            dealer.dealerNum) {
                                          shouldDisableButton = true;
                                          setState(
                                              () => endingText = 'A draw!');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        }
                                        //checks if player won by blackjack
                                        else if (player.playerNum == 21) {
                                          player.updateHealth(
                                              constantsVal.medValue);
                                          dealer.updateDealerHealth(
                                              constantsVal.medValueN);
                                          shouldDisableButton = true;
                                          endingText = 'You won by BlackJack!';
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        }
                                        //checks if dealer blackjack
                                        else if (dealer.dealerNum == 21) {
                                          player.updateHealth(
                                              constantsVal.medValueN);
                                          dealer.updateDealerHealth(
                                              constantsVal.medValue);
                                          shouldDisableButton = true;
                                          setState(() =>
                                              endingText = 'Dealer BlackJack');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        }
                                        //player having higher score than dealer after everything
                                        else if (player.playerNum >
                                                dealer.dealerNum &&
                                            player.playerNum < card.maxVal) {
                                          shouldDisableButton = true;
                                          player.updateHealth(
                                              constantsVal.smolValue);
                                          dealer.updateDealerHealth(
                                              constantsVal.smolValueN);
                                          setState(() => endingText =
                                              'You won the dealer by having a higher score!');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        } //dealer having higher score after everything
                                        else if (player.playerNum <
                                                dealer.dealerNum &&
                                            dealer.dealerNum < card.maxVal) {
                                          shouldDisableButton = true;
                                          player.updateHealth(
                                              constantsVal.smolValueN);
                                          dealer.updateDealerHealth(
                                              constantsVal.smolValue);
                                          setState(
                                              () => endingText = 'You lost');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        } //dealer burst
                                        else if (dealer.dealerNum >
                                            card.maxVal) {
                                          shouldDisableButton = true;
                                          player.updateHealth(
                                              constantsVal.smolValue);
                                          dealer.updateDealerHealth(
                                              constantsVal.smolValueN);
                                          setState(() =>
                                              endingText = 'Dealer burst.');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        } //player burst
                                        else if (player.playerNum >
                                            card.maxVal) {
                                          shouldDisableButton = true;
                                          player.updateHealth(
                                              constantsVal.smolValueN);
                                          dealer.updateDealerHealth(
                                              constantsVal.smolValue);
                                          setState(
                                              () => endingText = 'You burst');
                                          hasWon = true;
                                          //show the num of cards as per the current card length
                                          numOfCardsDealer(
                                              dealer.dealerCard.length);
                                        }
                                        //checks if player or dealer has no more health left
                                        if (player.playerHealth <= 0) {
                                          Navigator.pushReplacementNamed(
                                              context, '/gameover',
                                              arguments: {'decision': 'lose'});
                                        } else if (dealer.dealerHealth <= 0) {
                                          Navigator.pushReplacementNamed(
                                              context, '/gameover',
                                              arguments: {'decision': 'win'});
                                        }
                                      }
                                : null,
                            child: const Text('Hold'));
                      }),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //player's cards and playerNum
                  Consumer2<NumCard, Player>(
                      builder: (context, numCard, player, child) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                                                player.playerCard[0] == 'A',
                                            child: IconButton(
                                              color: hasBeenPressed ? Colors.black : Colors.green,
                                                icon: const Icon(Icons.cached),
                                                onPressed: hasWon
                                                    ? null
                                                    : () {
                                                        hasBeenPressed =
                                                            !hasBeenPressed;
                                                        player.changeA1 =
                                                            !player.changeA1;
                                                        player.modifyA1Val();
                                                      }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: const [
                                        CardBack(),
                                        Visibility(
                                          maintainState: true,
                                          maintainAnimation: true,
                                          maintainSize: true,
                                          visible: false,
                                          child: IconButton(
                                            icon: Icon(Icons.cached),
                                            onPressed: null,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                player.playerCard[1] == 'A',
                                            child: IconButton(
                                              color: hasBeenPressed2 ? Colors.black : Colors.green,
                                                icon: const Icon(Icons.cached),
                                                onPressed: hasWon
                                                    ? null
                                                    : () {
                                                        hasBeenPressed2 =
                                                            !hasBeenPressed2;
                                                        player.changeA2 =
                                                            !player.changeA2;
                                                        player.modifyA2Val();
                                                      }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: const [
                                        CardBack(),
                                        Visibility(
                                          maintainState: true,
                                          maintainAnimation: true,
                                          maintainSize: true,
                                          visible: false,
                                          child: IconButton(
                                            icon: Icon(Icons.cached),
                                            onPressed: null,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                player.playerCard[2] == 'A',
                                            child: IconButton(
                                                color: hasBeenPressed2 ? Colors.black : Colors.green,
                                                icon: const Icon(Icons.cached),
                                                onPressed: hasWon
                                                    ? null
                                                    : () {
                                                        hasBeenPressed3 =
                                                            !hasBeenPressed3;
                                                        player.changeA3 =
                                                            !player.changeA3;
                                                        player.modifyA3Val();
                                                      }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: const [
                                        CardBack(),
                                        Visibility(
                                          maintainState: true,
                                          maintainAnimation: true,
                                          maintainSize: true,
                                          visible: false,
                                          child: IconButton(
                                            icon: Icon(Icons.cached),
                                            onPressed: null,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                player.playerCard[3] == 'A',
                                            child: IconButton(
                                                color: hasBeenPressed2 ? Colors.black : Colors.green,
                                                icon: const Icon(Icons.cached),
                                                onPressed: hasWon
                                                    ? null
                                                    : () {
                                                        hasBeenPressed4 =
                                                            !hasBeenPressed4;
                                                        player.changeA4 =
                                                            !player.changeA4;
                                                        player.modifyA4Val();
                                                      }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: const [
                                        CardBack(),
                                        Visibility(
                                          maintainState: true,
                                          maintainAnimation: true,
                                          maintainSize: true,
                                          visible: false,
                                          child: IconButton(
                                            icon: Icon(Icons.cached),
                                            onPressed: null,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                player.playerCard[4] == 'A',
                                            child: IconButton(
                                                color: hasBeenPressed2 ? Colors.black : Colors.green,
                                                icon: const Icon(Icons.cached),
                                                onPressed: hasWon
                                                    ? null
                                                    : () {
                                                        hasBeenPressed5 =
                                                            !hasBeenPressed5;
                                                        player.changeA5 =
                                                            !player.changeA5;
                                                        player.modifyA5Val();
                                                      }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: const [
                                        CardBack(),
                                        Visibility(
                                          maintainState: true,
                                          maintainAnimation: true,
                                          maintainSize: true,
                                          visible: false,
                                          child: IconButton(
                                            icon: Icon(Icons.cached),
                                            onPressed: null,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        //playerNum text
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              player.playerNum.toString(),
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    );
                  }),
                  //player's health bar
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red,
                      ),
                      Consumer<Player>(
                        builder: (context, player, child) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width *
                                player.playerHealth /
                                100,
                            color: Colors.green,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
