# byte_size_formatter

A TextInputFormatter that limits input based on byte-size

```dart
import 'package:byte_size_formatter/byte_size_formatter.dart';

TextField(
    decoration: InputDecoration(helperText: '4-byte max'),
    inputFormatters: [
        ByteSizeFormatter(
            sizeInBytes: 4, // Limits text input to a string of 4-bytes or less
            onTruncate: (TextEditingValue oldValue, TextEditingValue newValue, TextEditingValue finalValue) {
                /// [oldValue] is the TextEditingValue before the truncated text was entered
                /// [newValue] is the TextEditingValue after the truncated text was entered,
                /// but before truncating
                /// [finalValue] is the TextEditingValue after text is truncated
            },
      ),
    ],
);
```

## `ByteSizeFormatter`

#### __Required__
- **`int sizeInBytes`** - Text will be truncated once it reaches this byte-size

#### __Optional__
- **`void onTruncate(TextEditingValue oldValue, TextEditingValue newValue, TextEditingValue finalValue)`** - Callback that occurs when text is truncated

- **`int maxBytesPerCharacter`** - *Defaults to 4.* Controls how many characters can be safely input before checking byte-size. Useful to improve performance if your text-field only accepts characters of a certain byte-size (for example, ASCII).

## Example

A quick demonstration can be found in the `example` directory. To run the example:

`flutter run example/main.dart`
