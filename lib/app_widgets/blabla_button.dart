import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: BlaColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
            child: Text(
              text,
              style: TextStyle(color: BlaColors.white, fontSize: 16),
            ),
          )
        : TextButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: BlaColors.primary),
            label: Text(
              text,
              style: TextStyle(color: BlaColors.primary, fontSize: 16),
            ),
          );
  }
}
