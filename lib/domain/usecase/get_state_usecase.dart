import 'package:dartz/dartz.dart';
import 'package:flutter_countries_states/core/error/failure.dart';
import 'package:flutter_countries_states/domain/entity/country_params.dart';
import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:flutter_countries_states/domain/repo/location_back_repo.dart';
import 'package:flutter_countries_states/domain/repo/location_repo.dart';
import 'package:flutter_countries_states/domain/usecase/usecase.dart';

class GetStatesUseCase implements UseCase<List<LocationEntity>, CountryParams> {
  final LocationRepository primaryRepository;
  final BackupRepository backupRepository;
  final bool useBackupOnFailure;

  // This map helps translate between country IDs and names for the backup API
  final Map<int, String> _countryIdToNameMap = {};

  GetStatesUseCase(
    this.primaryRepository,
    this.backupRepository, {
    this.useBackupOnFailure = true,
  });

  void updateCountryMap(List<LocationEntity> countries) {
    _countryIdToNameMap.clear();
    for (var country in countries) {
      _countryIdToNameMap[country.id] = country.value;
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> call(CountryParams params) async {
    // Try primary repository first
    final primaryResult = await primaryRepository.getStates(params.countryId);

    return primaryResult.fold(
      (failure) async {
        // If primary fails and backup is enabled, try backup repository
        if (useBackupOnFailure) {
          // Check if we have the country name for the given ID
          final countryName = _countryIdToNameMap[params.countryId];
          if (countryName != null) {
            final backupResult = await backupRepository.getStatesByCountryName(countryName);
            return backupResult;
          } else {
            // We need the country name for the backup API
            return const Left(Failure.server(message: 'Country information not available for backup API'));
          }
        }
        // Otherwise return the original failure
        return Left(failure);
      },
      (states) => Right(states),
    );
  }
}
