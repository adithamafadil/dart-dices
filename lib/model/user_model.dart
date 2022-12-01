import 'package:dice/utils/constants.dart';

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
