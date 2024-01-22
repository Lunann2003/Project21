import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'habit_provider.dart';
import 'CustomHabit.dart';
import 'CurrentHabits.dart';

void main() {
  final habitProvider = HabitProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => habitProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          secondary: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // Black button background color
            onPrimary: Colors.white, // White text color
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/custom_habits': (context) => CustomHabits(title: 'Customize Habits'),
        '/current_habits': (context) => CurrentHabits(title: "Today's Habits"),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(
            'PROJECT21',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Today's Habits screen
                    Navigator.pushNamed(context, '/current_habits');
                  },
                  child: Text(
                    "Today's Habits",
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Custom Habits screen
                    Navigator.pushNamed(context, '/custom_habits');
                  },
                  child: Text(
                    'Customize Habits',
                  ),
                ),
              ],
            ),
          ),
        ),
        AppBar(
          title: const Text(''),
        ),
      ],
    );
  }
}
