import 'package:flutter/material.dart';
import 'package:suitmedia_mobile_intern/utils/constants/colors.dart';

class SecondScreen extends StatelessWidget {
  final Map<String, String> args;

  const SecondScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Second Screen",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorPalette.blue,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: ColorPalette.gray,
        elevation: .5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              args["name"] ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "Selected User Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Choose a User",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
