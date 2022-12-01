import 'package:dice/functions/get_dices.dart';
import 'package:dice/model/user_model.dart';
import 'package:dice/utils/constants.dart';

void rollDices({
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
