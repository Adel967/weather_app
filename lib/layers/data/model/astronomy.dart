class Astronomy {
  final String sunrise;
  final String sunset;
  final bool is_sun_up;

  Astronomy({required this.sunrise, required this.sunset, required this.is_sun_up});

  factory Astronomy.fromJson(Map<String, dynamic> json) {
    return Astronomy(
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      is_sun_up: json["is_sun_up"] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sunrise": this.sunrise,
      "sunset": this.sunset,
      "is_sun_up": this.is_sun_up,
    };
  }

}