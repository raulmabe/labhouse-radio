import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:labhouse_test/radio/models/errors.dart';
import 'package:labhouse_test/radio/models/station.dart';

class RadioBrowserRepository {
  static String endpoint = '91.132.145.114';

  Future<List<Station>> fetchAll() async {
    final uri = Uri.parse(
      'http://${RadioBrowserRepository.endpoint}/json/stations/topvote?hidebroken=true&limit=20',
    );
    final resp = await http.get(uri);

    if (resp.statusCode == 200 && resp.body.isNotEmpty) {
      log(resp.body);
      return List<JSON>.from(json.decode(resp.body) as List)
          .map<Station>(Station.fromMap)
          .toList();
    }

    throw NetworkError();
  }
}
