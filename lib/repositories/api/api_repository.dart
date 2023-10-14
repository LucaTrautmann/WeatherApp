import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/repositories/api/models/api_model/weather_forecast_api_model.dart';

import 'models/api_model/weather_api_model.dart';

class ApiRepository {
  Future<WeatherApiModel?> getWeatherByLatLon(
    final double lat,
    final double long,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${lat.toString()}&lon=${long.toString()}&appid=23006cadbb1427f1b655e60a969e48dd&units=metric"));
      return WeatherApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<WeatherApiModel?> getWeatherByCity(
    final String city,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=23006cadbb1427f1b655e60a969e48dd&units=metric"));
      return WeatherApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<WeatherForecastApiModel?> getForecastByLatLon(
    final double lat,
    final double long,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?lat=${lat.toString()}&lon=${long.toString()}&appid=23006cadbb1427f1b655e60a969e48dd&units=metric"));
      return WeatherForecastApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<WeatherForecastApiModel?> getForecastByCity(
    final String city,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=23006cadbb1427f1b655e60a969e48dd&units=metric"));
      return WeatherForecastApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
