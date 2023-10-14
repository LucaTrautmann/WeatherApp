import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/ui/pages/weather_page/weather_cubit.dart';
import 'package:weather_app/ui/pages/weather_page/weather_state.dart';
import 'package:weather_app/ui/pages/weather_page/widgets/detailed_forecast.dart';

import '../../styles.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DetailedForecast(),
              ]),
        );
      },
    );
  }
}
