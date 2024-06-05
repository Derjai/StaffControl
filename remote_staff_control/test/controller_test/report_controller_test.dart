import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/domain/model/report.dart';
import 'package:remote_staff_control/domain/use_case/report_usecase.dart';
import 'package:remote_staff_control/ui/controllers/report_controller.dart';
import '../unit_test/mocks/report_controller_test.mocks.dart';

@GenerateMocks([ReportUseCase])
void main() {
  late MockReportUseCase mockReportUseCase;
  late ReportController reportController;

  setUp(() {
    mockReportUseCase = MockReportUseCase();
    Get.put<ReportUseCase>(mockReportUseCase);
    reportController = ReportController();
  });

  tearDown(() {
    Get.reset();
  });

  test('getReports should fetch reports from use case', () async {
    when(mockReportUseCase.getReports()).thenAnswer((_) async => [
          Report(
              id: 1000,
              userId: 100,
              startDate: 12,
              duration: 120,
              problemDescription: 'Testing',
              rating: 0)
        ]);

    await reportController.getReports();

    expect(reportController.reports, isNotEmpty);
    verify(mockReportUseCase.getReports()).called(1);
  });

  test('addReport should call use case and refresh reports list', () async {
    final report = Report(
      id: 2000,
      userId: 2000,
      startDate: 16,
      duration: 90,
      problemDescription: 'Test',
      rating: 0,
    );
    when(mockReportUseCase.addReport(report)).thenAnswer((_) async => true);
    when(mockReportUseCase.getReports()).thenAnswer((_) async => [report]);

    await reportController.addReport(report);

    verify(mockReportUseCase.addReport(report)).called(1);
    verify(mockReportUseCase.getReports()).called(1);
  });

  test('updateReport should call use case and refresh reports list', () async {
    final report = Report(
      id: 1000,
      userId: 1000,
      startDate: 12,
      duration: 120,
      problemDescription: 'Testing Problem',
      rating: 0,
    );
    final updatedReport = Report(
      id: 1000,
      userId: 1000,
      startDate: 12,
      duration: 120,
      problemDescription: 'Updated Problem',
      rating: 0,
    );
    when(mockReportUseCase.addReport(report)).thenAnswer((_) async => true);
    when(mockReportUseCase.updateReport(report)).thenAnswer((_) async => true);
    when(mockReportUseCase.getReports())
        .thenAnswer((_) async => [updatedReport]);

    await reportController.addReport(report);
    await reportController.updateReport(report);

    verify(mockReportUseCase.updateReport(report)).called(1);
    verify(mockReportUseCase.getReports()).called(2);
    expect(reportController.reports, isNotEmpty);
    expect(
        reportController.reports.first.problemDescription, 'Updated Problem');
  });

  test('deleteReport should call use case and refresh reports list', () async {
    final report = Report(
      id: 1000,
      userId: 1000,
      startDate: 12,
      duration: 120,
      problemDescription: 'Testing Problem',
      rating: 0,
    );
    when(mockReportUseCase.addReport(report)).thenAnswer((_) async => true);
    when(mockReportUseCase.deleteReport(report.id!))
        .thenAnswer((_) async => true);
    when(mockReportUseCase.getReports()).thenAnswer((_) async => []);

    await reportController.addReport(report);
    await reportController.deleteReport(report.id!);

    verify(mockReportUseCase.deleteReport(report.id!)).called(1);
    verify(mockReportUseCase.getReports()).called(2);
    expect(reportController.reports, isEmpty);
  });

  test('patchReport should call use case and refresh reports list', () async {
    const newRating = 3;
    final report = Report(
      id: 1000,
      userId: 101,
      startDate: 1633024800,
      duration: 120,
      problemDescription: 'Patched Problem',
      rating: newRating,
    );

    when(mockReportUseCase.addReport(report)).thenAnswer((_) async => true);
    when(mockReportUseCase.patchReport(report.id!, newRating))
        .thenAnswer((_) async => true);
    when(mockReportUseCase.getReports()).thenAnswer((_) async => [report]);

    await reportController.addReport(report);
    await reportController.patchReport(report.id!, newRating);

    verify(mockReportUseCase.patchReport(report.id!, newRating)).called(1);
    verify(mockReportUseCase.getReports()).called(2);
    expect(reportController.reports, isNotEmpty);
    expect(reportController.reports.first.rating, newRating);
  });
}
