// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/repositories/api/api_repository.dart';
import 'package:weather_app/ui/pages/weather_page/weather_cubit.dart';

import 'ui/pages/weather_page/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiRepository(),
      child: BlocProvider(
        create: (context) => WeatherCubit(context.read<ApiRepository>()),
        child: MaterialApp(
            theme: ThemeData(fontFamily: "Comfortaa"), home: WeatherPage()),
      ),
    );
  }
}
