import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/core/di/dependencies.dart';
import 'src/core/navigation/navigation_rail_cubit.dart';
import 'src/features/auth/state/auth_cubit.dart';
import 'src/features/parkings/state/parking_list_bloc.dart';
import 'src/features/parkings/state/parking_search_text_cubit.dart';
import 'src/features/parkings/state/parking_tab_cubit.dart';
import 'src/features/spaces/state/spaces_list_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        // !: Cubits
        BlocProvider(create: (_) => serviceLocator<AuthCubit>()),
        BlocProvider(create: (_) => serviceLocator<NavigationRailCubit>()),
        BlocProvider(create: (_) => serviceLocator<ParkingTabCubit>()),
        BlocProvider(create: (_) => serviceLocator<ParkingSearchTextCubit>()),
        // !: Blocs
        BlocProvider(create: (_) => serviceLocator<SpacesListBloc>()),
        BlocProvider(create: (_) => serviceLocator<ParkingListBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}
