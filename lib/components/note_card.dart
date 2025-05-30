import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import '../model/note.dart';

class NoteCard extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final Note note;

  const NoteCard({
    super.key,
    required this.color,
    required this.onPressed,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: color,
          child: ListTile(
            //
            title: Text(note.title, style: kTitleTextStyle),
            subtitle: Text(
              '${note.description}\n${DateFormat('yyyy-MM-dd').format(note.dateTime)}',

              style: kSubTitleTextStyle,
            ),
            isThreeLine: true,
            trailing: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.remove_circle_outline_outlined,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}