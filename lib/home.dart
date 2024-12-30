import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "Mauritius Emergency Services",
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Text(
                  "Emergency call help needed??",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("Hold the emergency button to call"),
              ],
            ),
            ElevatedButton(
              onPressed: null,
              onLongPress: () {
                print("Emergency button clicked!");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
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
      ),
    );
  }
}
