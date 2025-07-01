// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoiceRecordingState _$VoiceRecordingStateFromJson(Map<String, dynamic> json) {
  return _VoiceRecordingState.fromJson(json);
}

/// @nodoc
mixin _$VoiceRecordingState {
  bool get isRecording => throw _privateConstructorUsedError;
  double get amplitude => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;

  /// Serializes this VoiceRecordingState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoiceRecordingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoiceRecordingStateCopyWith<VoiceRecordingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceRecordingStateCopyWith<$Res> {
  factory $VoiceRecordingStateCopyWith(
          VoiceRecordingState value, $Res Function(VoiceRecordingState) then) =
      _$VoiceRecordingStateCopyWithImpl<$Res, VoiceRecordingState>;
  @useResult
  $Res call(
      {bool isRecording,
      double amplitude,
      DateTime? startTime,
      DateTime? endTime});
}

/// @nodoc
class _$VoiceRecordingStateCopyWithImpl<$Res, $Val extends VoiceRecordingState>
    implements $VoiceRecordingStateCopyWith<$Res> {
  _$VoiceRecordingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoiceRecordingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRecording = null,
    Object? amplitude = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_value.copyWith(
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      amplitude: null == amplitude
          ? _value.amplitude
          : amplitude // ignore: cast_nullable_to_non_nullable
              as double,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceRecordingStateImplCopyWith<$Res>
    implements $VoiceRecordingStateCopyWith<$Res> {
  factory _$$VoiceRecordingStateImplCopyWith(_$VoiceRecordingStateImpl value,
          $Res Function(_$VoiceRecordingStateImpl) then) =
      __$$VoiceRecordingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isRecording,
      double amplitude,
      DateTime? startTime,
      DateTime? endTime});
}

/// @nodoc
class __$$VoiceRecordingStateImplCopyWithImpl<$Res>
    extends _$VoiceRecordingStateCopyWithImpl<$Res, _$VoiceRecordingStateImpl>
    implements _$$VoiceRecordingStateImplCopyWith<$Res> {
  __$$VoiceRecordingStateImplCopyWithImpl(_$VoiceRecordingStateImpl _value,
      $Res Function(_$VoiceRecordingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceRecordingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRecording = null,
    Object? amplitude = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_$VoiceRecordingStateImpl(
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      amplitude: null == amplitude
          ? _value.amplitude
          : amplitude // ignore: cast_nullable_to_non_nullable
              as double,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceRecordingStateImpl
    with DiagnosticableTreeMixin
    implements _VoiceRecordingState {
  const _$VoiceRecordingStateImpl(
      {this.isRecording = false,
      this.amplitude = 0.0,
      this.startTime,
      this.endTime});

  factory _$VoiceRecordingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceRecordingStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isRecording;
  @override
  @JsonKey()
  final double amplitude;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoiceRecordingState(isRecording: $isRecording, amplitude: $amplitude, startTime: $startTime, endTime: $endTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VoiceRecordingState'))
      ..add(DiagnosticsProperty('isRecording', isRecording))
      ..add(DiagnosticsProperty('amplitude', amplitude))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('endTime', endTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceRecordingStateImpl &&
            (identical(other.isRecording, isRecording) ||
                other.isRecording == isRecording) &&
            (identical(other.amplitude, amplitude) ||
                other.amplitude == amplitude) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isRecording, amplitude, startTime, endTime);

  /// Create a copy of VoiceRecordingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceRecordingStateImplCopyWith<_$VoiceRecordingStateImpl> get copyWith =>
      __$$VoiceRecordingStateImplCopyWithImpl<_$VoiceRecordingStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceRecordingStateImplToJson(
      this,
    );
  }
}

abstract class _VoiceRecordingState implements VoiceRecordingState {
  const factory _VoiceRecordingState(
      {final bool isRecording,
      final double amplitude,
      final DateTime? startTime,
      final DateTime? endTime}) = _$VoiceRecordingStateImpl;

  factory _VoiceRecordingState.fromJson(Map<String, dynamic> json) =
      _$VoiceRecordingStateImpl.fromJson;

  @override
  bool get isRecording;
  @override
  double get amplitude;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;

  /// Create a copy of VoiceRecordingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoiceRecordingStateImplCopyWith<_$VoiceRecordingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
