import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/domain/model/report.dart';
import 'package:remote_staff_control/domain/repositories/i_report_repository.dart';
import 'package:remote_staff_control/domain/use_case/report_usecase.dart';
import '../mocks/report_usecase_test.mocks.dart';

@GenerateMocks([IReportRepository])
void main() {
  var mockReportRepository = MockIReportRepository();
  late ReportUseCase reportUseCase;
  late Report newReport;

  setUp(() {
    reportUseCase = ReportUseCase(mockReportRepository);
    newReport = Report(
      id: 1000,
      userId: 1,
      startDate: 1,
      duration: 1,
      problemDescription: 'Test Report',
      rating: 0,
    );
    when(mockReportRepository.addReport(any)).thenAnswer((_) async => true);
    when(mockReportRepository.updateReport(any)).thenAnswer((_) async => true);
    when(mockReportRepository.deleteReport(any)).thenAnswer((_) async => true);
  });

  test('addReport adds a report', () async {
    bool result = await reportUseCase.addReport(newReport);
    expect(result, true);
    verify(mockReportRepository.addReport(newReport));
  });

  test('updateReport updates a report', () async {
    bool result = await reportUseCase.updateReport(newReport);
    expect(result, true);
    verify(mockReportRepository.updateReport(newReport));
  });

  test('deleteReport deletes a report', () async {
    bool result = await reportUseCase.deleteReport(newReport.id!);
    expect(result, true);
    verify(mockReportRepository.deleteReport(newReport.id!));
  });
}
