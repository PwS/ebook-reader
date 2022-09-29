import 'package:flutter/material.dart';

class CustomEmptyPage extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? message1;

  const CustomEmptyPage(
      {Key? key, required this.icon, required this.message, this.message1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700]),
          ),
          const SizedBox(
            height: 5,
          ),
          message1 == null
              ? const SizedBox()
              : Text(
                  message1!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700]),
                )
        ],
      ),
    );
  }
}
