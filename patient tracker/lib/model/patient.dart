import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient.freezed.dart';
part 'patient.g.dart';

@freezed
class Patient with _$Patient {
  factory Patient({
    String? firstName,
    String? lastName,
    String? gender,
    String? bloodtype,
    String? doctorName,
    String? roomNum,
    String? condition,
    String? medications,
    int? patientID,
    DateTime? admissionDate,
    DateTime? dischargeDate,
  }) = _Patient;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

    Patient._();
}
