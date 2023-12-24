import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_mobile_intern/viewmodels/first_screen_provider.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    final FirstScreenProvider provider =
        Provider.of<FirstScreenProvider>(context, listen: false);
    provider.formKey = GlobalKey();
    provider.nameController = TextEditingController();
    provider.sentenceController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    final FirstScreenProvider provider =
        Provider.of<FirstScreenProvider>(context, listen: false);
    provider.nameController.dispose();
    provider.sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/first_screen_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child:
                  Consumer<FirstScreenProvider>(builder: (context, state, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/first_icon.png'),
                    const SizedBox(height: 58),
                    Form(
                      key: state.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: state.nameController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: "Name",
                            ),
                            validator: (value) => state.validateName(value),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: state.sentenceController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: "Palindrome",
                            ),
                            validator: (value) => state.validateSentence(value),
                          ),
                          const SizedBox(height: 45),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    state.submitPalindrome(context),
                                child: const Text("CHECK"),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () => state.nextScreen(context),
                                child: const Text("NEXT"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
