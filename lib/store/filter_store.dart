import 'package:rxdart/rxdart.dart';

class FilterStore {
  BehaviorSubject<int> kitchenQueryIndex = BehaviorSubject<int>();
  BehaviorSubject<int> foodQueryIndex = BehaviorSubject<int>();
  BehaviorSubject<int> dietaryQueryIndex = BehaviorSubject<int>();
  BehaviorSubject<int> ratingQueryIndex = BehaviorSubject<int>();
  BehaviorSubject<double> minPriceQuery = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> maxPriceQuery = BehaviorSubject<double>.seeded(0.0);

  Stream get kitchenStream => kitchenQueryIndex.stream;
  int get kitchenIndex => kitchenQueryIndex.value;
  int get foodIndex => foodQueryIndex.value;
  int get dietaryIndex => dietaryQueryIndex.value;
  int get ratingIndex => ratingQueryIndex.value;
  double get minPrice => minPriceQuery.value;
  double get maxPrice => maxPriceQuery.value;

  void dispose() {
    kitchenQueryIndex.close();
    foodQueryIndex.close();
    dietaryQueryIndex.close();
    ratingQueryIndex.close();
    minPriceQuery.close();
    maxPriceQuery.close();
  }

  void init() {
    kitchenQueryIndex.add(null);
    foodQueryIndex.add(null);
    dietaryQueryIndex.add(null);
    ratingQueryIndex.add(null);
    minPriceQuery.add(0.0);
    maxPriceQuery.add(0.0);
  }
}
