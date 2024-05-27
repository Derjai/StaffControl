import '../model/report.dart';
import '../repositories/i_report_repository.dart';

class ReportUseCase {
  final IReportRepository _reportRepository;
  ReportUseCase(this._reportRepository);

  Future<List<Report>> getReports() async =>
      await _reportRepository.getReports();
  Future<bool> addReport(Report report) async =>
      await _reportRepository.addReport(report);
  Future<bool> updateReport(Report report) async =>
      await _reportRepository.updateReport(report);
  Future<bool> deleteReport(int id) async =>
      await _reportRepository.deleteReport(id);
  Future<bool> patchReport(int reportId, int newRating) async =>
      await _reportRepository.patchReport(reportId, newRating);
}
