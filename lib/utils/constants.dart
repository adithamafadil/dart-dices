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
