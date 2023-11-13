import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'home_screen.dart';

class SettingsTab extends StatelessWidget {
  final Function(Color, Color) updateColors;


  const SettingsTab({Key? key, required this.updateColors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// HomeScreenState is a class that contains the state of the HomeScreen
    /// We need to access the state of the HomeScreen to update the app bar color
    /// and the floating action button color
    /// We can access the state of the HomeScreen by using the context
    /// and the findAncestorStateOfType method
    /// findAncestorStateOfType returns a HomeScreenState object
    /// We need to specify the type of state we want to find
    /// In this case, we want to find the HomeScreenState
    HomeScreenState homeScreenState = context.findAncestorStateOfType<HomeScreenState>()!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            /// SizedBox is a widget that displays a box with a specified size
            /// width: double.infinity makes the width of the SizedBox as wide as possible
            width: double.infinity,
            /// ElevatedButton is a widget that displays a button
            child: ElevatedButton(
              onPressed: () => _showColorPicker(context, homeScreenState, 'App Bar', homeScreenState.appBarColor, (color) => homeScreenState.appBarColor = color),
              /// ElevatedButton.styleFrom is a widget that displays a style for the ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: homeScreenState.appBarColor,
              ),
              child: const Text('Change App Bar Color'),
            ),
          ),
          /// SizedBox(height: 16.0) is a widget that displays a box with a height of 16.0
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              /// onPressed is a function that is called when the button is pressed
              /// In this case, we want to call the _showColorPicker function
              /// _showColorPicker displays a dialog that allows the user to pick a color
              onPressed: () => _showColorPicker(context, homeScreenState, 'Floating Button', homeScreenState.floatingButtonColor, (color) => homeScreenState.floatingButtonColor = color),
              style: ElevatedButton.styleFrom(
                backgroundColor: homeScreenState.floatingButtonColor,
              ),
              child: const Text('Change Floating Button Color'),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  /// This method displays a dialog that allows the user to pick a color
  /// The method takes in a BuildContext, a HomeScreenState, a title, a currentColor, and an updateMethod
  /// The BuildContext is used to display the dialog
   void _showColorPicker(BuildContext context, HomeScreenState homeScreenState, String title, Color currentColor, Function(Color) updateMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        /// AlertDialog is a widget that displays a dialog
        return AlertDialog(
          title: Text(title),
          /// SingleChildScrollView is a widget that displays a scrollable list of children
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                updateMethod(color);
              },
              /// The picker area is the area that displays the color picker
              pickerAreaHeightPercent: 0.8,
              /// The enableAlpha property determines whether the user can pick an alpha value
              enableAlpha: true,
              /// The displayThumbColor property determines whether the user can see the color of the thumb
              displayThumbColor: true,
              /// The showLabel property determines whether the user can see the label
              showLabel: true,
              /// The paletteType property determines the type of color picker
              paletteType: PaletteType.hsv,
              /// The pickerAreaBorderRadius property determines the border radius of the color picker
              pickerAreaBorderRadius: const BorderRadius.only(
                /// Radius.circular(2.0) is a widget that displays a circular radius of 2.0
                topLeft: Radius.circular(2.0),
                topRight: Radius.circular(2.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                /// Navigator.of(context).pop() is a method that closes the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                /// updateColors is a method that updates the colors of the app bar and the floating action button
                updateColors(homeScreenState.appBarColor, homeScreenState.floatingButtonColor);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}