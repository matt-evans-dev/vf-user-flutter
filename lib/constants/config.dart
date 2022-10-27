class AppConfig {
  AppConfig._();
  // Define keys.
  static const GOOGLE_MAP_API_KEY = 'AIzaSyCDOefuftnEry35da4JR6AX968Iz-i6evM';
  static const GOOGLE_PLACE_PREDICT_URL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const GOOGLE_PLACE_DETAIL_URL = 'https://maps.googleapis.com/maps/api/place/details/json';

  static const devEndpoint = 'https://preprod.vuacifood.com/v1/';
  static const productionEndpoint = 'https://preprod.vuacifood.com/v1/';
}
