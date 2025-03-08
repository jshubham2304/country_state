import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_state.freezed.dart';

enum ApiSource { primary, backup, none }

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default(false) bool isLoadingCountries,
    @Default(false) bool isLoadingStates,
    @Default([]) List<LocationEntity> countries,
    @Default([]) List<LocationEntity> states,
    LocationEntity? selectedCountry,
    LocationEntity? selectedState,
    String? errorMessage,
    @Default(ApiSource.none) ApiSource countriesSource,
    @Default(ApiSource.none) ApiSource statesSource,
  }) = _LocationState;

  factory LocationState.initial() => const LocationState();
}
