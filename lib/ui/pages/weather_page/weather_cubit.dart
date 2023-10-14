import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/ui/pages/weather_page/weather_state.dart';

import '../../../repositories/api/api_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final ApiRepository _apiRepository;
  WeatherCubit(this._apiRepository)
      : super(WeatherState(
          location: "-",
          date: 0,
          currentWeatherIconUrl: "04d",
          currentWeatherText: "-",
          currentTemp: 0.0,
          tempMax: 0.0,
          tempMin: 0.0,
          sunrise: DateTime.now(),
          dawn: DateTime.now(),
          humidity: 0,
          wind: 0,
          seaLevel: 0,
          pressure: 0,
          forecastElements: [],
          background: const AssetImage("assets/pics/sunny.jpg"),
          isLoading: false,
          errorMessage: "",
          timeOffset: 0,
        ));

  void init() async {
    emit(state.copyWith(isLoading: true));
    Position position = await getPosition();
    emit(state.copyWith(lat: position.latitude, long: position.longitude));
    await getWeatherByLocation();
    await getWeatherForecastbyLocation();
    emit(state.copyWith(isLoading: false));
  }

  void resetErrorMessage() {
    emit(state.copyWith(errorMessage: ""));
  }

  Future<void> getWeatherByLocation() async {
    try {
      final apiModel = await _apiRepository.getWeatherByLatLon(
          state.lat ?? 0.0, state.long ?? 0.0);

      emit(state.copyWith(
        location: apiModel?.name,
        date: apiModel?.dt,
        currentWeatherText: apiModel?.weather?[0].main,
        currentTemp: apiModel?.main?.temp?.round(),
        tempMax: apiModel?.main?.tempMax?.round(),
        tempMin: apiModel?.main?.tempMin?.round(),
        sunrise: DateTime.fromMillisecondsSinceEpoch(
                ((apiModel?.sys?.sunrise ?? 0) + (apiModel?.timezone ?? 0)) *
                    1000)
            .subtract(const Duration(hours: 1)),
        dawn: DateTime.fromMillisecondsSinceEpoch(
                ((apiModel?.sys?.sunset ?? 0) + (apiModel?.timezone ?? 0)) *
                    1000)
            .subtract(const Duration(hours: 1)),
        humidity: apiModel?.main?.humidity,
        wind: apiModel?.wind?.speed,
        seaLevel: apiModel?.main?.seaLevel,
        pressure: apiModel?.main?.pressure,
        currentWeatherIconUrl:
            "https://openweathermap.org/img/wn/${apiModel?.weather?[0].icon}@2x.png",
        timeOffset: apiModel?.timezone,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Current Weather Data unavailable"));
    }
  }

  Future<void> getWeatherBySearch(String cityName) async {
    try {
      final apiModel = await _apiRepository.getWeatherByCity(cityName);
      emit(state.copyWith(
        location: apiModel?.name,
        date: apiModel?.dt,
        currentWeatherText: apiModel?.weather?[0].main,
        currentTemp: apiModel?.main?.temp?.round(),
        tempMax: apiModel?.main?.tempMax?.round(),
        tempMin: apiModel?.main?.tempMin?.round(),
        sunrise: DateTime.fromMillisecondsSinceEpoch(
                ((apiModel?.sys?.sunrise ?? 0) + (apiModel?.timezone ?? 0)) *
                    1000)
            .subtract(const Duration(hours: 1)),
        dawn: DateTime.fromMillisecondsSinceEpoch(
                ((apiModel?.sys?.sunset ?? 0) + (apiModel?.timezone ?? 0)) *
                    1000)
            .subtract(const Duration(hours: 1)),
        humidity: apiModel?.main?.humidity,
        wind: apiModel?.wind?.speed,
        seaLevel: apiModel?.main?.seaLevel,
        pressure: apiModel?.main?.pressure,
        currentWeatherIconUrl:
            "https://openweathermap.org/img/wn/${apiModel?.weather?[0].icon}@2x.png",
        timeOffset: apiModel?.timezone,
      ));
    } catch (e) {
      emit(state.copyWith(
          errorMessage:
              "Please check the spelling.\n Enter a corret city name."));
    }
  }

  Future<void> getWeatherForecastbyLocation() async {
    try {
      final apiForecastModel = await _apiRepository.getForecastByLatLon(
          state.lat ?? 0.0, state.long ?? 0.0);
      final weatherElements =
          apiForecastModel?.weatherCollection?.where((weatherEntry) {
        final dateTimeOfElement =
            DateTime.fromMillisecondsSinceEpoch(weatherEntry.dt! * 1000);
        final shallPass =
            dateTimeOfElement.hour > 13 && dateTimeOfElement.hour <= 16;
        return shallPass;
      }).map((weatherEntry) {
        return ForeCastElement(
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(weatherEntry.dt! * 1000),
          iconId: weatherEntry.weather?.first.icon ?? "",
          tempMax: weatherEntry.main?.tempMax?.round() ?? 0,
          tempMin: weatherEntry.main?.tempMin?.round() ?? 0,
          forecastWeatherIconUrl:
              "https://openweathermap.org/img/wn/${weatherEntry.weather?[0].icon}@2x.png",
          humidity: weatherEntry.main?.humidity ?? 0,
          wind: weatherEntry.wind?.speed ?? 0.0,
          seaLevel: weatherEntry.main?.seaLevel ?? 0,
          pressure: weatherEntry.main?.pressure ?? 0,
        );
      }).toList();

      emit(state.copyWith(forecastElements: weatherElements));
    } catch (e) {
      debugPrint("getWeatherForecast failed");
    }
  }

  Future<void> getWeatherForecastbySearch(String cityName) async {
    try {
      final apiForecastModel = await _apiRepository.getForecastByCity(cityName);
      final weatherElements =
          apiForecastModel?.weatherCollection?.where((weatherEntry) {
        final dateTimeOfElement =
            DateTime.fromMillisecondsSinceEpoch(weatherEntry.dt! * 1000);
        final shallPass =
            dateTimeOfElement.hour > 13 && dateTimeOfElement.hour <= 16;
        return shallPass;
      }).map((weatherEntry) {
        return ForeCastElement(
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(weatherEntry.dt! * 1000),
          iconId: weatherEntry.weather?.firstOrNull?.icon ?? "",
          tempMax: weatherEntry.main?.tempMax ?? 0,
          tempMin: weatherEntry.main?.tempMin ?? 0,
          forecastWeatherIconUrl:
              "https://openweathermap.org/img/wn/${weatherEntry.weather?[0].icon}@2x.png",
          humidity: weatherEntry.main?.humidity ?? 0,
          wind: weatherEntry.wind?.speed ?? 0.0,
          seaLevel: weatherEntry.main?.seaLevel ?? 0,
          pressure: weatherEntry.main?.pressure ?? 0,
        );
      }).toList();

      emit(state.copyWith(forecastElements: weatherElements));
    } catch (e) {
      debugPrint("getWeatherForecastbySearch failed");
    }
  }

  Future<Position> getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location permission are permanently denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
