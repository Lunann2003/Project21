import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'habit_provider.dart';
import 'Habit.dart';

class CustomHabits extends StatefulWidget {
  const CustomHabits({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomHabits> createState() => _CustomHabitsState();
}

class _CustomHabitsState extends State<CustomHabits> {
  String _habitName = '';
  String _habitGoal = '';
  String _reminderFrequency = '';
  DateTime _startDate = DateTime.now();

  void _addCustomHabit(HabitProvider habitProvider, BuildContext context) {
    // Create a Habit object and add it to the list
    final newHabit = Habit(
      name: _habitName,
      goal: _habitGoal,
      reminderFrequency: _reminderFrequency,
      startDate: _startDate,
      isCompleted: false,
    );

    habitProvider.addHabit(newHabit);

    setState(() {
      _habitName = '';
      _habitGoal = '';
      _reminderFrequency = '';
      _startDate = DateTime.now();
    });

    // Indicate that the habit has been saved.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Custom Habit saved!'),
        duration: Duration(seconds: 3), // Display for 3 seconds
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the app bar color to black
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Create a Custom Habit:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Text('Habit Name:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _habitName = value;
                });
              },
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),

            Text('Habit Goal:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _habitGoal = value;
                });
              },
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),

            Text('Start Date:'),
            GestureDetector(
              onTap: () {
                // Open a date picker to select the start date
                showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      _startDate = selectedDate;
                    });
                  }
                });
              },
              child: Text(
                '${_startDate.toLocal()}'.split(' ')[0], // Display selected date
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                _addCustomHabit(habitProvider, context); // Pass HabitProvider and context
              },
              child: Text('Save Custom Habit'),
            ),
          ],
        ),
      ),
    );
  }
}
