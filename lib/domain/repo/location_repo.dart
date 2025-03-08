import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';

abstract class LocationRepository {
  /// Gets a list of countries from the API
  Future<Either<Failure, List<LocationEntity>>> getCountries();

  /// Gets a list of states for a specific country from the API
  Future<Either<Failure, List<LocationEntity>>> getStates(int countryId);
}
