class Habit {
  final String name;
  final String goal;
  final String reminderFrequency;
  final DateTime startDate;
  bool isCompleted; 

  Habit({
    required this.name,
    required this.goal,
    required this.reminderFrequency,
    required this.startDate,
    this.isCompleted = false, 
  });
}
