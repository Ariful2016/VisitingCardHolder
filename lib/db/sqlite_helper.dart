import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:visiting_card_holder/models/contact_model.dart';


class SqliteHelper {

  static const String _createTableContact = '''create table ${ContactModel.tblContact}(
  ${ContactModel.tblContactColId} integer primary key autoincrement,
  ${ContactModel.tblContactColName} text not null,
  ${ContactModel.tblContactColCompany} text not null,
  ${ContactModel.tblContactColDesignation} text not null,
  ${ContactModel.tblContactColAddress} text not null,
  ${ContactModel.tblContactColEmail} text not null,
  ${ContactModel.tblContactColPhone} text not null,
  ${ContactModel.tblContactColWebsite} text not null,
  ${ContactModel.tblContactColFavorite} integer not null)''';


  static Future<Database> _open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'contact.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      db.execute(_createTableContact);
    });
  }

  static Future<int> insertNewContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(ContactModel.tblContact, contactModel.toMap());
  }

  static Future<int> updateContactFavorite(int id, int value) async {
    final db = await _open();
    return db.update(ContactModel.tblContact, {ContactModel.tblContactColFavorite: value} ,  where: '${ContactModel.tblContactColId} = ?', whereArgs: [id] );
  }
  static Future<int> deleteContactFavorite(int id) async {
    final db = await _open();
    return db.delete(ContactModel.tblContact ,  where: '${ContactModel.tblContactColId} = ?', whereArgs: [id] );
  }

  static Future<List<ContactModel>> getAllContacts() async{
    final db = await _open();
    final mapList = await db.query(ContactModel.tblContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<ContactModel> getContactById(int id) async{
    final db = await _open();
    final mapList = await db.query(ContactModel.tblContact, where: '${ContactModel.tblContactColId} = ?', whereArgs: [id] );
    return ContactModel.fromMap(mapList.first);
  }
}