import 'package:flutter_countries_states/app/page/location/bloc/location_cubit.dart';
import 'package:flutter_countries_states/data/repo/location_backupsource.dart';
import 'package:flutter_countries_states/data/repo/location_datasource.dart';
import 'package:flutter_countries_states/data/repo/locatioon_repo_impl.dart';
import 'package:flutter_countries_states/device/network_info.dart';
import 'package:flutter_countries_states/domain/repo/location_back_repo.dart';
import 'package:flutter_countries_states/domain/repo/location_repo.dart';
import 'package:flutter_countries_states/domain/usecase/get_country_usecase.dart';
import 'package:flutter_countries_states/domain/usecase/get_state_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Cubit
  sl.registerFactory(
    () => LocationCubit(
      getCountriesUseCase: sl(),
      getStatesUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCountriesUseCase(
        sl<LocationRepository>(),
        sl<BackupRepository>(),
      ));

  sl.registerLazySingleton(() => GetStatesUseCase(
        sl<LocationRepository>(),
        sl<BackupRepository>(),
      ));

  // Repositories
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<BackupRepository>(
    () => BackupRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<LocationBackupDataSource>(
    () => LocationBackupDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
