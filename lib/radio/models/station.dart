import 'dart:convert';

import 'package:equatable/equatable.dart';

typedef JSON = Map<String, dynamic>;

class Station extends Equatable {
  const Station({
    required this.stationUuid,
    required this.name,
    required this.url,
    required this.homepage,
    required this.favicon,
    required this.tags,
    required this.country,
    required this.countryCode,
    required this.state,
    required this.language,
    required this.votes,
    required this.clicktrend,
    required this.clickcount,
    required this.codec,
    required this.geoLat,
    required this.geoLong,
  });
  factory Station.fromJson(String source) =>
      Station.fromMap(json.decode(source) as JSON);

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      stationUuid: map['stationuuid'] as String? ?? '',
      name: map['name'] as String? ?? '',
      url: map['url_resolved'] as String? ?? '',
      homepage: map['homepage'] as String? ?? '',
      favicon: map['favicon'] as String? ?? '',
      tags: map['tags'] as String? ?? '',
      country: map['country'] as String? ?? '',
      countryCode: map['countrycode'] as String? ?? '',
      state: map['state'] as String? ?? '',
      language: map['language'] as String? ?? '',
      votes: map['votes'] as int? ?? 0,
      clicktrend: map['clicktrend'] as int? ?? 0,
      clickcount: map['clickcount'] as int? ?? 0,
      codec: map['codec'] as String? ?? '',
      geoLat: map['geo_lat'] as double? ?? 0.0,
      geoLong: map['geo_long'] as double? ?? 0.0,
    );
  }

  final String stationUuid;
  final String name;
  final String url;
  final String homepage;
  final String favicon;
  final String tags;
  final String country;
  final String countryCode;
  final String state;
  final String language;
  final int votes;
  final int clicktrend;
  final int clickcount;
  final String codec;
  final double geoLat;
  final double geoLong;

  Station copyWith({
    String? stationUuid,
    String? name,
    String? url,
    String? homepage,
    String? favicon,
    String? tags,
    String? country,
    String? countryCode,
    String? state,
    String? language,
    int? votes,
    int? clicktrend,
    int? clickcount,
    String? codec,
    double? geoLat,
    double? geoLong,
  }) {
    return Station(
      stationUuid: stationUuid ?? this.stationUuid,
      name: name ?? this.name,
      url: url ?? this.url,
      homepage: homepage ?? this.homepage,
      favicon: favicon ?? this.favicon,
      tags: tags ?? this.tags,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      state: state ?? this.state,
      language: language ?? this.language,
      votes: votes ?? this.votes,
      clicktrend: clicktrend ?? this.clicktrend,
      clickcount: clickcount ?? this.clickcount,
      codec: codec ?? this.codec,
      geoLat: geoLat ?? this.geoLat,
      geoLong: geoLong ?? this.geoLong,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stationuuid': stationUuid,
      'name': name,
      'url_resolved': url,
      'homepage': homepage,
      'favicon': favicon,
      'tags': tags,
      'country': country,
      'countrycode': countryCode,
      'state': state,
      'language': language,
      'votes': votes,
      'clicktrend': clicktrend,
      'clickcount': clickcount,
      'codec': codec,
      'geo_lat': geoLat,
      'geo_long': geoLong,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''Station(stationUuid: $stationUuid, name: $name, url: $url, homepage: $homepage, favicon: $favicon, tags: $tags, country: $country, countryCode: $countryCode, state: $state, language: $language, votes: $votes, clicktrend: $clicktrend, clickcount: $clickcount, codec: $codec, geoLat: $geoLat, geoLong: $geoLong)''';
  }

  @override
  List<Object> get props {
    return [
      stationUuid,
      name,
      url,
      homepage,
      favicon,
      tags,
      country,
      countryCode,
      state,
      language,
      votes,
      clicktrend,
      clickcount,
      codec,
      geoLat,
      geoLong,
    ];
  }
}
