import 'package:flutter/material.dart';

class MySnackBar extends SnackBar {
  MySnackBar({
    super.key,
    required BuildContext context,
    required Widget icon,
    required String message,
  }) : super(
         content: Row(
           children: [
             icon,
             const SizedBox(width: 8),
             Expanded(
               child: Text(
                 message,
                 style: TextStyle(
                   color: Theme.of(context).colorScheme.onSurface,
                 ),
               ),
             ),
           ],
         ),
         duration: const Duration(seconds: 3),
         backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
         padding: const EdgeInsets.all(12),
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
         ),
         dismissDirection: DismissDirection.horizontal,
         behavior: SnackBarBehavior.floating,
       );
}
