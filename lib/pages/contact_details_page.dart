import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visiting_card_holder/db/sqlite_helper.dart';
import 'package:visiting_card_holder/models/contact_model.dart';
import 'package:visiting_card_holder/utils/helper_function.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/details';

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  int? id;
  bool _isLoading = true;
  late ContactModel _contactModel;
  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)?.settings.arguments as int;
    SqliteHelper.getContactById(id!).then((contact){
      _contactModel = contact;
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: Center(
        child: _isLoading ? CircularProgressIndicator():
            Column(
              children: [
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(_contactModel.name),
                    subtitle: Text(_contactModel.designation),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(_contactModel.phone),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.sms),
                          onPressed: (){
                            _smsNumber();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.call),
                          onPressed: (){
                            _callNumber();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(_contactModel.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.email),
                      onPressed: (){
                        _sendMail();
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(_contactModel.address),
                    trailing: IconButton(
                      icon: const Icon(Icons.my_location),
                      onPressed: (){
                        _findLocation();
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(_contactModel.website),
                    trailing: IconButton(
                      icon: const Icon(Icons.web),
                      onPressed: (){
                        _visiteWeb();
                      },
                    ),
                  ),
                ),
              ],
            )

      ),
    );
  }

  void _callNumber() async {
    final uri = 'tel:${_contactModel.phone}';
    if(await canLaunch(uri)){
      await launch(uri);
    }else{
      showMessage(context, 'can not launch the desired application');
    }
  }
  void _smsNumber() async {
    final uri = 'sms:${_contactModel.phone}';
    if(await canLaunch(uri)){
      await launch(uri);
    }else{
      showMessage(context, 'can not launch the desired application');
    }
  }
  void _sendMail() async {
    final uri = 'mailto:${_contactModel.email}';
    if(await canLaunch(uri)){
      await launch(uri);
    }else{
      showMessage(context, 'can not launch the desired application');
    }
  }
  void _findLocation() async {
    final uri = 'geo:${_contactModel.address}';
    if(await canLaunch(uri)){
      await launch(uri);
    }else{
      showMessage(context, 'can not launch the desired application');
    }
  }
  void _visiteWeb() async {
    final uri = 'https:${_contactModel.website}';
    if(await canLaunch(uri)){
      await launch(uri);
    }else{
      showMessage(context, 'can not launch the desired application');
    }
  }
}
