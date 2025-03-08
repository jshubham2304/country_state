// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationState {
  bool get isLoadingCountries => throw _privateConstructorUsedError;
  bool get isLoadingStates => throw _privateConstructorUsedError;
  List<LocationEntity> get countries => throw _privateConstructorUsedError;
  List<LocationEntity> get states => throw _privateConstructorUsedError;
  LocationEntity? get selectedCountry => throw _privateConstructorUsedError;
  LocationEntity? get selectedState => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  ApiSource get countriesSource => throw _privateConstructorUsedError;
  ApiSource get statesSource => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocationStateCopyWith<LocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
          LocationState value, $Res Function(LocationState) then) =
      _$LocationStateCopyWithImpl<$Res, LocationState>;
  @useResult
  $Res call(
      {bool isLoadingCountries,
      bool isLoadingStates,
      List<LocationEntity> countries,
      List<LocationEntity> states,
      LocationEntity? selectedCountry,
      LocationEntity? selectedState,
      String? errorMessage,
      ApiSource countriesSource,
      ApiSource statesSource});

  $LocationEntityCopyWith<$Res>? get selectedCountry;
  $LocationEntityCopyWith<$Res>? get selectedState;
}

/// @nodoc
class _$LocationStateCopyWithImpl<$Res, $Val extends LocationState>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingCountries = null,
    Object? isLoadingStates = null,
    Object? countries = null,
    Object? states = null,
    Object? selectedCountry = freezed,
    Object? selectedState = freezed,
    Object? errorMessage = freezed,
    Object? countriesSource = null,
    Object? statesSource = null,
  }) {
    return _then(_value.copyWith(
      isLoadingCountries: null == isLoadingCountries
          ? _value.isLoadingCountries
          : isLoadingCountries // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingStates: null == isLoadingStates
          ? _value.isLoadingStates
          : isLoadingStates // ignore: cast_nullable_to_non_nullable
              as bool,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      states: null == states
          ? _value.states
          : states // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      selectedCountry: freezed == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as LocationEntity?,
      selectedState: freezed == selectedState
          ? _value.selectedState
          : selectedState // ignore: cast_nullable_to_non_nullable
              as LocationEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      countriesSource: null == countriesSource
          ? _value.countriesSource
          : countriesSource // ignore: cast_nullable_to_non_nullable
              as ApiSource,
      statesSource: null == statesSource
          ? _value.statesSource
          : statesSource // ignore: cast_nullable_to_non_nullable
              as ApiSource,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationEntityCopyWith<$Res>? get selectedCountry {
    if (_value.selectedCountry == null) {
      return null;
    }

    return $LocationEntityCopyWith<$Res>(_value.selectedCountry!, (value) {
      return _then(_value.copyWith(selectedCountry: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationEntityCopyWith<$Res>? get selectedState {
    if (_value.selectedState == null) {
      return null;
    }

    return $LocationEntityCopyWith<$Res>(_value.selectedState!, (value) {
      return _then(_value.copyWith(selectedState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationStateImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$LocationStateImplCopyWith(
          _$LocationStateImpl value, $Res Function(_$LocationStateImpl) then) =
      __$$LocationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoadingCountries,
      bool isLoadingStates,
      List<LocationEntity> countries,
      List<LocationEntity> states,
      LocationEntity? selectedCountry,
      LocationEntity? selectedState,
      String? errorMessage,
      ApiSource countriesSource,
      ApiSource statesSource});

  @override
  $LocationEntityCopyWith<$Res>? get selectedCountry;
  @override
  $LocationEntityCopyWith<$Res>? get selectedState;
}

/// @nodoc
class __$$LocationStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationStateImpl>
    implements _$$LocationStateImplCopyWith<$Res> {
  __$$LocationStateImplCopyWithImpl(
      _$LocationStateImpl _value, $Res Function(_$LocationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingCountries = null,
    Object? isLoadingStates = null,
    Object? countries = null,
    Object? states = null,
    Object? selectedCountry = freezed,
    Object? selectedState = freezed,
    Object? errorMessage = freezed,
    Object? countriesSource = null,
    Object? statesSource = null,
  }) {
    return _then(_$LocationStateImpl(
      isLoadingCountries: null == isLoadingCountries
          ? _value.isLoadingCountries
          : isLoadingCountries // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingStates: null == isLoadingStates
          ? _value.isLoadingStates
          : isLoadingStates // ignore: cast_nullable_to_non_nullable
              as bool,
      countries: null == countries
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      states: null == states
          ? _value._states
          : states // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      selectedCountry: freezed == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as LocationEntity?,
      selectedState: freezed == selectedState
          ? _value.selectedState
          : selectedState // ignore: cast_nullable_to_non_nullable
              as LocationEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      countriesSource: null == countriesSource
          ? _value.countriesSource
          : countriesSource // ignore: cast_nullable_to_non_nullable
              as ApiSource,
      statesSource: null == statesSource
          ? _value.statesSource
          : statesSource // ignore: cast_nullable_to_non_nullable
              as ApiSource,
    ));
  }
}

/// @nodoc

class _$LocationStateImpl implements _LocationState {
  const _$LocationStateImpl(
      {this.isLoadingCountries = false,
      this.isLoadingStates = false,
      final List<LocationEntity> countries = const [],
      final List<LocationEntity> states = const [],
      this.selectedCountry,
      this.selectedState,
      this.errorMessage,
      this.countriesSource = ApiSource.none,
      this.statesSource = ApiSource.none})
      : _countries = countries,
        _states = states;

  @override
  @JsonKey()
  final bool isLoadingCountries;
  @override
  @JsonKey()
  final bool isLoadingStates;
  final List<LocationEntity> _countries;
  @override
  @JsonKey()
  List<LocationEntity> get countries {
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  final List<LocationEntity> _states;
  @override
  @JsonKey()
  List<LocationEntity> get states {
    if (_states is EqualUnmodifiableListView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_states);
  }

  @override
  final LocationEntity? selectedCountry;
  @override
  final LocationEntity? selectedState;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final ApiSource countriesSource;
  @override
  @JsonKey()
  final ApiSource statesSource;

  @override
  String toString() {
    return 'LocationState(isLoadingCountries: $isLoadingCountries, isLoadingStates: $isLoadingStates, countries: $countries, states: $states, selectedCountry: $selectedCountry, selectedState: $selectedState, errorMessage: $errorMessage, countriesSource: $countriesSource, statesSource: $statesSource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationStateImpl &&
            (identical(other.isLoadingCountries, isLoadingCountries) ||
                other.isLoadingCountries == isLoadingCountries) &&
            (identical(other.isLoadingStates, isLoadingStates) ||
                other.isLoadingStates == isLoadingStates) &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries) &&
            const DeepCollectionEquality().equals(other._states, _states) &&
            (identical(other.selectedCountry, selectedCountry) ||
                other.selectedCountry == selectedCountry) &&
            (identical(other.selectedState, selectedState) ||
                other.selectedState == selectedState) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.countriesSource, countriesSource) ||
                other.countriesSource == countriesSource) &&
            (identical(other.statesSource, statesSource) ||
                other.statesSource == statesSource));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoadingCountries,
      isLoadingStates,
      const DeepCollectionEquality().hash(_countries),
      const DeepCollectionEquality().hash(_states),
      selectedCountry,
      selectedState,
      errorMessage,
      countriesSource,
      statesSource);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      __$$LocationStateImplCopyWithImpl<_$LocationStateImpl>(this, _$identity);
}

abstract class _LocationState implements LocationState {
  const factory _LocationState(
      {final bool isLoadingCountries,
      final bool isLoadingStates,
      final List<LocationEntity> countries,
      final List<LocationEntity> states,
      final LocationEntity? selectedCountry,
      final LocationEntity? selectedState,
      final String? errorMessage,
      final ApiSource countriesSource,
      final ApiSource statesSource}) = _$LocationStateImpl;

  @override
  bool get isLoadingCountries;
  @override
  bool get isLoadingStates;
  @override
  List<LocationEntity> get countries;
  @override
  List<LocationEntity> get states;
  @override
  LocationEntity? get selectedCountry;
  @override
  LocationEntity? get selectedState;
  @override
  String? get errorMessage;
  @override
  ApiSource get countriesSource;
  @override
  ApiSource get statesSource;
  @override
  @JsonKey(ignore: true)
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
