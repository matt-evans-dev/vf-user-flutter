class AppStrings {
  AppStrings._();

  // General:
  static const String appName = "Vuaci User";

  // App Bar String:
  static const String appBarTitle = "Taste More Waste Less!";

  // Preference String:
  static const String isLoggedIn = "is_logged_in";
  static const String authToken = "auth_token";
  static const String isDarkMode = "is_dark_mode";
  static const String location = "location";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String filters = "filters";
  static const String rating = "rating";
  static const String price = "price";
  static const String cartItems = "cart_items";
  static const String fcmToken = "fcm_token";

  // policy urls
  static const String termsURL = 'https://www.vuacifood.com/terms-and-conditions';
  static const String policyURL = 'https://www.vuacifood.com/privacy-statement';

  // Bottom Bar:
  static const String homeBtm = "Home";
  static const String nearBtm = "Near me";
  static const String cartBtm = "Cart";
  static const String orderBtm = "Orders";
  static const String accountBtm = "Account";

  // Home Screen:
  static const String homeBlank = 'Nothing available, check back later';

  static const String flAll = "All";

  static const String flAmerican = "American";
  static const String flMexican = "Mexican";
  static const String flItalian = "Italian";
  static const String flJapanese = "Japanese";

  static const List<String> flCountries = [
    'American',
    'Mexican',
    'Chinese',
    'Japanese',
    'Korean',
    'French',
    'Italian',
    'Indian',
    'Thai',
  ];

  static const List<String> flFoods = [
    'Pizza',
    'Seafood',
    'Meat',
    'Breakfast',
    'Soups',
    'Salads',
    'Dessert',
  ];

  static const List<String> flDietaries = [
    'Vegetarian',
    'Vegan',
    'Gluten free',
    'Eco',
    'Lactose free',
  ];

  static const List<String> flRatingList = [
    " 4 & Up ",
    " 3 & Up ",
    " 2 & Up ",
    " 1 & Up ",
  ];

  static const countryCodes = ["(US) +1"];

  static const searchFilterOptions = [
    'Foods',
    'Restaurants',
  ];
}
