import 'package:sqflite/sqflite.dart';

import 'person.dart';

class DatabaseImplementation {
  late Database _db;
  DatabaseImplementation() {
    initialize();
  }

  Future initialize() async {
    final String directory = await getDatabasesPath();
    final String path = '$directory/people.db';
    _db = await openDatabase(path, version: 1);
    Batch batch = _db.batch();
    batch.execute('''
CREATE TABLE IF NOT EXISTS people (
	id TEXT PRIMARY KEY NOT NULL,
	firstName TEXT NOT NULL,
	lastName TEXT NOT NULL,
	age INT(3) NOT NULL,
	address TEXT NOT NULL,
	nationality TEXT NOT NULL
);''');

    batch.execute(
        'CREATE VIRTUAL TABLE IF NOT EXISTS people_fts USING fts4 (id, firstName, lastName, address, nationality);');

    batch.execute('''
CREATE TRIGGER IF NOT EXISTS insert_person_fts
	AFTER INSERT ON people
BEGIN
	INSERT INTO people_fts(id, firstName, lastName, address, nationality)
	VALUES (NEW.id, NEW.firstName, NEW.lastName, NEW.address, NEW.nationality);
END;

CREATE TRIGGER IF NOT EXISTS update_person_fts
	AFTER UPDATE ON people
BEGIN
	UPDATE people_fts SET
		firstName = NEW.firstName,
		lastName = NEW.lastName,
		address = NEW.address,
		nationality = NEW.nationality
	WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS delete_person_fts
	AFTER DELETE ON people
BEGIN
	DELETE FROM people_fts
	WHERE id = OLD.id;
END;''');

    await batch.commit();
  }

  Future insert(Person person) async {
    _db.insert('people', person.toJSON(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Person>> queryUsingFTS(String queryString) async {
    queryString = queryString.toLowerCase();
    var result = await _db.rawQuery(
        'SELECT * FROM people_fts WHERE people_fts MATCH "$queryString"');
    List<Person> people = [];
    for (var person in result) {
      people.add(Person.fromJSON(person));
    }
    return people;
  }
}
