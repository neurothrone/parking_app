import 'package:flutter/foundation.dart';

import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_client/shared_client.dart';

import '../../features/auth/state/auth_cubit.dart';
import '../../features/parkings/state/parking_list_bloc.dart';
import '../../features/parkings/state/parking_search_text_cubit.dart';
import '../../features/parkings/state/parking_tab_cubit.dart';
import '../../features/spaces/state/spaces_list_bloc.dart';
import '../navigation/navigation_rail_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // !: Auth Cubit
  serviceLocator.registerLazySingleton(() => AuthCubit());

  // !: Navigation Rail Cubit
  serviceLocator.registerLazySingleton(() => NavigationRailCubit());

  // !: Parking Tab Cubit
  serviceLocator.registerLazySingleton(() => ParkingTabCubit());

  // !: Parking Search Text Cubit
  serviceLocator.registerLazySingleton(() => ParkingSearchTextCubit());

  // !: Remote Repositories
  serviceLocator
    ..registerLazySingleton(() => RemotePersonRepository.instance)
    ..registerLazySingleton(() => RemoteVehicleRepository.instance)
    ..registerLazySingleton(() => RemoteParkingSpaceRepository.instance)
    ..registerLazySingleton(() => RemoteParkingRepository.instance);

  // !: Spaces & Parking
  serviceLocator
    ..registerLazySingleton(
      () => SpacesListBloc(
        remoteParkingSpaceRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ParkingListBloc(
        remoteParkingRepository: serviceLocator(),
      ),
    );
}
