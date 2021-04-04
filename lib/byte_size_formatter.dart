import 'dart:convert';

import 'package:flutter/services.dart';

/// A [TextInputFormatter] that truncates text after its length reaches a
/// specified size in bytes.
class ByteSizeFormatter extends TextInputFormatter {
  /// Text will be truncated once it reaches this byte-size
  final int sizeInBytes;

  /// To save cycles, only calculate byte-size when the character length in
  /// range where it is possible to overflow in size. By default, this is 4
  /// bytes per character (the max byte-size of a unicode character).
  ///
  /// If your text input only accepts ASCII, this can be set to 1.
  final int maxBytesPerCharacter;

  /// Callback that occurs when text is truncated
  ///
  /// [oldValue] is the TextEditingValue before the truncated text was entered
  /// [newValue] is the TextEditingValue after the truncated text was entered,
  /// but before truncating
  /// [finalValue] is the TextEditingValue after text is truncated
  final void Function(
    TextEditingValue oldValue,
    TextEditingValue newValue,
    TextEditingValue finalValue,
  )? onTruncate;

  ByteSizeFormatter({
    required this.sizeInBytes,
    this.onTruncate,
    this.maxBytesPerCharacter = 4,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue == newValue ||
        newValue.text.length <= sizeInBytes / maxBytesPerCharacter) {
      return newValue;
    } else {
      final text = truncate(newValue.text, sizeInBytes);
      if (text == newValue.text) {
        return newValue;
      }
      final value = newValue.copyWith(
        text: text,
        selection: newValue.selection.extentOffset < text.length
            ? newValue.selection
            : TextSelection.collapsed(offset: text.length),
      );
      try {
        if (onTruncate != null) {
          onTruncate!(oldValue, newValue, value);
        }
      } finally {
        return value;
      }
    }
  }

  /// Truncate [value] down to [chunkSize]
  ///
  /// Optionally truncate from the [start] position
  static String truncate(String value, int chunkSize, [int start = 0]) {
    var chunk = value.substring(start); // get chunk
    var end = chunk.length;
    while (utf8.encode(chunk).length > chunkSize) {
      // adjust chunk to proper byte size if necessary
      chunk = value.substring(start, --end);
    }
    return chunk;
  }
}
