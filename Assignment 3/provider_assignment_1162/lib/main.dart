import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class StudentCard {
  final String title;

  StudentCard({
    required this.title,
  });
}

// A list of Cards
final List<StudentCard> initialData = List.generate(
    1,
    (index) => StudentCard(
          title: "$index",
        ));

// First Provider
class CardProvider with ChangeNotifier {
  // All Cards
  final List<StudentCard> _cards = initialData;
  // Retrieve all Cards
  List<StudentCard> get cards => _cards;

  final List<StudentCard> _myList = [];
  List<StudentCard> get myList => _myList;

  // Adding a Card to ListView
  void addToList(StudentCard card) {
    _myList.add(card);
    notifyListeners();
  }
}

// Second Provider
class TextProvider with ChangeNotifier {
  TextProvider();
  String displayText = "";
  void setDisplayText(String text) {
    displayText = text;
    notifyListeners();
  }

  String get getDisplayText => displayText;
}

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CardProvider>(create: (_) => CardProvider()),
      ChangeNotifierProvider<TextProvider>(create: (_) => TextProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}
