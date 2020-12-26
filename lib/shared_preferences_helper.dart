import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  static SharedPreferencesHelper sharedPreferencesHelper =
      SharedPreferencesHelper._();
  SharedPreferences sharedPreferences;
  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  writeSomethingToSharedPreferences(String name, int age, bool isMale) {
    sharedPreferences.setString('name', name);
    sharedPreferences.setInt('age', age);
    sharedPreferences.setBool('isMale', isMale);
  }

  Map getUserDate() {
    return {
      'name': sharedPreferences.getString('name'),
      'age': sharedPreferences.getInt('age'),
      'isMale': sharedPreferences.getBool('isMale')
    };
  }
}
