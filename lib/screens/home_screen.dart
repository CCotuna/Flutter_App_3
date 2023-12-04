import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import 'notes_screen.dart';

/// StatefulWidget is a widget that can change over time
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  /// StatefulWidgets must override createState to create a State object
  HomeScreenState createState() => HomeScreenState();
}

/// State is a generic class that specifies the type of StatefulWidget it belongs to
class HomeScreenState extends State<HomeScreen> {
  List<String> notes = [];
  String newNoteText = ''; // The text of the note the user is typing
  Color appBarColor = const Color.fromARGB(255, 78, 47, 165);
  Color floatingButtonColor = const Color.fromARGB(255, 78, 47, 165);

  @override
  Widget build(BuildContext context) {
    /// DefaultTabController is a widget that manages a TabController
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text(strings.homeScreenTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.file_copy),
              onPressed: () {
                print('Copy button pressed');
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.home), text: strings.homeTabTitle),
            Tab(icon: Icon(Icons.chat), text: strings.notesTabTitle),
          ]),
        ),
        /// TabBarView is a widget that displays the current tab's contents
        body: TabBarView(children: [
          const HomeTab(),
          NotesTab(notes: notes),
        ]),
        /// FloatingActionButton is a widget that displays a floating action button
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => createNewNote(context),
          label: const Text(strings.labelFloatingActionButton),
          icon: const Icon(Icons.add),
          backgroundColor: floatingButtonColor,
        ),
      ),
    );
  }

  /// This method is called by the SettingsTab when the user changes the colors
  void updateColors(Color appBarColor, Color floatingButtonColor) {
    setState(() {
      this.appBarColor = appBarColor;
      this.floatingButtonColor = floatingButtonColor;
    });
  }

  /// This method is called when the user presses the floating action button
  void createNewNote(BuildContext context) {
    showDialog(
        /// showDialog is a method that displays a dialog
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(strings.showDialogTitle),
            content: TextField(
              onChanged: (text) {
                // Update the note text as the user types
                setState(() {
                newNoteText = text; // Update the note text as the user types
              });
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(strings.cancelLabel)),
              /// TextButton is a widget that displays a text button
              TextButton(
                onPressed: () {
                  // Save the note to the database
                notes.add('Note: $newNoteText');
                // Reset newNoteText after saving
                setState(() {
                  newNoteText = '';
                });
                Navigator.of(context).pop();
                },
                child: const Text(strings.saveLabel),
              ),
            ],
          );
        });
  }
}

/// StatelessWidget is a widget that cannot change over time
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    /// ListView is a widget that displays a scrollable list of children
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        /// HomeCard is a custom widget that displays a card
        HomeCard(title: strings.titleFirstCard, content: strings.firstCardContent,),
        HomeCard(title: strings.titleSecondCard, content: strings.secondCardContent,),
        HomeCard(title: strings.titleThirdCard, content: strings.thirdCardContent,),
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final String content;
  /// The required keyword indicates that the parameter is mandatory
  const HomeCard({required this.title, required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Card is a widget that displays a card
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        /// Column is a widget that displays its children in a vertical array
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              /// Theme.of(context).textTheme.titleLarge is a widget that displays a text style
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              /// Theme.of(context).textTheme.bodyMedium is a widget that displays a text style
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
