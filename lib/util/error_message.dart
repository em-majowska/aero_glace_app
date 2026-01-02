import 'package:aero_glace_app/model/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void errorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    MySnackBar(
      context: context,
      icon: const Icon(LucideIcons.triangleAlert),
      message: message,
    ),
  );
}
