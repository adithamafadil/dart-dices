import 'dart:io';
import 'dart:math';

class User {
  String name;
  int point;
  List<int> dices;
  List<int> givenDices;
  PLAYER_STATUS notes;

  User({
    required this.name,
    required this.point,
    required this.dices,
    required this.givenDices,
    required this.notes,
  });

  @override
  String toString() =>
      "\nName: $name, Status: $notes\nPoint: $point\nDices: ${dices.join(', ')}\n";
}

const MAX_DICE_NUMBER = 6;
const DICE_WILL_BE_REMOVED = 6;
const DICE_WILL_BE_PASS_TO_FRIEND = 1;

enum PLAYER_STATUS {
  playing,
  eliminated;

  bool get isPlaying => this == playing;

  @override
  String toString() {
    switch (this) {
      case playing:
        return 'The player is still playing';
      default:
        return 'The player is eliminated';
    }
  }
}

List<User> eliminatedUsers = [];

void main(List<String> arguments) {
  List<User> users = [];
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

  int indexRolls = 1;

  do {
    getRolls(
      users: users,
      maxDicePerPlayer: maxDicePerPlayer,
      index: indexRolls,
    );

    indexRolls += 1;
  } while (getWinCondition(users, indexRolls));

  print('Winner: Player#${users.first.name}');
}

List<int> getDices(int playersDice) => List.generate(
      playersDice,
      (index) => Random().nextInt(MAX_DICE_NUMBER) + 1,
    );

bool getWinCondition(List<User> users, int index) {
  for (int i = 0; i < users.length; i++) {
    if (users[i].dices.isEmpty && users[i].notes.isPlaying) {
      users[i].notes = PLAYER_STATUS.eliminated;
      eliminatedUsers.add(users[i]);
      users.removeAt(i);
    }
  }

  print('After Calculation #${index - 1}: ${users.map((e) => e.toString())}');
  print('==============================================\n\n');
  if (users.length == 1) {
    print('The eliminated List: ${eliminatedUsers.map((e) => e.toString())}');
    print('==============================================\n\n');
    return false;
  }
  return true;
}

void getRolls({
  required List<User> users,
  required int maxDicePerPlayer,
  required int index,
}) {
  for (int i = 0; i < users.length; i++) {
    if (users[i].dices.isNotEmpty) {
      users[i].dices = getDices(users[i].dices.length);
    }
  }

  print('==============================================');
  print('Initial Condition #$index: ${users.map((e) => e.toString())}');
  print('==============================================\n');

  for (int i = 0; i < users.length; i++) {
    for (int j = 0; j < users[i].dices.length; j++) {
      if (users[i].dices[j] == DICE_WILL_BE_REMOVED) {
        final userRemovedDices = users[i]
            .dices
            .where((element) => element == DICE_WILL_BE_REMOVED)
            .toList()
            .length;
        users[i]
            .dices
            .removeWhere((element) => element == DICE_WILL_BE_REMOVED);

        users[i].point = users[i].point + userRemovedDices;
      }
    }

    if (users[i].dices.contains(DICE_WILL_BE_PASS_TO_FRIEND)) {
      List<int> dicesWillBePassed = users[i]
          .dices
          .where((element) => element == DICE_WILL_BE_PASS_TO_FRIEND)
          .toList();
      users[i]
          .dices
          .removeWhere((element) => element == DICE_WILL_BE_PASS_TO_FRIEND);
      if (i == users.length - 1 && users[i].notes.isPlaying) {
        users[0].givenDices.addAll(dicesWillBePassed);
      } else {
        users[i + 1].givenDices.addAll(dicesWillBePassed);
      }
    }
  }

  for (int i = 0; i < users.length; i++) {
    users[i].dices.addAll(users[i].givenDices);
    users[i].givenDices = [];
  }
}
