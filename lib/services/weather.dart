import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    final Location location = Location();
    await location.getCurrentLocation();

    final NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

    return await networkHelper.getData();
  }

  Future<dynamic> getCityWeather(String cityName) async {
    final NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherUrl?q=$cityName&appid=$kApiKey&units=metric');

    var d = await networkHelper.getData();
    print(d);
    return d;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
