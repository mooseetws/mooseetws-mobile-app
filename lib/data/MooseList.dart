class MooseLocation {
  final double lat;
  final double lan;

  MooseLocation({this.lat, this.lan});

  factory MooseLocation.fromJson(Map<String, dynamic> json){
    return new MooseLocation(
      lan: json['lan'],
      lat: json['lat'],
    );
  }
}


class MooseLocationsList {
  final List<MooseLocation> mooseLocations;

  MooseLocationsList({
    this.mooseLocations,
  });

  factory MooseLocationsList.fromJson(List<dynamic> parsedJson) {

    List<MooseLocation> mooseLocations = new List<MooseLocation>();
    mooseLocations = parsedJson.map((i)=>MooseLocation.fromJson(i)).toList();

    return new MooseLocationsList(
        mooseLocations: mooseLocations
    );
  }
}