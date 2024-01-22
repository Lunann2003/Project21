import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/Habit.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = []; 

  List<Habit> get habits => _habits;

  void updateHabitCompletion(Habit habit, bool isCompleted) {
    final habitIndex = _habits.indexOf(habit);
    if (habitIndex != -1) {
      _habits[habitIndex].isCompleted = isCompleted;
      notifyListeners();
    }
  }

  // Method to add a habit to the list
  void addHabit(Habit habit) {
    _habits.add(habit);
    notifyListeners();
  }

  // Method to remove a habit from the list
  void removeHabit(Habit habit) {
    _habits.remove(habit);
    notifyListeners();
  }
}
