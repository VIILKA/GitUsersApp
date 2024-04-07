import 'package:flutter/material.dart';

class UsersListLoadingFailureWidget extends StatelessWidget {
  const UsersListLoadingFailureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Похоже, у вас нет интернета :(',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
        ),
      ),
    );
  }
}
