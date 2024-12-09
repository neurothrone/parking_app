import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_widgets/shared_widgets.dart';

import '../state/available_spaces/available_spaces_bloc.dart';
import 'available_space_list_tile.dart';

class AvailableSpaceItems extends StatefulWidget {
  const AvailableSpaceItems({super.key});

  @override
  State<AvailableSpaceItems> createState() => _AvailableSpaceItemsState();
}

class _AvailableSpaceItemsState extends State<AvailableSpaceItems> {
  @override
  void initState() {
    super.initState();
    context.read<AvailableSpacesBloc>().add(AllParkingLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableSpacesBloc, AvailableSpacesState>(
      builder: (context, state) {
        if (state is AllParkingLoading) {
          return CenteredProgressIndicator();
        } else if (state is AllParkingLoaded) {
          final spaces = state.spaces;
          if (spaces.isEmpty) {
            return Center(
              child: Text("No parking spaces available."),
            );
          }

          return ListView.separated(
            itemCount: spaces.length,
            itemBuilder: (context, index) {
              final space = spaces[index];
              return AvailableSpaceListTile(space: space);
            },
            separatorBuilder: (context, index) => const Divider(height: 0),
          );
        } else if (state is AllParkingFailure) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return CenteredProgressIndicator();
      },
    );
  }
}