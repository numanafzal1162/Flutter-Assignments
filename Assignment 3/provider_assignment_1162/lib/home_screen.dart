import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'main.dart';
import 'second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var cards = context.watch<CardProvider>().cards;
    var myList = context.watch<CardProvider>().myList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(90),
        child: Column(
          children: [
            Center(
              child: Text(
                "Provider Assignment",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ListScreen(),
                  ),
                );
              },
              child: Text(
                "Click here to see Card list  (${myList.length})",
                style: const TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              ),
            ),
            const SizedBox(height: 150),
            Expanded(
              child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (_, index) {
                    final currentCard = cards[index];
                    return ElevatedButton(
                      onPressed: () {
                        // Adding New Card to Access Data
                        context.read<CardProvider>().addToList(currentCard);
                        Flushbar(
                          backgroundColor: Colors.green,
                          titleText: const Text('Successful..!!'),
                          messageText: const Text('New Card is Added'),
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      },
                      child: Text(
                        "Press to Add New Card",
                        style: const TextStyle(fontSize: 24),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
