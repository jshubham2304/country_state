// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CountryParams {
  int get countryId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CountryParamsCopyWith<CountryParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryParamsCopyWith<$Res> {
  factory $CountryParamsCopyWith(
          CountryParams value, $Res Function(CountryParams) then) =
      _$CountryParamsCopyWithImpl<$Res, CountryParams>;
  @useResult
  $Res call({int countryId});
}

/// @nodoc
class _$CountryParamsCopyWithImpl<$Res, $Val extends CountryParams>
    implements $CountryParamsCopyWith<$Res> {
  _$CountryParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryId = null,
  }) {
    return _then(_value.copyWith(
      countryId: null == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CountryParamsImplCopyWith<$Res>
    implements $CountryParamsCopyWith<$Res> {
  factory _$$CountryParamsImplCopyWith(
          _$CountryParamsImpl value, $Res Function(_$CountryParamsImpl) then) =
      __$$CountryParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int countryId});
}

/// @nodoc
class __$$CountryParamsImplCopyWithImpl<$Res>
    extends _$CountryParamsCopyWithImpl<$Res, _$CountryParamsImpl>
    implements _$$CountryParamsImplCopyWith<$Res> {
  __$$CountryParamsImplCopyWithImpl(
      _$CountryParamsImpl _value, $Res Function(_$CountryParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryId = null,
  }) {
    return _then(_$CountryParamsImpl(
      countryId: null == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CountryParamsImpl implements _CountryParams {
  const _$CountryParamsImpl({required this.countryId});

  @override
  final int countryId;

  @override
  String toString() {
    return 'CountryParams(countryId: $countryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryParamsImpl &&
            (identical(other.countryId, countryId) ||
                other.countryId == countryId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, countryId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryParamsImplCopyWith<_$CountryParamsImpl> get copyWith =>
      __$$CountryParamsImplCopyWithImpl<_$CountryParamsImpl>(this, _$identity);
}

abstract class _CountryParams implements CountryParams {
  const factory _CountryParams({required final int countryId}) =
      _$CountryParamsImpl;

  @override
  int get countryId;
  @override
  @JsonKey(ignore: true)
  _$$CountryParamsImplCopyWith<_$CountryParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
