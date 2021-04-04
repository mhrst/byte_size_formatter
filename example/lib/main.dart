import 'package:byte_size_formatter/byte_size_formatter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleApp());
}

class ExamplePage extends StatefulWidget {
  ExamplePage({Key? key}) : super(key: key);

  @override
  State createState() => _ExamplePageState();
}

class ExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteSizeFormatter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ExamplePage(),
    );
  }
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('ByteSizeFormatter Example'),
        ),
        body: ListView(
          children: [
            TextField(
              decoration: InputDecoration(helperText: '1-byte max'),
              inputFormatters: [
                ByteSizeFormatter(
                  sizeInBytes: 1,
                  onTruncate: _onTruncate,
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(helperText: '2-byte max'),
              inputFormatters: [
                ByteSizeFormatter(
                  sizeInBytes: 2,
                  onTruncate: _onTruncate,
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(helperText: '4-byte max'),
              inputFormatters: [
                ByteSizeFormatter(
                  sizeInBytes: 4,
                  onTruncate: _onTruncate,
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(helperText: '16-byte max'),
              inputFormatters: [
                ByteSizeFormatter(
                  sizeInBytes: 16,
                  onTruncate: _onTruncate,
                ),
              ],
            ),
          ],
        ),
      );

  void _onTruncate(TextEditingValue oldValue, TextEditingValue newValue,
          TextEditingValue finalValue) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text(
              'Truncated text: ${newValue.text.substring(finalValue.text.length)}'),
        ),
      );
}
