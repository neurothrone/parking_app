import 'package:flutter/material.dart';

import '../../core/widgets/widgets.dart';

class ParkingsScreen extends StatelessWidget {
  const ParkingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Parkings"),
      body: Row(
        children: [
          CustomNavigationRail(),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Parkings"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
