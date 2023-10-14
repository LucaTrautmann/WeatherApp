import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/pages/weather_page/weather_cubit.dart';

import '../../../constants.dart';
import '../../../styles.dart';
import '../weather_state.dart';

class TodaysWeather extends StatefulWidget {
  const TodaysWeather({
    Key? key,
  }) : super(key: key);

  @override
  State<TodaysWeather> createState() => _TodaysWeatherState();
}

class _TodaysWeatherState extends State<TodaysWeather> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onSearchPressed(BuildContext context) async {
    if (_searchController.text.isNotEmpty) {
      if (mounted) {
        await context
            .read<WeatherCubit>()
            .getWeatherBySearch(_searchController.text);
        // ignore: use_build_context_synchronously
        await context
            .read<WeatherCubit>()
            .getWeatherForecastbySearch(_searchController.text);
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Please enter a city name.')),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      cursorColor: Styles.cursorColor,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Styles.labelColor),
        labelText: 'Search for other City',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Styles.borderColor),
          borderRadius: BorderRadius.circular(Styles.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Styles.borderColor),
          borderRadius: BorderRadius.circular(Styles.borderRadius),
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return SizedBox(
      height: Constants.buttonSize,
      width: Constants.buttonSize,
      child: ElevatedButton(
          onPressed: () => _onSearchPressed(context),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white),
          child: const Icon(Icons.search, color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(child: _buildSearchField()),
                  const SizedBox(width: 8),
                  _buildSearchButton(context),
                ],
              ),
            ),
            const SizedBox(height: Styles.defaultDividerSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  state.location,
                  style: Styles.defaultThinFont,
                  textAlign: TextAlign.left,
                ),
                Text(
                  DateFormat('MMMM d, y').format(
                      DateTime.fromMillisecondsSinceEpoch(state.date * 1000)),
                  style: Styles.defaultThinFont,
                ),
                SizedBox(
                  height: Styles.iconHight,
                  width: Styles.iconWidth,
                  child: Image.network(
                    state.currentWeatherIconUrl.toString(),
                  ),
                ),
                Text(
                  state.currentWeatherText,
                  style: Styles.defaultThinFont,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: Styles.paddingbig),
                child: Text(
                  "${state.currentTemp}°",
                  style: const TextStyle(fontSize: Styles.mainFontSize),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
