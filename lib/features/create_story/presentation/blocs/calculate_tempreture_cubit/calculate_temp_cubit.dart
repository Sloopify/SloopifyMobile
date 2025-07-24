import 'dart:convert';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/location_service.dart';
import 'calculate_temp_state.dart';

class CalculateTempCubit extends Cubit<CalculateTempState> {
  CalculateTempCubit() : super(CalculateTempState());

  Future<double?> getCurrentTemperature() async {
    emit(state.copyWith(status: CalculateTempStatus.loading));
    final position = await LocationService.getLocationCoords();
    if (position != null) {
      pragma('nnnnnnnnnnnnnnn${position.lng}');
      return await fetchWeatherDetails(position.lat, position.lng);
    }
    return null;
  }

  Future<double?> fetchTemperature(double lat, double lon) async {
    const apiKey = 'c71d13f2526f444c023f9c0efc8f8707';
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['main']['temp']?.toDouble();
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  fetchWeatherDetails(double lat, double lon) async {
    const apiKey = 'c71d13f2526f444c023f9c0efc8f8707';
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null) {
        final temp = data['main']['temp'].toDouble();
        print('ttttttttttttttt${temp}');
        final iconCode = data['weather'][0]['icon'];
        print('iccccon${iconCode}');
        final isDay = iconCode.contains('d');
        emit(state.copyWith(isDay: isDay));
        print('dddddddddddddddddd${isDay}');
        final weatherCode = data['weather'][0]['id'];
        print('weather code ${weatherCode}');
        String weatherIcon = getWeatherSticker();
        emit(
          state.copyWith(
            tempC: temp,
            isDay: isDay,
            weatherCode: weatherCode,
            status: CalculateTempStatus.success,
            weatherIcon: weatherIcon,
          ),
        );
        final TemperatureElement temperatureElement = TemperatureElement(
          value: state.tempC,
          id: Uuid().v4(),
          weatherCode: state.weatherIcon,
          isDay: state.isDay,
          offset: Offset(500, 500),
          rotation: 0.0,
           scale: 1.0
        );
        emit(state.copyWith(element: temperatureElement));

      }
    } else {
      emit(state.copyWith(status: CalculateTempStatus.error));
    }
  }

  String getWeatherSticker() {
    // Define weather condition category
    final isRain = state.weatherCode >= 200 && state.weatherCode < 600;
    final isSnow = state.weatherCode >= 600 && state.weatherCode < 700;
    final isCloudy = state.weatherCode > 800;
    final isClear = state.weatherCode == 800;

    // 🌙 or ☀️ based on time
    final timeEmoji = state.isDay ? '☀️' : '🌙';

    // 🌧️ if raining
    if (isRain) {
      if (state.tempC >= 20 && state.isDay) return '🌦️'; // sun + rain
      if (state.tempC >= 20 && !state.isDay) return '🌧️🌙'; // night rain
      return state.isDay ? '🌧️' : '🌧️🌙';
    }

    // ❄️ if snowing
    if (isSnow) return '❄️$timeEmoji';

    // ☁️ if cloudy
    if (isCloudy) {
      if (state.tempC < 15) return '☁️❄️$timeEmoji'; // cold cloudy
      return '☁️$timeEmoji';
    }

    // ☀️ or 🌙 for clear
    if (isClear) {
      if (state.tempC >= 25 && state.isDay) return '🔥☀️'; // hot sunny
      if (state.tempC <= 5 && state.isDay) return '❄️☀️';
      if (state.tempC <= 5 && !state.isDay) return '❄️🌙';
      return timeEmoji;
    }

    return timeEmoji; // fallback
  }
}
