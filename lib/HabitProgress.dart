import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/Habit.dart';

class HabitProgress extends StatefulWidget {
  final String title;
  final Habit habit;
  final bool isCompleted;
  final List<Habit> currentHabits; // List of habits from CurrentHabits screen
  final List<Habit> todaysHabits; // List of habits from Today's Habits screen
  final List<Habit> customHabits; // List of custom habits from CustomHabits.dart
  final List<dynamic> savedHabits; // List of saved habits
  Habit? selectedHabit; // Selected habit from the drop-down menu

  HabitProgress({
    required this.title,
    required this.habit,
    required this.isCompleted,
    required this.currentHabits,
    this.todaysHabits = const [],
    this.customHabits = const [],
    this.savedHabits = const [],
  });

  @override
  _HabitProgressState createState() => _HabitProgressState();
}

class _HabitProgressState extends State<HabitProgress> {
  List<Map<DateTime, bool>> completedDates = []; // List to track completed dates with their completion status

  @override
  void initState() {
    super.initState();

    if (widget.habit.isCompleted) {
      completedDates.add({DateTime.now(): true});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        iconTheme: IconThemeData(
          color: Colors.white, // Change the back arrow color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Habit Progress:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Select a Habit:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<Habit>(
              value: widget.selectedHabit,
              onChanged: (Habit? newValue) {
                setState(() {
                  widget.selectedHabit = newValue;
                });
              },
              items: widget.currentHabits.map((Habit habit) {
                return DropdownMenuItem<Habit>(
                  value: habit,
                  child: Text(habit.name),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            if (widget.selectedHabit != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Progress for ${widget.selectedHabit!.name}:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text(widget.selectedHabit!.name),
                    trailing: Icon(
                      widget.selectedHabit!.isCompleted
                          ? Icons.check_circle
                          : Icons.circle,
                      color: widget.selectedHabit!.isCompleted
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Completed Dates:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  if (completedDates.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: completedDates.map((dateMap) {
                        final date = dateMap.keys.first;
                        final isCompleted = dateMap[date]!;
                        return Row(
                          children: [
                            Icon(
                              isCompleted ? Icons.check_circle : Icons.circle,
                              color: isCompleted ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              DateFormat('MM/dd/yyyy').format(date),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

