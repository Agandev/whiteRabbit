import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingError extends StatelessWidget {
  final Function(BuildContext) onPressed;
  final String? message;

  LoadingError({required this.onPressed, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message!),
          TextButton(
              onPressed: () {
                onPressed(context);
              },
              child: Text("TRY AGAIN"))
        ],
      ),
    );
  }
}
