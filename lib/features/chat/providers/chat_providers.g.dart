// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoiceRecordingStateImpl _$$VoiceRecordingStateImplFromJson(
        Map<String, dynamic> json) =>
    _$VoiceRecordingStateImpl(
      isRecording: json['isRecording'] as bool? ?? false,
      amplitude: (json['amplitude'] as num?)?.toDouble() ?? 0.0,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$$VoiceRecordingStateImplToJson(
        _$VoiceRecordingStateImpl instance) =>
    <String, dynamic>{
      'isRecording': instance.isRecording,
      'amplitude': instance.amplitude,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };
