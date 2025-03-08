import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/exception.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/data/model/location_model.dart';
import 'package:flutter_countries_states/data/repo/location_backupsource.dart';
import 'package:flutter_countries_states/device/network_info.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';

abstract class BackupRepository {
  /// Gets a list of countries from the backup API
  Future<Either<Failure, List<LocationEntity>>> getCountries();

  /// Gets a list of states for a specific country from the backup API
  /// using the country name instead of id
  Future<Either<Failure, List<LocationEntity>>> getStatesByCountryName(String countryName);
}

class BackupRepositoryImpl implements BackupRepository {
  final LocationBackupDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  // Cache for storing country name to ID mapping
  final Map<String, int> _countryNameToIdMap = {};

  BackupRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<LocationEntity>>> getCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final countries = await remoteDataSource.getCountries();

        // Update the country name to ID mapping
        _countryNameToIdMap.clear();
        for (var country in countries) {
          _countryNameToIdMap[country.value.toLowerCase()] = country.id;
        }

        return Right(countries.toEntityList());
      } on ServerException catch (e) {
        return Left(Failure.server(message: e.message));
      } catch (e) {
        return Left(Failure.unexpected(message: e.toString()));
      }
    } else {
      return const Left(Failure.network());
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getStatesByCountryName(String countryName) async {
    if (await networkInfo.isConnected) {
      try {
        // Get states by country name
        final states = await remoteDataSource.getStates(countryName);
        return Right(states.toEntityList());
      } on ServerException catch (e) {
        return Left(Failure.server(message: e.message));
      } catch (e) {
        return Left(Failure.unexpected(message: e.toString()));
      }
    } else {
      return const Left(Failure.network());
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getStates(int countryId) async {
    // This is a fallback implementation since our API uses country name, not ID
    if (await networkInfo.isConnected) {
      try {
        // Find the country name that corresponds to this ID
        String? countryName;
        for (var entry in _countryNameToIdMap.entries) {
          if (entry.value == countryId) {
            countryName = entry.key;
            break;
          }
        }

        if (countryName == null) {
          // If we don't have the mapping yet, try loading countries first
          if (_countryNameToIdMap.isEmpty) {
            final countriesResult = await getCountries();

            // If loading countries failed, return the failure
            if (countriesResult.isLeft()) {
              return countriesResult.fold(
                (failure) => Left(failure),
                (_) => Left(Failure.server(message: 'Could not find country name for ID $countryId')),
              );
            }

            // Try finding the country name again
            for (var entry in _countryNameToIdMap.entries) {
              if (entry.value == countryId) {
                countryName = entry.key;
                break;
              }
            }

            if (countryName == null) {
              return Left(Failure.server(message: 'Could not find country name for ID $countryId'));
            }
          } else {
            return Left(Failure.server(message: 'Could not find country name for ID $countryId'));
          }
        }

        // Use the country name to get states
        return getStatesByCountryName(countryName);
      } catch (e) {
        return Left(Failure.unexpected(message: e.toString()));
      }
    } else {
      return const Left(Failure.network());
    }
  }
}
