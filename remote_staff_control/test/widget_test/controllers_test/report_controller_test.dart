import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/domain/model/report.dart';
import 'package:remote_staff_control/domain/use_case/report_usecase.dart';
import 'package:remote_staff_control/ui/controllers/report_controller.dart';
import 'report_usecase_mock.dart';

void main() {
  late MockReportUseCase mockReportUseCase;
  late ReportController reportController;

  setUp(() {
    mockReportUseCase = MockReportUseCase();
    Get.put<ReportUseCase>(mockReportUseCase); // Registrar el mock en GetX
    reportController = ReportController();
  });

  test('initial reports list should be empty', () {
    expect(reportController.reports, isEmpty);
  });

  test('getReports should fetch reports from use case', () async {
    final reportsList = [
      Report(
        id: 1,
        userId: 101,
        startDate: 1633024800,
        duration: 120,
        problemDescription: 'Problem A',
        rating: 5,
      )
    ];
    when(mockReportUseCase.getReports()).thenAnswer((_) async => reportsList);

    await reportController.getReports();

    expect(reportController.reports, reportsList);
    verify(mockReportUseCase.getReports()).called(1);
  });

  test('addReport should call use case and refresh reports list', () async {
    final report = Report(
      id: 2,
      userId: 102,
      startDate: 1633028400,
      duration: 90,
      problemDescription: 'Problem B',
      rating: 4,
    );
    final reportsList = [report];
    when(mockReportUseCase.getReports()).thenAnswer((_) async => reportsList);

    await reportController.addReport(report);

    verify(mockReportUseCase.addReport(report)).called(1);
    verify(mockReportUseCase.getReports()).called(1);
    expect(reportController.reports, reportsList);
  });

  test('updateReport should call use case and refresh reports list', () async {
    final report = Report(
      id: 1,
      userId: 101,
      startDate: 1633024800,
      duration: 120,
      problemDescription: 'Updated Problem',
      rating: 5,
    );
    final reportsList = [report];
    when(mockReportUseCase.getReports()).thenAnswer((_) async => reportsList);

    await reportController.updateReport(report);

    verify(mockReportUseCase.updateReport(report)).called(1);
    verify(mockReportUseCase.getReports()).called(1);
    expect(reportController.reports, reportsList);
  });

  test('deleteReport should call use case and refresh reports list', () async {
    final reportId = 1;
    when(mockReportUseCase.getReports()).thenAnswer((_) async => []);

    await reportController.deleteReport(reportId);

    verify(mockReportUseCase.deleteReport(reportId)).called(1);
    verify(mockReportUseCase.getReports()).called(1);
    expect(reportController.reports, isEmpty);
  });

  test('patchReport should call use case and refresh reports list', () async {
    final reportId = 1;
    final newRating = 3;
    final patchedReport = Report(
      id: reportId,
      userId: 101,
      startDate: 1633024800,
      duration: 120,
      problemDescription: 'Patched Problem',
      rating: newRating,
    );
    final reportsList = [patchedReport];
    when(mockReportUseCase.getReports()).thenAnswer((_) async => reportsList);

    await reportController.patchReport(reportId, newRating);

    verify(mockReportUseCase.patchReport(reportId, newRating)).called(1);
    verify(mockReportUseCase.getReports()).called(1);
    expect(reportController.reports, reportsList);
  });
}
