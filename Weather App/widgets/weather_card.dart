import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  String formatTime(int timestamp) {
    final date =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final desc = weather.description.toLowerCase();

    String animationPath;

    if (desc.contains('rain')) {
      animationPath = 'assets/rainy.json';
    } else if (desc.contains('clear')) {
      animationPath = 'assets/sunny.json';
    } else if (desc.contains('snow')) {
      animationPath = 'assets/snow.json';
    } else {
      animationPath = 'assets/cloudy.json';
    }

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(113, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SAFE LOTTIE (prevents red box crash)
              SizedBox(
                height: 150,
                width: 150,
                child: Lottie.asset(
                  animationPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.cloud,
                      size: 100,
                      color: Colors.white,
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.displaySmall,
              ),

              const SizedBox(height: 10),

              Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Humidity : ${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Wind : ${weather.windSpeed} m/s',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.wb_sunny_outlined,
                        color: Colors.orange,
                      ),
                      Text(
                        'Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formatTime(weather.sunrise),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      const Icon(
                        Icons.nights_stay_outlined,
                        color: Colors.purple,
                      ),
                      Text(
                        'Sunset',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formatTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}