import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/models/auth/user.dart';
import 'package:vf_user_flutter_new/models/customer_card/customer_card.dart';

class AuthStore {
  BehaviorSubject<bool> isLoggedIn;
  BehaviorSubject<User> userDetail;
  BehaviorSubject<List<CustomerCard>> userCards;

  AuthStore(bool savedValue) {
    isLoggedIn = BehaviorSubject<bool>.seeded(savedValue);
    userDetail = BehaviorSubject<User>.seeded(new User());
    userCards = BehaviorSubject<List<CustomerCard>>.seeded([]);
  }

  void changeAuthState(bool value) {
    isLoggedIn.add(value);
  }

  User setUserDetail(jsonData) {
    User user = new User.fromJson(jsonData);
    userDetail.add(user);
    User userEditable = new User.fromJson(jsonData);
    return userEditable;
  }

  void removeUserDetail() {
    userDetail.drain();
  }

  void setUserCards(jsonData) {
    List<dynamic> body = jsonData["data"];
    userCards.add(body
        .map(
          (dynamic item) => CustomerCard.fromJson(item),
        )
        .toList());
  }
}
