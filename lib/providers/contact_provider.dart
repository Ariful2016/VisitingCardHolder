import 'package:flutter/widgets.dart';
import 'package:visiting_card_holder/db/sqlite_helper.dart';
import 'package:visiting_card_holder/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  void getAllContacts() async{
    contactList = await SqliteHelper.getAllContacts();
    notifyListeners();
  }

  Future<int> addNewContact(ContactModel contactModel) async{
    return await SqliteHelper.insertNewContact(contactModel);
  }

  void updateList (ContactModel contactModel){
    if(_updateFav(contactModel)){
      final model = contactList.firstWhere((element) => element.id == contactModel.id);
      model.isFavorite = !model.isFavorite;
    }else{
      contactList.add(contactModel);
    }
    notifyListeners();
  }

  Future<int> updateContactFav (int id, int value) async{
    return SqliteHelper.updateContactFavorite(id, value);
  }

  Future<void> deleteContact(ContactModel contactModel) async{
    await SqliteHelper.deleteContactFavorite(contactModel.id!);
    contactList.remove(contactModel);
    notifyListeners();
  }
  
  bool _updateFav (ContactModel model){
    bool tag = false;
    for (var c in contactList){
      if(c.id == model.id){
        tag = true;
        break;
      }
    }
    return tag;
  }
   
}