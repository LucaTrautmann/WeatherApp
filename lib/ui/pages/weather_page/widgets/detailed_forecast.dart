import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../styles.dart';
import '../weather_cubit.dart';
import '../weather_state.dart';

class DetailedForecast extends StatelessWidget {
  const DetailedForecast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            height: 700,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 250, 10, 20),
              children: state.forecastElements
                  .map((forecastElement) => Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: ExpansionTile(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          DateFormat.E()
                                              .format(forecastElement.dateTime),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: Styles.iconHight,
                                        width: Styles.iconWidth,
                                        child: Image.network(
                                          "https://openweathermap.org/img/wn/${forecastElement.iconId}@2x.png",
                                          scale: 2.8,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Icon(Icons.arrow_upward),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${forecastElement.tempMax}°",
                                      ),
                                    ),
                                    const Expanded(
                                      child: Icon(Icons.arrow_downward),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${forecastElement.tempMin}°",
                                      ),
                                    ),
                                  ],
                                ),
                                children: [
                                  SizedBox(
                                    height: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: const [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "humidity",
                                                    style:
                                                        Styles.defaultThinFont,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "sea level",
                                                    style:
                                                        Styles.defaultThinFont,
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
                                                  child: Text(
                                                    "${forecastElement.humidity}%",
                                                    style: const TextStyle(
                                                        fontSize: Styles
                                                            .defaultThickFontSize),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Center(
                                                      child: Text(
                                                          "${forecastElement.seaLevel} m",
                                                          style: const TextStyle(
                                                              fontSize: Styles
                                                                  .defaultThickFontSize)))),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: const [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "wind",
                                                    style:
                                                        Styles.defaultThinFont,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "pressure",
                                                    style:
                                                        Styles.defaultThinFont,
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
                                                      child: Text(
                                                          "${forecastElement.wind} m/s",
                                                          style: const TextStyle(
                                                              fontSize: Styles
                                                                  .defaultThickFontSize)))),
                                              Expanded(
                                                  child: Center(
                                                      child: Text(
                                                          "${forecastElement.pressure} mmhg",
                                                          style: const TextStyle(
                                                              fontSize: Styles
                                                                  .defaultThickFontSize)))),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
