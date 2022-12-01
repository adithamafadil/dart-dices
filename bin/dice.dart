import 'dart:io';
import 'package:dice/dice.dart';

void main(List<String> arguments) {
  List<User> users = [];
  List<User> eliminatedUsers = [];
  int indexRolls = 1;

  print('Input max dice for each player: ');
  int? maxDicePerPlayer = int.parse(stdin.readLineSync()!);
  print('Input max player: ');
  int? maxPlayer = int.parse(stdin.readLineSync()!);

  // Generate initial Users
  users = List.generate(
    maxPlayer,
    (index) => User(
      name: '$index',
      point: 0,
      dices: getDices(maxDicePerPlayer),
      givenDices: [],
      notes: PLAYER_STATUS.playing,
    ),
  );

  do {
    rollDices(
      users: users,
      maxDicePerPlayer: maxDicePerPlayer,
      index: indexRolls,
    );

    indexRolls += 1;
  } while (getWinCondition(users, eliminatedUsers, indexRolls));
}
