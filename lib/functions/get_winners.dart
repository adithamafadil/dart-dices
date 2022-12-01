import 'package:dice/dice.dart';

String getWinners(List<User> users) => users
    .reduce((current, next) => current.point >= next.point ? current : next)
    .name;
