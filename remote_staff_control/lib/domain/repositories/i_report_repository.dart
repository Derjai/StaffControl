import '../model/report.dart';

abstract class IReportRepository {
  Future<List<Report>> getReports();

  Future<bool> addReport(Report report);

  Future<bool> updateReport(Report report);

  Future<bool> deleteReport(int id);

  Future<bool> patchReport(int reportId, int newRating);
}
