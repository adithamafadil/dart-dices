import 'package:dice/functions/get_winners.dart';
import 'package:dice/model/user_model.dart';
import 'package:dice/utils/constants.dart';

bool getWinCondition(List<User> users, List<User> eliminatedUsers, int index) {
  for (int i = 0; i < users.length; i++) {
    if (users[i].dices.isEmpty && users[i].notes.isPlaying) {
      users[i].notes = PLAYER_STATUS.eliminated;
      eliminatedUsers.add(users[i]);
      users.removeAt(i);
    }
  }

  if (users.length == 1) {
    final finalData = users;
    finalData
      ..addAll(eliminatedUsers)
      ..sort((a, b) => a.name.compareTo(b.name));

    print(
      'After Calculation #${index - 1}: ${finalData.map((e) => e.toString())}',
    );
    print('==============================================\n\n');
    print('Winner: Player#${getWinners(users)}');
    print('==============================================\n\n');
    return false;
  }
  print('After Calculation #${index - 1}: ${users.map((e) => e.toString())}');
  print('==============================================\n\n');
  return true;
}
