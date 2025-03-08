import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/domain/entity/country_params.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/repo/location_back_repo.dart';
import 'package:flutter_countries_states/domain/repo/location_repo.dart';
import 'package:flutter_countries_states/domain/usecase/get_state_usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_states_usecase_test.mocks.dart';

@GenerateMocks([LocationRepository, BackupRepository])
void main() {
  late GetStatesUseCase usecase;
  late MockLocationRepository mockPrimaryRepository;
  late MockBackupRepository mockBackupRepository;

  setUp(() {
    mockPrimaryRepository = MockLocationRepository();
    mockBackupRepository = MockBackupRepository();
    usecase = GetStatesUseCase(
      mockPrimaryRepository,
      mockBackupRepository,
    );
  });

  const tCountryId = 1;
  const tCountryName = 'Country 1';
  const tStates = [
    LocationEntity(id: 101, value: 'State 1'),
    LocationEntity(id: 102, value: 'State 2'),
  ];
  const tCountries = [
    LocationEntity(id: 1, value: 'Country 1'),
    LocationEntity(id: 2, value: 'Country 2'),
  ];

  // Set up the country mapping in the usecase
  void setUpCountryMapping() {
    usecase.updateCountryMap(tCountries);
  }

  test('should get states from primary repository when successful', () async {
    // arrange
    setUpCountryMapping();
    when(mockPrimaryRepository.getStates(tCountryId)).thenAnswer((_) async => const Right(tStates));

    // act
    final result = await usecase(const CountryParams(countryId: tCountryId));

    // assert
    expect(result, equals(const Right(tStates)));
    verify(mockPrimaryRepository.getStates(tCountryId));
    verifyZeroInteractions(mockBackupRepository);
  });

  test('should get states from backup repository when primary fails and country mapping exists', () async {
    // arrange
    setUpCountryMapping();
    const primaryFailure = Failure.server(message: 'Primary API error');
    when(mockPrimaryRepository.getStates(tCountryId)).thenAnswer((_) async => const Left(primaryFailure));

    when(mockBackupRepository.getStatesByCountryName(tCountryName)).thenAnswer((_) async => const Right(tStates));

    // act
    final result = await usecase(const CountryParams(countryId: tCountryId));

    // assert
    expect(result, equals(const Right(tStates)));
    verify(mockPrimaryRepository.getStates(tCountryId));
    verify(mockBackupRepository.getStatesByCountryName(tCountryName));
  });

  test('should return primary failure when primary fails and no country mapping exists', () async {
    // arrange - do NOT set up country mapping
    const primaryFailure = Failure.server(message: 'Primary API error');
    when(mockPrimaryRepository.getStates(tCountryId)).thenAnswer((_) async => const Left(primaryFailure));

    // act
    final result = await usecase(const CountryParams(countryId: tCountryId));

    // assert
    expect(result.isLeft(), true);
    result.fold((failure) => expect(failure, isA<Failure>()), (_) => fail('Should not succeed'));
    verify(mockPrimaryRepository.getStates(tCountryId));
    verifyZeroInteractions(mockBackupRepository);
  });

  test('should return backup failure when both repositories fail', () async {
    // arrange
    setUpCountryMapping();
    const primaryFailure = Failure.server(message: 'Primary API error');
    const backupFailure = Failure.server(message: 'Backup API error');

    when(mockPrimaryRepository.getStates(tCountryId)).thenAnswer((_) async => const Left(primaryFailure));

    when(mockBackupRepository.getStatesByCountryName(tCountryName)).thenAnswer((_) async => const Left(backupFailure));

    // act
    final result = await usecase(const CountryParams(countryId: tCountryId));

    // assert
    expect(result, equals(const Left(backupFailure)));
    verify(mockPrimaryRepository.getStates(tCountryId));
    verify(mockBackupRepository.getStatesByCountryName(tCountryName));
  });

  test('should not try backup if useBackupOnFailure is false', () async {
    // arrange
    setUpCountryMapping();
    usecase = GetStatesUseCase(
      mockPrimaryRepository,
      mockBackupRepository,
      useBackupOnFailure: false,
    );
    usecase.updateCountryMap(tCountries); // Need to update the mapping again

    const primaryFailure = Failure.server(message: 'Primary API error');
    when(mockPrimaryRepository.getStates(tCountryId)).thenAnswer((_) async => const Left(primaryFailure));

    // act
    final result = await usecase(const CountryParams(countryId: tCountryId));

    // assert
    expect(result, equals(const Left(primaryFailure)));
    verify(mockPrimaryRepository.getStates(tCountryId));
    verifyZeroInteractions(mockBackupRepository);
  });

  test('updateCountryMap should correctly store country id to name mapping', () async {
    // arrange
    usecase.updateCountryMap(tCountries);

    // Test the mapping by checking if backup repository is called with correct country name
    when(mockPrimaryRepository.getStates(tCountryId))
        .thenAnswer((_) async => const Left(Failure.server(message: 'Primary API error')));

    when(mockBackupRepository.getStatesByCountryName(tCountryName)).thenAnswer((_) async => const Right(tStates));

    // act
    await usecase(const CountryParams(countryId: tCountryId));

    // verify
    verify(mockBackupRepository.getStatesByCountryName(tCountryName));
  });
}
