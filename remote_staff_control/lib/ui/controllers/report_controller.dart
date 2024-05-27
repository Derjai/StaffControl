import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/model/report.dart';
import '../../domain/use_case/report_usecase.dart';

class ReportController extends GetxController {
  final RxList<Report> _reports = <Report>[].obs;
  final ReportUseCase _reportUseCase = Get.find();

  List<Report> get reports => _reports;
  @override
  void onInit() {
    getReports();
    super.onInit();
  }

  getReports() async {
    logInfo("Getting reports");
    _reports.value = await _reportUseCase.getReports();
  }

  addReport(Report report) async {
    logInfo("Adding report");
    await _reportUseCase.addReport(report);
    logInfo("Report added successfully");
    getReports();
  }

  updateReport(Report report) async {
    logInfo("Updating report");
    await _reportUseCase.updateReport(report);
    getReports();
  }

  deleteReport(int id) async {
    logInfo("Deleting report");
    await _reportUseCase.deleteReport(id);
    getReports();
  }

  patchReport(int reportId, int newRating) async {
    logInfo("Patching report");
    await _reportUseCase.patchReport(reportId, newRating);
    getReports();
  }
}
