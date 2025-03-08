import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/exception.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/data/model/location_model.dart';
import 'package:flutter_countries_states/data/repo/location_datasource.dart';
import 'package:flutter_countries_states/device/network_info.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/repo/location_repo.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LocationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<LocationEntity>>> getCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final countries = await remoteDataSource.getCountries();
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
  Future<Either<Failure, List<LocationEntity>>> getStates(int countryId) async {
    if (await networkInfo.isConnected) {
      try {
        final states = await remoteDataSource.getStates(countryId);
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
}
