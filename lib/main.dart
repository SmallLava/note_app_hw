import 'package:flutter/material.dart';
import 'service/note_service.dart';
import 'components/note_card.dart';
import 'constants.dart';
import 'package:gap/gap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData.dark(),
      home: HomePage(),
      routes: <String, WidgetBuilder>{'/add_note': (_) => AddNote()},
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteService _noteService = NoteService();
  String noteTitle = '';
  String noteDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddNote()));
          if (result != null && result is Map) {
            setState(() {
              noteTitle = result['title'];
              noteDescription = result['description'];
              _noteService.addNote(title: result['title'], description: result['description']);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Note app hw')),
      body: ListView.builder(
        itemCount: _noteService.notes.length,
        itemBuilder: (context, index) {
          return NoteCard(
            note: _noteService.notes[index],
            color: colorPool[index % colorPool.length],
            onPressed: () {
              setState(() {
                _noteService.deleteNote(index: index);
              });
            },
          );
        },
      ),
    );
  }
}

class AddNote extends StatelessWidget {
  AddNote({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add note')),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter note title',
              ),
            ),
            Gap(10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter note description',
              ),
            ),
            Gap(20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'title': titleController.text,
                  'description': descriptionController.text,
                });
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
