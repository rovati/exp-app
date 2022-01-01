import 'package:flutter/material.dart';

/// Simple widget used as a placeholder while loading data to be shown on screen.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                // REVIEW use constants
                "LOADING...",
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
          ],
        ),
      );
}
