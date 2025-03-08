import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/exception.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/data/model/location_model.dart';
import 'package:flutter_countries_states/data/repo/location_datasource.dart';
import 'package:flutter_countries_states/data/repo/locatioon_repo_impl.dart';
import 'package:flutter_countries_states/device/network_info.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_repository_impl_test.mocks.dart';

@GenerateMocks([LocationRemoteDataSource, NetworkInfo])
void main() {
  late LocationRepositoryImpl repository;
  late MockLocationRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockLocationRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LocationRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tCountryId = 1;
  const tLocationModel = LocationModel(id: 1, value: 'Test Location');
  const List<LocationModel> tLocationModels = [tLocationModel];
  const LocationEntity tLocationEntity = LocationEntity(id: 1, value: 'Test Location');
  const List<LocationEntity> tLocationEntities = [tLocationEntity];

  group('getCountries', () {
    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCountries()).thenAnswer((_) async => tLocationModels);

      // act
      await repository.getCountries();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call to remote data source is successful', () async {
        // arrange
        when(mockRemoteDataSource.getCountries()).thenAnswer((_) async => tLocationModels);

        // act
        final result = await repository.getCountries();

        // assert
        verify(mockRemoteDataSource.getCountries());
        expect(result.isRight(), true);
        result.fold(
            (failure) => fail('Should return a right with data'), (data) => expect(data, equals(tLocationEntities)));
      });

      test('should return server failure when call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getCountries()).thenThrow(ServerException(message: 'Server error'));

        // act
        final result = await repository.getCountries();

        // assert
        verify(mockRemoteDataSource.getCountries());
        expect(result.isLeft(), true);
        result.fold((failure) => expect(failure, isA<Failure>()), (_) => fail('Should return a failure'));
      });

      test('should return unexpected failure when a general exception occurs', () async {
        // arrange
        when(mockRemoteDataSource.getCountries()).thenThrow(Exception('Unexpected error'));

        // act
        final result = await repository.getCountries();

        // assert
        verify(mockRemoteDataSource.getCountries());
        expect(result.isLeft(), true);
        result.fold((failure) => expect(failure, isA<Failure>()), (_) => fail('Should return a failure'));
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
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result.isLeft(), true);
        result.fold((failure) => expect(failure, isA<Failure>()), (_) => fail('Should return a network failure'));
      });
    });
  });

  group('getStates', () {
    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getStates(tCountryId)).thenAnswer((_) async => tLocationModels);

      // act
      await repository.getStates(tCountryId);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call to remote data source is successful', () async {
        // arrange
        when(mockRemoteDataSource.getStates(tCountryId)).thenAnswer((_) async => tLocationModels);

        // act
        final result = await repository.getStates(tCountryId);

        // assert
        verify(mockRemoteDataSource.getStates(tCountryId));
        expect(result.isRight(), true);
        result.fold(
            (failure) => fail('Should return a right with data'), (data) => expect(data, equals(tLocationEntities)));
      });

      test('should return server failure when call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getStates(tCountryId)).thenThrow(ServerException(message: 'Server error'));

        // act
        final result = await repository.getStates(tCountryId);

        // assert
        verify(mockRemoteDataSource.getStates(tCountryId));
        expect(result.isLeft(), true);
        result.fold((failure) => expect(failure, isA<Failure>()), (_) => fail('Should return a failure'));
      });

      test('should return unexpected failure when a general exception occurs', () async {
        // arrange
        when(mockRemoteDataSource.getStates(tCountryId)).thenThrow(Exception('Unexpected error'));

        // act
        final result = await repository.getStates(tCountryId);

        // assert
        verify(mockRemoteDataSource.getStates(tCountryId));
        expect(result.isLeft(), true);
        result.fold((failure) => expect(failure, isA<Failure>()), (_) => fail('Should return a failure'));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return network failure when device is offline', () async {
        // act
        final result = await repository.getStates(tCountryId);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result.isLeft(), true);
        result.fold((failure) => expect(failure, isA<Failure>()), (_) => fail('Should return a network failure'));
      });
    });
  });
}
