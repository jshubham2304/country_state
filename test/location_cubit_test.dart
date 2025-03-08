import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/app/page/location/bloc/location_cubit.dart';
import 'package:flutter_countries_states/app/page/location/bloc/location_state.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/domain/entity/country_params.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/usecase/get_country_usecase.dart';
import 'package:flutter_countries_states/domain/usecase/get_state_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_cubit_test.mocks.dart';

@GenerateMocks([GetCountriesUseCase, GetStatesUseCase])
void main() {
  late LocationCubit cubit;
  late MockGetCountriesUseCase mockGetCountriesUseCase;
  late MockGetStatesUseCase mockGetStatesUseCase;

  setUp(() {
    mockGetCountriesUseCase = MockGetCountriesUseCase();
    mockGetStatesUseCase = MockGetStatesUseCase();
    cubit = LocationCubit(
      getCountriesUseCase: mockGetCountriesUseCase,
      getStatesUseCase: mockGetStatesUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  const tCountries = [
    LocationEntity(id: 1, value: 'Country 1'),
    LocationEntity(id: 2, value: 'Country 2'),
  ];

  const tStates = [
    LocationEntity(id: 101, value: 'State 1'),
    LocationEntity(id: 102, value: 'State 2'),
  ];

  test('initial state should be correct', () {
    expect(cubit.state, equals(LocationState.initial()));
  });

  group('loadCountries', () {
    test('should call GetCountriesUseCase', () async {
      // arrange
      when(mockGetCountriesUseCase(any)).thenAnswer((_) async => const Right(tCountries));

      // act
      await cubit.loadCountries();

      // assert
      verify(mockGetCountriesUseCase(any));
    });

    test('should update state to loading and then success', () async {
      // arrange
      when(mockGetCountriesUseCase(any)).thenAnswer((_) async => const Right(tCountries));

      // act
      await cubit.loadCountries();

      // assert
      expect(cubit.state.countries, equals(tCountries));
      expect(cubit.state.isLoadingCountries, equals(false));
    });

    test('should update state to loading and then error', () async {
      // arrange
      final failure = Failure.server(message: 'Server error');
      when(mockGetCountriesUseCase(any)).thenAnswer((_) async => Left(failure));

      // act
      await cubit.loadCountries();

      // assert
      expect(cubit.state.errorMessage, equals('Server error'));
      expect(cubit.state.isLoadingCountries, equals(false));
    });
  });

  group('loadStates', () {
    const countryId = 1;

    test('should call GetStatesUseCase with correct params', () async {
      // arrange
      when(mockGetStatesUseCase(any)).thenAnswer((_) async => const Right(tStates));

      // act
      await cubit.loadStates(countryId);

      // assert
      verify(mockGetStatesUseCase(CountryParams(countryId: countryId)));
    });

    test('should update state to loading and then success', () async {
      // arrange
      when(mockGetStatesUseCase(any)).thenAnswer((_) async => const Right(tStates));

      // act
      await cubit.loadStates(countryId);

      // assert
      expect(cubit.state.states, equals(tStates));
      expect(cubit.state.isLoadingStates, equals(false));
    });
  });

  group('selectCountry', () {
    const tCountry = LocationEntity(id: 1, value: 'Country 1');

    test('should update selectedCountry and load states', () async {
      // arrange
      when(mockGetStatesUseCase(any)).thenAnswer((_) async => const Right(tStates));

      // act
      cubit.selectCountry(tCountry);

      // Manually advance the time to allow async operations to complete
      await Future.delayed(Duration.zero);

      // assert
      expect(cubit.state.selectedCountry, equals(tCountry));
      expect(cubit.state.states, equals(tStates));
      verify(mockGetStatesUseCase(CountryParams(countryId: tCountry.id)));
    });
  });

  group('selectState', () {
    const tState = LocationEntity(id: 101, value: 'State 1');

    test('should update selectedState', () {
      // act
      cubit.selectState(tState);

      // assert
      expect(cubit.state.selectedState, equals(tState));
    });
  });

  group('resetError', () {
    test('should clear the error message', () {
      // arrange
      cubit.emit(cubit.state.copyWith(errorMessage: 'Some error'));

      // act
      cubit.resetError();

      // assert
      expect(cubit.state.errorMessage, isNull);
    });
  });

  group('forceBackupApi', () {
    test('should reset state and load countries', () async {
      // arrange
      when(mockGetCountriesUseCase(any)).thenAnswer((_) async => const Right(tCountries));

      // act
      await cubit.forceBackupApi();

      // assert
      verify(mockGetCountriesUseCase(any));
      expect(cubit.state.countries, equals(tCountries));
    });
  });
}
