import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/domain/entity/country_params.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/repo/location_back_repo.dart';
import 'package:flutter_countries_states/domain/repo/location_repo.dart';
import 'package:flutter_countries_states/domain/usecase/get_country_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_countries_usecase_test.mocks.dart';

@GenerateMocks([LocationRepository, BackupRepository])
void main() {
  late GetCountriesUseCase usecase;
  late MockLocationRepository mockPrimaryRepository;
  late MockBackupRepository mockBackupRepository;

  setUp(() {
    mockPrimaryRepository = MockLocationRepository();
    mockBackupRepository = MockBackupRepository();
    usecase = GetCountriesUseCase(
      mockPrimaryRepository,
      mockBackupRepository,
    );
  });

  const tCountries = [
    LocationEntity(id: 1, value: 'Country 1'),
    LocationEntity(id: 2, value: 'Country 2'),
  ];

  test('should get countries from primary repository when successful', () async {
    // arrange
    when(mockPrimaryRepository.getCountries()).thenAnswer((_) async => const Right(tCountries));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, equals(const Right(tCountries)));
    verify(mockPrimaryRepository.getCountries());
    verifyZeroInteractions(mockBackupRepository);
  });

  test('should get countries from backup repository when primary fails', () async {
    // arrange
    const primaryFailure = Failure.server(message: 'Primary API error');
    when(mockPrimaryRepository.getCountries()).thenAnswer((_) async => const Left(primaryFailure));

    when(mockBackupRepository.getCountries()).thenAnswer((_) async => const Right(tCountries));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, equals(const Right(tCountries)));
    verify(mockPrimaryRepository.getCountries());
    verify(mockBackupRepository.getCountries());
  });

  test('should return backup failure when both repositories fail', () async {
    // arrange
    const primaryFailure = Failure.server(message: 'Primary API error');
    const backupFailure = Failure.server(message: 'Backup API error');

    when(mockPrimaryRepository.getCountries()).thenAnswer((_) async => const Left(primaryFailure));

    when(mockBackupRepository.getCountries()).thenAnswer((_) async => const Left(backupFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, equals(const Left(backupFailure)));
    verify(mockPrimaryRepository.getCountries());
    verify(mockBackupRepository.getCountries());
  });

  test('should not try backup if useBackupOnFailure is false', () async {
    // arrange
    usecase = GetCountriesUseCase(
      mockPrimaryRepository,
      mockBackupRepository,
      useBackupOnFailure: false,
    );

    const primaryFailure = Failure.server(message: 'Primary API error');
    when(mockPrimaryRepository.getCountries()).thenAnswer((_) async => const Left(primaryFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, equals(const Left(primaryFailure)));
    verify(mockPrimaryRepository.getCountries());
    verifyZeroInteractions(mockBackupRepository);
  });
}
