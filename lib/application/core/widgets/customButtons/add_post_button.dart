import 'package:flutter/material.dart';

class AddPostButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDarkMode;

  const AddPostButton({
    Key? key,
    required this.onPressed,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return themeData.colorScheme.secondary
                .withOpacity(0.5); // Disabled color
          } else {
            return isDarkMode
                ? Colors.blueGrey.shade800
                : Colors.grey.shade300; // Normal color
          }
        }),
      ),
      child: Text(
        'Add Post',
        style: themeData.textTheme.button,
      ),
    );
  }
}
