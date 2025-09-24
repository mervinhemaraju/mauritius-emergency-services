import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/models/cyclone_report.dart';

sealed class CycloneReportState {
  const CycloneReportState();
}

class CycloneReportLoadingState extends CycloneReportState {
  const CycloneReportLoadingState();
}

class CycloneReportErrorState extends CycloneReportState {
  final String message;
  const CycloneReportErrorState(this.message);
}

class CycloneReportNoInternetState extends CycloneReportState {
  final String message;
  const CycloneReportNoInternetState(this.message);
}

class CycloneReportWarningState extends CycloneReportState {
  final CycloneReport cycloneReport;
  final CycloneGuidelines? cycloneGuidelines;
  const CycloneReportWarningState(this.cycloneReport, this.cycloneGuidelines);
}

class CycloneReportNoWarningState extends CycloneReportState {
  final CycloneReport cycloneReport;
  final CycloneGuidelines? cycloneGuidelines;
  const CycloneReportNoWarningState(this.cycloneReport, this.cycloneGuidelines);
}
