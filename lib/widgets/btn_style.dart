import 'package:flutter/material.dart';

/// Types de boutons disponibles pour [btnStyle].
enum ButtonType {
  filled,
  outlined,
}

/// Bouton stylisé selon le [ButtonType].
///
/// Arguments :
/// - [type] : type du bouton ([ButtonType.filled] ou [ButtonType.outlined]).
/// - [side] : bordure du bouton.
/// - [backgroundColor] : couleur de fond.
/// - [foregroundColor] : couleur du texte et des icônes.
/// - [disabledBackgroundColor] : couleur de fond lorsque le bouton est désactivé.
ButtonStyle btnStyle(
  ButtonType type, {
  BorderSide? side,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? disabledBackgroundColor,
}) {
  switch (type) {
    case ButtonType.filled:
      return FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: backgroundColor,
        side: side,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
      );

    case ButtonType.outlined:
      return OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: side,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
      );
  }
}
