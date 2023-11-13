

import 'package:flutter/material.dart';

/// StatefulWidget is a widget that can change over time
class NotesTab extends StatelessWidget {
  final List<String> notes;

  const NotesTab({super.key, required this.notes});
  

  @override
Widget build(BuildContext context) {
  /// ListView.builder is a widget that displays a scrollable list of children
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
      Color notesContainerColor = const Color.fromARGB(255, 10, 27, 154);
        return Padding(
          /// EdgeInsets.symmetric(vertical: 8.0) is a widget that displays a padding
          /// on the top and bottom of 8.0
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: notesContainerColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            /// EdgeInsets.all(16.0) is a widget that displays a padding
            /// on all sides of 16.0
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: ${DateTime.now()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  notes[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}