import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/pages/weather_page/weather_cubit.dart';

import '../../../styles.dart';
import '../weather_state.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Expanded(child: Icon(Icons.arrow_upward)),
                    Expanded(child: Center(child: Icon(Icons.wb_twilight))),
                    Expanded(
                      child: Center(
                        child: Text(
                          "humidity",
                          style: Styles.defaultThinFont,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "sea level",
                          style: Styles.defaultThinFont,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                            child: Text("${state.tempMax.toString()}°",
                                style: const TextStyle(
                                    fontSize: Styles.defaultThickFontSize)))),
                    Expanded(
                        child: Center(
                            child: Text(
                      DateFormat('HH:mm').format(state.sunrise),
                      style: const TextStyle(
                          fontSize: Styles.defaultThickFontSize),
                    ))),
                    Expanded(
                      child: Center(
                        child: Text(
                          "${state.humidity.toString()}%",
                          style: const TextStyle(
                              fontSize: Styles.defaultThickFontSize),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Center(
                            child: Text("${state.seaLevel} m",
                                style: const TextStyle(
                                    fontSize: Styles.defaultThickFontSize)))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Expanded(child: Center(child: Icon(Icons.arrow_downward))),
                    Expanded(child: Center(child: Icon(Icons.nights_stay))),
                    Expanded(
                      child: Center(
                        child: Text(
                          "wind",
                          style: Styles.defaultThinFont,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "pressure",
                          style: Styles.defaultThinFont,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                            child: Text("${state.tempMin}°",
                                style: const TextStyle(
                                    fontSize: Styles.defaultThickFontSize)))),
                    Expanded(
                        child: Center(
                            child: Text(DateFormat('HH:mm').format(state.dawn),
                                style: const TextStyle(
                                    fontSize: Styles.defaultThickFontSize)))),
                    Expanded(
                        child: Center(
                            child: Text("${state.wind} m/s",
                                style: const TextStyle(
                                    fontSize: Styles.defaultThickFontSize)))),
                    Expanded(
                        child: Center(
                            child: Text("${state.pressure} mmhg",
                                style: const TextStyle(
                                    fontSize: Styles.defaultThickFontSize)))),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
