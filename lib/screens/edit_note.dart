import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final String editedNote;
  const EditNote({super.key, required this.editedNote});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController _content = TextEditingController();

  @override
  void initState() {
    _content.text = widget.editedNote;
    super.initState();
  }

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _content,
                decoration: InputDecoration(
                  labelText: 'Update your note..',
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_content.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Updated note cannot be empty!')),
            );
            return;
          }
          Navigator.pop(context, _content.text);
        },
        shape: CircleBorder(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
