import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';
import '../../../domain/model/report.dart';
import 'i_report_datasource.dart';

class ReportDataSource implements IReportDataSource {
  final http.Client httpClient;
  final String apiKey = 'EELunh';

  ReportDataSource({http.Client? client})
      : httpClient = client ?? http.Client();
  @override
  Future<List<Report>> getReports() async {
    List<Report> reports = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/reports")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await httpClient.get(request);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      reports = List<Report>.from(data.map((x) => Report.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
    return Future.value(reports);
  }

  @override
  Future<bool> addReport(Report report) async {
    logInfo("Adding report");
    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/reports"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode == 201) {
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> updateReport(Report report) async {
    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/reports/${report.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteReport(int id) async {
    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/reports/$id"),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> patchReport(int reportId, int newRating) async {
    final response = await httpClient.patch(
      Uri.parse("https://retoolapi.dev/$apiKey/reports/$reportId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'Rating': newRating,
      }),
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }
}
