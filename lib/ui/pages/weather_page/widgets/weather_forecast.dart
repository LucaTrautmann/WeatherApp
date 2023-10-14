import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../styles.dart';
import '../weather_cubit.dart';
import '../weather_state.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text("5 Day Weather Forecast", style: TextStyle(fontSize: 17)),
            ]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: state.forecastElements
                  .map((forecastElement) => Column(
                        children: [
                          Text(DateFormat.E().format(forecastElement.dateTime)),
                          SizedBox(
                            height: Styles.iconHight,
                            width: Styles.iconWidth,
                            child: Image.network(
                              "https://openweathermap.org/img/wn/${forecastElement.iconId}@2x.png",
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            )
          ],
        );
      },
    );
  }
}
