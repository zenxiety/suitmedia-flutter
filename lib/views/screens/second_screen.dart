import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_mobile_intern/utils/constants/colors.dart';
import 'package:suitmedia_mobile_intern/viewmodels/second_screen_provider.dart';

class SecondScreen extends StatefulWidget {
  final Map<String, String> args;

  const SecondScreen({super.key, required this.args});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late final SecondScreenProvider provider;

  @override
  void initState() {
    provider = Provider.of<SecondScreenProvider>(context, listen: false);
    provider.getUserName();

    super.initState();
  }

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
              widget.args["name"] ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Center(
                child: Consumer<SecondScreenProvider>(
                    builder: (context, state, _) {
                  return Text(
                    state.username == null
                        ? "Selected User Name"
                        : state.username!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/third'),
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
