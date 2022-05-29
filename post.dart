class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class feelslike {
  final double feels_like;

  feelslike({required this.feels_like});

  factory feelslike.fromJson(Map<String, dynamic> json) {
    final feels_like = json['feels_like'];
    return feelslike(feels_like: feels_like);
  }
}

class WeatherResponse {
  late final dynamic cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final feelslike feels_like;

  WeatherResponse({
    required this.cityName,
    required this.tempInfo,
    required this.weatherInfo,
    required this.feels_like,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final dynamic tempInfoJson = json['main'];
    final dynamic tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    final feels_likeJson = json['main'];
    final feels_like = feelslike.fromJson(feels_likeJson);

    return WeatherResponse(
        cityName: cityName,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo,
        feels_like: feels_like);
  }
}
