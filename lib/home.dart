import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              const Text("Emergency call help needed?"),
              const Text("Hold the emergency button to call"),
            ],
          ),
          ElevatedButton(
            onPressed: null,
            onLongPress: () {
              print("Emergency button clicked!");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              fixedSize: Size(200, 200),
              shape: CircleBorder(),
            ),
            child: const Icon(
              Icons.sensors_outlined,
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              const Text("Need other quick emergency actions?"),
              const Text("Click one below to call"),
            ],
          )
        ],
      ),
    );
  }
}
