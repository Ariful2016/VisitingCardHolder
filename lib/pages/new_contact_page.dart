import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card_holder/models/contact_model.dart';
import 'package:visiting_card_holder/providers/contact_provider.dart';
import 'package:visiting_card_holder/utils/constans.dart';
import 'package:visiting_card_holder/utils/helper_function.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _designationController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _webController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    final contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    _setPropertiesToTextFields(contact);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _designationController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _webController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Form(
        key: _formKey ,
        child: ListView(
            padding: const EdgeInsets.all(8.0),
          children: [
            TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Contact name',
                    suffixIcon: Icon(Icons.person)

                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return inputEmptyMsg;
                  }
                  return null;
                },
              ),
            const SizedBox(height: 5.0,),
            TextFormField(
              controller: _companyController,
              decoration: const InputDecoration(
                  labelText: 'Company name',
                  suffixIcon: Icon(Icons.work)

              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return inputEmptyMsg;
                }
                return null;
              },
            ),
            const SizedBox(height: 5.0,),
            TextFormField(
              controller: _designationController,
              decoration: const InputDecoration(
                  labelText: 'Your designation',
                  suffixIcon: Icon(Icons.design_services)

              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return inputEmptyMsg;
                }
                return null;
              },
            ),
            const SizedBox(height: 5.0,),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                  labelText: 'Street address',
                  suffixIcon: Icon(Icons.streetview)

              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return inputEmptyMsg;
                }
                return null;
              },
            ),
            const SizedBox(height: 5.0,),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: const InputDecoration(
                  labelText: 'Phone number',
                  suffixIcon: Icon(Icons.phone)

              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return inputEmptyMsg;
                }
                return null;
              },
            ),
            const SizedBox(height: 5.0,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: 'Email address',
                  suffixIcon: Icon(Icons.mail)

              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return inputEmptyMsg;
                }
                return null;
              },
            ),
            const SizedBox(height: 5.0,),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: _webController,
              decoration: const InputDecoration(
                  labelText: 'Website',
                  suffixIcon: Icon(Icons.web)

              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return inputEmptyMsg;
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0,),

            ElevatedButton(
              child: const Text('Save'),
              onPressed: _saveContact,
            ),

          ]
        ),
      ),

    );
  }

  void _saveContact() async {

    if(_formKey.currentState!.validate()){
      final contact = ContactModel(
        name: _nameController.text,
        companyName: _companyController.text,
        designation: _designationController.text,
        address: _addressController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        website: _webController.text
      );

      print(contact);

      //contactList.add(contact);
     final rowId = await Provider.of<ContactProvider>(context, listen: false)
         .addNewContact(contact);
     if(rowId > 0){
       Provider.of<ContactProvider>(context, listen: false).updateList(contact);
       Navigator.pop(context, true);
     }else{
       showMessage(context, 'Failed to save');
     }

    }
  }

  _setPropertiesToTextFields(ContactModel contact) {
   setState(() {
     _nameController.text = contact.name;
     _companyController.text = contact.companyName;
     _designationController.text = contact.designation;
     _addressController.text = contact.address;
     _phoneController.text = contact.phone;
     _emailController.text = contact.email;
     _webController.text = contact.website;
   });
  }
}
