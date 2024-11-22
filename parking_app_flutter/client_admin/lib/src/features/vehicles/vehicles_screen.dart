import 'package:flutter/material.dart';

import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_navigation_rail.dart';
import '../../core/enums/screen.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({
    super.key,
    required this.selectedScreen,
    required this.onScreenSelected,
  });

  final Screen selectedScreen;
  final Function(Screen) onScreenSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Vehicles"),
      body: Row(
        children: [
          CustomNavigationRail(
            selectedScreen: selectedScreen,
            onScreenSelected: onScreenSelected,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(selectedScreen.label),
              ],
            ),
          ),
        ],
      ),
    );
  }
}