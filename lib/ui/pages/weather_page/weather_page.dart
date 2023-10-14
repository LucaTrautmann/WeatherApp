import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/ui/pages/weather_page/weather_cubit.dart';
import 'package:weather_app/ui/pages/weather_page/weather_state.dart';
import 'package:weather_app/ui/pages/weather_page/widgets/weather_forecast.dart';
import 'package:weather_app/ui/widgets/custom_divider.dart';

import '../../styles.dart';
import 'forecast_page.dart';
import 'widgets/todays_weather.dart';
import 'widgets/weather_details.dart';

const _dotSize = 8.0;

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    super.key,
  });

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  bool _isAnyDialogActive = false;

  @override
  void initState() {
    context.read<WeatherCubit>().init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Padding(
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TodaysWeather(),
              CustomDivider(),
              SizedBox(height: Styles.defaultDividerSpace),
              WeatherDetails(),
              SizedBox(height: Styles.defaultDividerSpace),
              CustomDivider(),
              SizedBox(height: Styles.defaultDividerSpace),
              WeatherForecast(),
            ]),
      ),
      const ForecastPage(),
    ];
    return BlocListener<WeatherCubit, WeatherState>(
      listener: (context, state) async {
        if (state.errorMessage.isNotEmpty && !_isAnyDialogActive) {
          setState(() {
            _isAnyDialogActive = true;
          });
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: Column(
                  children: [
                    Text(state.errorMessage),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
          if (mounted) {
            context.read<WeatherCubit>().resetErrorMessage();
          }

          _isAnyDialogActive = false;
        }
      },
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text("Weather App"),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              elevation: 0.0,
            ),
            body: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                          color: Colors.black, size: 100));
                }
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: state.background, fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _controller,
                          physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.normal),
                          onPageChanged: (int pageIndex) {
                            setState(() {
                              _currentPageIndex = pageIndex;
                            });
                          },
                          itemBuilder: (context, index) {
                            return pages[index];
                          },
                          itemCount: pages.length,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pages.length,
                            (index) => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              width: _dotSize,
                              height: _dotSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPageIndex == index
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
