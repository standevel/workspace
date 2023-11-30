import 'package:flutter/material.dart';

class RichTextMessageEditor extends StatefulWidget {
  @override
  _RichTextMessageEditorState createState() => _RichTextMessageEditorState();
}

class _RichTextMessageEditorState extends State<RichTextMessageEditor> {
  TextEditingController _textEditingController = TextEditingController();
  List<TextSpan> _textSpans = [];
  TextAlign _selectedTextAlignment = TextAlign.left;
  bool _isBold = false;
  bool _isItalic = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.emoji_emotions_sharp)),
            IconButton(
                onPressed: () => {}, icon: const Icon(Icons.attachment_sharp)),
            const TextField(
              decoration: InputDecoration(hintText: 'Enter message for'),
            )
          ],
        ));
  }
}

Widget _buildListButton() {
  return IconButton(
    tooltip: 'Bullet List',
    icon: Icon(Icons.format_list_bulleted),
    onPressed: () {
      // Handle adding bullet list
    },
  );
}
