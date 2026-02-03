import 'package:flutter/material.dart';
import 'package:notes_lite/main.dart';
import 'package:notes_lite/screens/add_note.dart';
import 'package:notes_lite/screens/edit_note.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _notes = [];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: Icon(
              themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(25),
        itemCount: _notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            title: Text(
              _notes[index],
              style: TextStyle(fontSize: 13),
              maxLines: 8,
            ),
            titleAlignment: ListTileTitleAlignment.top,
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _notes.removeAt(index);
                });
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () async {
              final updatedNote = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditNote(editedNote: _notes[index]),
                ),
              );
              if (updatedNote != null && updatedNote is String) {
                setState(() {
                  _notes[index] = updatedNote;
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNote()),
          );
          if (newNote != null && newNote is String) {
            setState(() {
              _notes.add(newNote);
            });
          }
        },
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
