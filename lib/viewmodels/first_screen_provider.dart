import 'package:flutter/material.dart';

class FirstScreenProvider with ChangeNotifier {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController sentenceController;

  String? validateName(String? value) {
    if (value == "" || value == null) return "Name cannot be blank.";

    return null;
  }

  String? validateSentence(String? value) {
    if (value == "" || value == null) return "Sentence cannot be blank.";

    return null;
  }

  void submitPalindrome(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    bool isPalindrome = true;
    final String inputPalindromeText = sentenceController.text;
    final String checkedPalindromeText =
        inputPalindromeText.replaceAll(" ", "").toLowerCase();

    int i = 0;
    int j = checkedPalindromeText.length - 1;

    while (i <= j) {
      if (checkedPalindromeText[i] != checkedPalindromeText[j]) {
        isPalindrome = false;
        break;
      }
      i++;
      j--;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            inputPalindromeText,
            textAlign: TextAlign.center,
          ),
          content: Text(
            isPalindrome ? "Is Palindrome" : "Not Palindrome",
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void nextScreen(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    Navigator.of(context).pushNamed('/second');
  }
}
