import 'package:flutter/material.dart';

import 'database.dart';
import 'person.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search> {
  List<Person> people = [];

  @override
  Widget build(BuildContext context) {
    DatabaseImplementation database = DatabaseImplementation();
    TextEditingController searchController = TextEditingController();

    Future resolveText(String text) async {
      people = await database.queryUsingFTS(text);
      setState(() {});
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {},
            ),
            ElevatedButton(
              onPressed: () {
                resolveText(searchController.text);
              },
              child: const Text('Search'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${people[index].firstName} ${people[index].lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '${people[index].address} ${people[index].nationality}'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
