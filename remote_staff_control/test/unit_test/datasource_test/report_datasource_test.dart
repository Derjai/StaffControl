import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:remote_staff_control/data/datasources/remote/report_datasource.dart';
import 'package:remote_staff_control/domain/model/report.dart';

void main() {
  late ReportDataSource dataSource;
  late http.Client httpClient;
  late Report newReport;

  setUp(() {
    httpClient = http.Client();
    dataSource = ReportDataSource(client: httpClient);
    newReport = Report(
      id: 1000,
      userId: 1,
      startDate: 1,
      duration: 1,
      problemDescription: 'Testing',
      rating: 0,
    );
  });

  tearDown(() async {
    await dataSource.deleteReport(newReport.id!);
    httpClient.close();
  });

  test('addReport adds a report', () async {
    bool result = await dataSource.addReport(newReport);
    expect(result, true, reason: 'Report was not added');
  });

  test('updateReport updates a report', () async {
    await dataSource.addReport(newReport);
    List<Report> reports = await dataSource.getReports();
    Report? createdReport =
        reports.firstWhereOrNull((report) => report.id == newReport.id);
    expect(createdReport, isNotNull,
        reason: 'Report was not created therefore not found');

    createdReport!.problemDescription = 'Updated';
    bool updateResult = await dataSource.updateReport(createdReport);
    expect(updateResult, isTrue, reason: 'Report was not updated');
  });

  test('deleteReport deletes a report', () async {
    await dataSource.addReport(newReport);
    List<Report> reports = await dataSource.getReports();
    Report? createdReport =
        reports.firstWhereOrNull((report) => report.id == newReport.id);
    expect(createdReport, isNotNull,
        reason: 'Report was not created therefore not found');

    bool deleteResult = await dataSource.deleteReport(createdReport!.id!);
    expect(deleteResult, isTrue, reason: 'Report was not deleted');
  });
}
