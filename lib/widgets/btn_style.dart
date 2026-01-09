import 'package:flutter/material.dart';

/// Styled button
///
/// Arguments :
/// [btnType] : soit 'filled'
ButtonStyle btnStyle(
  String btnType, {
  BorderSide? side,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? disabledBackgroundColor,
}) {
  return (btnType == 'filled')
      ? FilledButton.styleFrom(
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
        )
      : OutlinedButton.styleFrom(
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
