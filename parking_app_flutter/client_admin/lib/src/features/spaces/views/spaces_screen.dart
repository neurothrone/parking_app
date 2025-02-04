import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared/shared.dart';
import 'package:shared_client/shared_client.dart';
import 'package:shared_widgets/shared_widgets.dart';

import '../../../core/widgets/widgets.dart';
import '../state/spaces_list_bloc.dart';
import '../widgets/parking_space_list.dart';
import 'add_space_screen.dart';

Future<void> _generateFakeSpaces() async {
  final spaces = List.generate(
    10,
    (index) => ParkingSpace(
      id: 0,
      address: "Address $index",
      pricePerHour: index * 1.5,
    ),
  );

  for (final space in spaces) {
    await RemoteParkingSpaceRepository.instance.create(space);
  }
}

Future<void> _clearItems() async {
  final result = await RemoteParkingSpaceRepository.instance.getAll();

  result.when(
    success: (List<ParkingSpace> spaces) async {
      for (final space in spaces) {
        await RemoteParkingSpaceRepository.instance.delete(space.id);
      }
    },
    failure: (error) => debugPrint("Error: $error"),
  );
}

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Spaces",
        actions: [
          // IconButton(
          //   onPressed: () async => await _generateFakeSpaces(),
          //   tooltip: "Generate Demo Data",
          //   icon: Icon(Icons.refresh_rounded),
          // ),
          // IconButton(
          //   onPressed: () async => await _clearItems(),
          //   tooltip: "Clear Spaces",
          //   icon: Icon(
          //     Icons.delete_rounded,
          //     color: Colors.red,
          //   ),
          // ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddSpaceScreen(),
              ),
            ),
            tooltip: "Add Parking Space",
            icon: Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Row(
        children: [
          CustomNavigationRail(),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: ParkingSpaceItems(),
          ),
        ],
      ),
    );
  }
}

class ParkingSpaceItems extends StatefulWidget {
  const ParkingSpaceItems({super.key});

  @override
  State<ParkingSpaceItems> createState() => _ParkingSpaceItemsState();
}

class _ParkingSpaceItemsState extends State<ParkingSpaceItems> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<SpacesListBloc>().add(SpacesListLoad());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpacesListBloc, SpacesListState>(
      builder: (context, state) {
        if (state is SpacesListLoading) {
          return CenteredProgressIndicator();
        } else if (state is SpacesListLoaded) {
          if (state.spaces.isEmpty) {
            return const Center(
              child: Text("No parking spaces available."),
            );
          }
          return ParkingSpaceList(spaces: state.spaces);
        } else if (state is SpacesListFailure) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return CenteredProgressIndicator();
      },
    );
  }
}
