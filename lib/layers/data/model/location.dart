
List<Location> getListOfLocations(List<dynamic> json) => List.from(json.map((e) => Location.fromJson(e)).toList());

class Location {
  final String name;
  final String country;
  final String localtime;

  Location({required this.name,required this.country,required this.localtime});

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "country": this.country,
      "localtime": this.localtime,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
      country: json["country"],
      localtime: json["localtime"] ?? "",
    );
  }
//
}