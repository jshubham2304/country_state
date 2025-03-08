import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countries_states/app/page/location/bloc/location_state.dart';
import 'package:flutter_countries_states/domain/entity/country_params.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/usecase/get_country_usecase.dart';
import 'package:flutter_countries_states/domain/usecase/get_state_usecase.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCountriesUseCase getCountriesUseCase;
  final GetStatesUseCase getStatesUseCase;

  LocationCubit({
    required this.getCountriesUseCase,
    required this.getStatesUseCase,
  }) : super(LocationState.initial());

  Future<void> loadCountries() async {
    emit(state.copyWith(
      isLoadingCountries: true,
      errorMessage: null,
      countriesSource: ApiSource.none,
    ));

    final result = await getCountriesUseCase(NoParams());

    result.fold(
        (failure) => emit(state.copyWith(
              isLoadingCountries: false,
              errorMessage: failure.when(
                server: (message) => message,
                network: (message) => message,
                unexpected: (message) => message,
              ),
            )), (countries) {
      // Update the country mapping in the states use case
      getStatesUseCase.updateCountryMap(countries);

      // Here we could check some characteristics to determine if this
      // came from the primary or backup source, but for simplicity
      // we'll assume primary API returns more countries
      final apiSource = countries.length > 100 ? ApiSource.primary : ApiSource.backup;

      emit(state.copyWith(
        isLoadingCountries: false,
        countries: countries,
        countriesSource: apiSource,
      ));
    });
  }

  Future<void> loadStates(int countryId) async {
    emit(state.copyWith(
      isLoadingStates: true,
      errorMessage: null,
      states: [],
      selectedState: null,
      statesSource: ApiSource.none,
    ));

    final result = await getStatesUseCase(CountryParams(countryId: countryId));

    result.fold(
        (failure) => emit(state.copyWith(
              isLoadingStates: false,
              errorMessage: failure.when(
                server: (message) => message,
                network: (message) => message,
                unexpected: (message) => message,
              ),
            )), (states) {
      // Determine API source by some characteristics
      // For example, backup API may return states with different ID patterns
      final apiSource =
          states.isEmpty || (states.isNotEmpty && states.first.id > 10000) ? ApiSource.backup : ApiSource.primary;

      emit(state.copyWith(
        isLoadingStates: false,
        states: states,
        statesSource: apiSource,
      ));
    });
  }

  void selectCountry(LocationEntity country) {
    emit(state.copyWith(
      selectedCountry: country,
      selectedState: null,
      states: [],
    ));
    loadStates(country.id);
  }

  void selectState(LocationEntity? value) {
    emit(state.copyWith(
      selectedState: value,
    ));
  }

  void resetError() {
    emit(state.copyWith(errorMessage: null));
  }

  // Force using backup API (for testing)
  Future<void> forceBackupApi() async {
    // First clear current selections
    emit(state.copyWith(
      countries: [],
      states: [],
      selectedCountry: null,
      selectedState: null,
      isLoadingCountries: true,
      countriesSource: ApiSource.none,
      statesSource: ApiSource.none,
    ));

    // Load countries using backup API
    await loadCountries();
  }
}
