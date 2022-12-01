import 'dart:math';

import 'package:dice/utils/constants.dart';

// Generate dices for a player
List<int> getDices(int playerDices) => List.generate(
      playerDices,
      (index) => Random().nextInt(MAX_DICE_NUMBER) + 1,
    );
