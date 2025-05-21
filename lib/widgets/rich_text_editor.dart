import 'package:flutter/material.dart';

class RichTextMessageEditor extends StatefulWidget {
  const RichTextMessageEditor({super.key});

  @override
  _RichTextMessageEditorState createState() => _RichTextMessageEditorState();
}

class _RichTextMessageEditorState extends State<RichTextMessageEditor> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<TextSpan> _textSpans = [];
  final TextAlign _selectedTextAlignment = TextAlign.left;
  final bool _isBold = false;
  final bool _isItalic = false;

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
    icon: const Icon(Icons.format_list_bulleted),
    onPressed: () {
      // Handle adding bullet list
    },
  );
}
