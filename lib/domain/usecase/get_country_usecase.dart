import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/domain/entity/country_params.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/repo/location_back_repo.dart';
import 'package:flutter_countries_states/domain/repo/location_repo.dart';
import 'package:flutter_countries_states/domain/usecase/usecase.dart';

class GetCountriesUseCase implements UseCase<List<LocationEntity>, NoParams> {
  final LocationRepository primaryRepository;
  final BackupRepository backupRepository;
  final bool useBackupOnFailure;

  GetCountriesUseCase(
    this.primaryRepository,
    this.backupRepository, {
    this.useBackupOnFailure = true,
  });

  @override
  Future<Either<Failure, List<LocationEntity>>> call(NoParams params) async {
    // Try primary repository first
    final primaryResult = await primaryRepository.getCountries();

    return primaryResult.fold(
      (failure) async {
        // If primary fails and backup is enabled, try backup repository
        if (useBackupOnFailure) {
          final backupResult = await backupRepository.getCountries();
          return backupResult;
        }
        // Otherwise return the original failure
        return Left(failure);
      },
      (countries) => Right(countries),
    );
  }
}
