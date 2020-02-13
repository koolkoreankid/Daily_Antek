import 'dart:math';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  static Random random = Random();

  final String uid;
  String userName;
  int level;
  int points;
  String mood;
  int quoteNum;

  UserData({this.uid, this.userName, this.level, this.points, this.mood, this.quoteNum});

  upgrade() {
    int numb = random.nextInt(1000);
    print(numb);
    if (points <= 0) {
    } else if (numb > 500 || level == 1) {
      //50% winrate
      // 50% chance
      return true;
    } else {
      return false;
    }
  }

  checkZero() {
    if (points == 0) {
      return true;
    }
  }

  imageStatus() {
    switch (level) {
      case 1:
        return "assets/images/antek_normal.jpg";
        break;
      case 2:
        return "assets/images/antek_drink.jpg";
        break;
      case 3:
        return "assets/images/antek_asleep.jpg";
        break;
      case 4:
        return "assets/images/antek_bored.jpg";
        break;
      case 5:
        return "assets/images/antek_caught.png";
        break;
      case 6:
        return "assets/images/antek_cum.png";
        break;
      case 7:
        return "assets/images/antek_harrased.png";
        break;
      case 8:
        return "assets/images/antek_jumpscare.jpg";
        break;
      case 9:
        return "assets/images/antek_naked.jpg";
        break;
      case 10:
        return "assets/images/antek_stare.jpg";
        break;
      default:
        return "assets/images/antek_default.jpg";
        break;
    }
  }
}
