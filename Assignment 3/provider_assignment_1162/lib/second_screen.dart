import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class TextDisplay extends StatefulWidget {
  @override
  _TextDisplayState createState() => _TextDisplayState();
}

class _TextDisplayState extends State<TextDisplay> {
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<TextProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        // Display Text through Provider
        text.getDisplayText,
        style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _myList = context.watch<CardProvider>().myList;
    final text = Provider.of<TextProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Center(
            child: Text(
              "List of Cards",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextDisplay(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _myList.length,
                    itemBuilder: (_, index) {
                      final currentCard = _myList[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.all(10)),
                            Text(
                              "Student Card ${index + 1}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                hintText: 'Enter  Username',
                              ),
                              onChanged: (changed) =>
                                  // Taking data through text TextField
                                  text.setDisplayText(changed),
                              onSubmitted: (submitted) =>
                                  text.setDisplayText(submitted),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter Password',
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
