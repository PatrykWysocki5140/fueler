import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const LoginWidget({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            label: Text(text),
            icon: Icon(icon),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

/*
return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
          FloatingActionButton.extended(
            label: Text('Przycisk'),
            onPressed: () {},
          ),
        ],
      ),
    );


    return Card(
      child: TextButton.icon(
        style: TextButton.styleFrom(
          textStyle: TextStyle(color: Colors.blue),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () => {},
        icon: Icon(icon),
        label: Text(text),
      ),
    );
    */