import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather.dart';

void main() {
  group('Weather Model Tests', () {
    test('should create a valid Weather instance from Manila OpenWeatherMap JSON', () {
      // Complete realistic Manila sample
      final Map<String, dynamic> manilaJson = {
        "weather": [
          {"main": "Clouds"}
        ],
        "main": {
          "temp": 31.02,
          "humidity": 62
        },
        "wind": {
          "speed": 4.12
        },
        "name": "Manila"
      };

      final weather = Weather.fromJson(manilaJson);

      expect(weather.city, 'Manila');
      expect(weather.temperature, 31.02);
      expect(weather.description, 'Clouds');
      expect(weather.humidity, 62);
      expect(weather.windSpeed, 4.12);
    });

    test('should handle integer values for temperature and wind gracefully', () {
      // API often returns 30 instead of 30.0
      final Map<String, dynamic> jsonWithInts = {
        "weather": [
          {"main": "Clear"}
        ],
        "main": {
          "temp": 30, // Integer
          "humidity": 50
        },
        "wind": {
          "speed": 5 // Integer
        },
        "name": "Manila"
      };

      // Line 49: This will now pass because all required keys are present
      final weather = Weather.fromJson(jsonWithInts);

      // Line 51: This will now pass because of (as num).toDouble() in your model
      expect(weather.temperature, 30.0);
      expect(weather.windSpeed, 5.0);
    });
  });
}