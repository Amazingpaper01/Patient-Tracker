// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientImpl _$$PatientImplFromJson(Map<String, dynamic> json) =>
    _$PatientImpl(
      firtName: json['firtName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      bloodtype: json['bloodtype'] as String?,
      doctorName: json['doctorName'] as String?,
      roomNum: json['roomNum'] as String?,
      condition: json['condition'] as String?,
      medications: json['medications'] as String?,
      patientID: json['patientID'] as int?,
      admissionDate: json['admissionDate'] == null
          ? null
          : DateTime.parse(json['admissionDate'] as String),
      dischargeDate: json['dischargeDate'] == null
          ? null
          : DateTime.parse(json['dischargeDate'] as String),
    );

Map<String, dynamic> _$$PatientImplToJson(_$PatientImpl instance) =>
    <String, dynamic>{
      'firtName': instance.firtName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'bloodtype': instance.bloodtype,
      'doctorName': instance.doctorName,
      'roomNum': instance.roomNum,
      'condition': instance.condition,
      'medications': instance.medications,
      'patientID': instance.patientID,
      'admissionDate': instance.admissionDate?.toIso8601String(),
      'dischargeDate': instance.dischargeDate?.toIso8601String(),
    };
