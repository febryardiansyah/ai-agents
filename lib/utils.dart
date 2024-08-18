import 'package:flutter/material.dart';

const APIKEY = String.fromEnvironment('GEMINI_API_KEY');
const GEMINI_ICON = 'assets/gemini-icon.png';

enum BlocStatus { initial, loading, loaded, error }

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text('Loading...'),
            ],
          ),
        ),
      );
    },
  );
}
