import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'habit_provider.dart';
import 'Habit.dart';
import 'HabitProgress.dart';

class CurrentHabits extends StatelessWidget {
  final String title;

  CurrentHabits({required this.title});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the app bar color to black
        title: Text(
          title,
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
              'Your Current Habits:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: habitProvider.habits.length,
              itemBuilder: (context, index) {
                final habit = habitProvider.habits[index];
                return ListTile(
                  title: Text(habit.name),
                  subtitle: Text('Goal: ${habit.goal}'),
                  trailing: Checkbox(
                    value: habit.isCompleted,
                    onChanged: (bool? newValue) {
                      if (newValue != null) {
                        
                        habitProvider.updateHabitCompletion(habit, newValue);

                      }
                    },
                  ),
                  onTap: () {
                    // HabitProgress screen 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HabitProgress(
                          title: "Habit Progress",
                          habit: habit,
                          isCompleted: habit.isCompleted,
                          currentHabits: habitProvider.habits, // Pass the list of habits 
                        ),
                      ),
                    );

                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
