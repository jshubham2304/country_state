import 'package:flutter_countries_states/core/error/exception.dart';
import 'package:flutter_countries_states/data/model/location_model.dart';
import 'package:flutter_countries_states/data/repo/location_backupsource.dart';
import 'package:flutter_countries_states/device/network_info.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/repo/location_back_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'backup_repository_impl_test.mocks.dart';

@GenerateMocks([LocationBackupDataSource, NetworkInfo])
void main() {
  late BackupRepositoryImpl repository;
  late MockLocationBackupDataSource mockBackupDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockBackupDataSource = MockLocationBackupDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = BackupRepositoryImpl(
      remoteDataSource: mockBackupDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tCountryId = 1;
  const tCountryName = 'Country 1';
  const tLocationModel = LocationModel(id: 1, value: 'Test Location');
  const List<LocationModel> tLocationModels = [tLocationModel];
  const LocationEntity tLocationEntity = LocationEntity(id: 1, value: 'Test Location');
  const List<LocationEntity> tLocationEntities = [tLocationEntity];

  group('getCountries', () {
    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockBackupDataSource.getCountries()).thenAnswer((_) async => tLocationModels);

      // act
      await repository.getCountries();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call to backup data source is successful', () async {
        // arrange
        when(mockBackupDataSource.getCountries()).thenAnswer((_) async => tLocationModels);

        // act
        final result = await repository.getCountries();

        // assert
        verify(mockBackupDataSource.getCountries());
        expect(result.isRight(), true);
      });

      test('should return server failure when call to backup data source is unsuccessful', () async {
        // arrange
        when(mockBackupDataSource.getCountries()).thenThrow(ServerException(message: 'Server error'));

        // act
        final result = await repository.getCountries();

        // assert
        verify(mockBackupDataSource.getCountries());
        expect(result.isLeft(), true);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return network failure when device is offline', () async {
        // act
        final result = await repository.getCountries();

        // assert
        verifyZeroInteractions(mockBackupDataSource);
        expect(result.isLeft(), true);
      });
    });
  });

  group('getStatesByCountryName', () {
    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockBackupDataSource.getStates(tCountryName)).thenAnswer((_) async => tLocationModels);

      // act
      await repository.getStatesByCountryName(tCountryName);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return states when call to backup data source is successful', () async {
        // arrange
        when(mockBackupDataSource.getStates(tCountryName)).thenAnswer((_) async => tLocationModels);

        // act
        final result = await repository.getStatesByCountryName(tCountryName);

        // assert
        verify(mockBackupDataSource.getStates(tCountryName));
        expect(result.isRight(), true);
      });
    });
  });

  group('getStates', () {
    test('should attempt to load countries if mapping is not available', () async {
      // arrange - don't set up the country mapping yet
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Setup getCountries to be called when mapping is missing
      when(mockBackupDataSource.getCountries()).thenAnswer((_) async => [
            const LocationModel(id: 1, value: 'Country 1'),
            const LocationModel(id: 2, value: 'Country 2'),
          ]);

      // Setup getStates to be called after mapping is established
      when(mockBackupDataSource.getStates('Country 1')).thenAnswer((_) async => tLocationModels);

      // act
      await repository.getStates(tCountryId);

      // assert - verify both methods were called
      verify(mockBackupDataSource.getCountries());
    });
  });
}
