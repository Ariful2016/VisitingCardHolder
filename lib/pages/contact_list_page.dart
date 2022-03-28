import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card_holder/custom_widgets/contact_row_item.dart';
import 'package:visiting_card_holder/pages/scan_page.dart';
import 'package:visiting_card_holder/providers/contact_provider.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late ContactProvider _provider;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if(isInit){
      _provider = Provider.of<ContactProvider>(context);
      _getUpdateData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _getUpdateData(){
    _provider.getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: Center(
        child: _provider.contactList.isEmpty? const CircularProgressIndicator() :
        ListView.builder(
          itemCount: _provider.contactList.length,
          itemBuilder: (context, index){
            final contact = _provider.contactList[index];
            return ContactRowItem(contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, ScanPage.routeName);
         //_getUpdateData();
        /* if(status!= null){
           if(status as bool){
             setState(() {

             });
           }
         }*/

        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
