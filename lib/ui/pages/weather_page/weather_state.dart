// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class WeatherState {
  final String location;
  final int date;
  final String currentWeatherText;
  final num currentTemp;
  final num tempMax;
  final num tempMin;
  final DateTime sunrise;
  final DateTime dawn;
  final int humidity;
  final num wind;
  final int seaLevel;
  final int pressure;
  final List<ForeCastElement> forecastElements;
  final AssetImage background;
  final double? lat;
  final double? long;
  final String? currentWeatherIconUrl;
  final String? city;
  final bool isLoading;
  final String errorMessage;
  final int timeOffset;

  WeatherState({
    required this.location,
    required this.date,
    required this.currentWeatherText,
    required this.currentTemp,
    required this.tempMax,
    required this.tempMin,
    required this.sunrise,
    required this.dawn,
    required this.humidity,
    required this.wind,
    required this.seaLevel,
    required this.pressure,
    required this.forecastElements,
    required this.background,
    this.lat,
    this.long,
    this.city,
    this.currentWeatherIconUrl,
    required this.isLoading,
    required this.errorMessage,
    required this.timeOffset,
  });

  WeatherState copyWith({
    String? location,
    int? date,
    String? currentWeatherText,
    num? currentTemp,
    num? tempMax,
    num? tempMin,
    DateTime? sunrise,
    DateTime? dawn,
    int? humidity,
    num? wind,
    int? seaLevel,
    int? pressure,
    List<ForeCastElement>? forecastElements,
    AssetImage? background,
    double? lat,
    double? long,
    String? city,
    String? currentWeatherIconUrl,
    bool? isLoading,
    String? errorMessage,
    int? timeOffset,
  }) {
    return WeatherState(
        location: location ?? this.location,
        date: date ?? this.date,
        currentWeatherText: currentWeatherText ?? this.currentWeatherText,
        currentTemp: currentTemp ?? this.currentTemp,
        tempMax: tempMax ?? this.tempMax,
        tempMin: tempMin ?? this.tempMin,
        sunrise: sunrise ?? this.sunrise,
        dawn: dawn ?? this.dawn,
        humidity: humidity ?? this.humidity,
        wind: wind ?? this.wind,
        seaLevel: seaLevel ?? this.seaLevel,
        pressure: pressure ?? this.pressure,
        forecastElements: forecastElements ?? this.forecastElements,
        background: background ?? this.background,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        city: city ?? this.city,
        currentWeatherIconUrl:
            currentWeatherIconUrl ?? this.currentWeatherIconUrl,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        timeOffset: timeOffset ?? this.timeOffset);
  }
}

class ForeCastElement {
  final DateTime dateTime;
  final String iconId;
  final num tempMax;
  final num tempMin;
  final String? forecastWeatherIconUrl;
  final int humidity;
  final num wind;
  final int seaLevel;
  final int pressure;

  ForeCastElement({
    required this.dateTime,
    required this.iconId,
    required this.tempMax,
    required this.tempMin,
    required this.forecastWeatherIconUrl,
    required this.humidity,
    required this.wind,
    required this.seaLevel,
    required this.pressure,
  });

  ForeCastElement copyWith({
    DateTime? dateTime,
    String? iconId,
    num? tempMax,
    num? tempMin,
    String? forecastWeatherIconUrl,
    int? humidity,
    num? wind,
    int? seaLevel,
    int? pressure,
  }) {
    return ForeCastElement(
      dateTime: dateTime ?? this.dateTime,
      iconId: iconId ?? this.iconId,
      tempMax: tempMax ?? this.tempMax,
      tempMin: tempMin ?? this.tempMin,
      forecastWeatherIconUrl:
          forecastWeatherIconUrl ?? this.forecastWeatherIconUrl,
      humidity: humidity ?? this.humidity,
      wind: wind ?? this.wind,
      seaLevel: seaLevel ?? this.seaLevel,
      pressure: pressure ?? this.pressure,
    );
  }
}
