import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visiting_card_holder/models/contact_model.dart';
import 'package:visiting_card_holder/pages/new_contact_page.dart';
import 'package:visiting_card_holder/utils/constans.dart';


List<String> _mergeLineList = [];

class ScanPage extends StatefulWidget {
  static const String routeName = '/scan_page';

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  List<String> _lines = [];
  final _contactModel = ContactModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Visiting Card'),
        actions: [
          TextButton(
              child: const Text('Next', style: TextStyle(color: Colors.white),),
            onPressed: (){
                print(_contactModel);
                Navigator.pushReplacementNamed(context, NewContactPage.routeName, arguments: _contactModel);
            },
          )

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 200.0,
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color : Colors.grey, width: 2.0)
              ),
              child: _imagePath == null? null : Image.file(File(_imagePath!), width: double.maxFinite, height: 200.0, fit: BoxFit.cover,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed:(){
                      _imageSource = ImageSource.camera;
                      _pickImage();
                    },
                    child: const Text('Camera')),
                const SizedBox(width: 20.0,),
                ElevatedButton(
                    onPressed:(){
                      _imageSource = ImageSource.gallery;
                      _pickImage();
                    },
                    child: const Text('Gallery')),
                const SizedBox(width: 20.0,),
                ElevatedButton(
                    onPressed:(){
                      Navigator.pushReplacementNamed(context, NewContactPage.routeName, arguments: _contactModel);
                    },
                    child: const Text('Type')),
              ],
            ),
            SizedBox(height: 20.0,),
          Expanded(
            child: ListView.builder(
              itemCount: _lines.length,
              itemBuilder: (context, index) => lineItem(_lines[index]),
            ),
          ),
            SizedBox(
              width: double.maxFinite,
              height: 40.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _propertyButton(ContactProperties.name),
                  _propertyButton(ContactProperties.company),
                  _propertyButton(ContactProperties.designation),
                  _propertyButton(ContactProperties.address),
                  _propertyButton(ContactProperties.phone),
                  _propertyButton(ContactProperties.email),
                  _propertyButton(ContactProperties.web),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _propertyButton(String property){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        child : Text(property),
        onPressed: (){
          _assignPropertiedToContactModel(property);
        },
      ),
    );
  }

  void _pickImage() async{
    final pickedFile = await ImagePicker().pickImage(source: _imageSource);
    if(pickedFile != null){
     setState(() {
       _imagePath = pickedFile.path ;
     });
    // print(pickedFile.path);

      final textDetector = GoogleMlKit.vision.textDetector();
      final inputImage = InputImage.fromFilePath(_imagePath!);
      final recognizedText  = await textDetector.processImage(inputImage);
      // print(recognizedText.text);
      var lines = <String>[];
      for(var block in recognizedText.blocks){
        for(var line in block.lines){
          lines.add(line.text);
        }
      }

      setState(() {
        _lines = lines;
      });

    }
  }

  void _assignPropertiedToContactModel(String property) {
    final item = _mergeLineList.join(' ');
    switch(property){
      case ContactProperties.name:
        _contactModel.name = item;
        break;
      case ContactProperties.company:
        _contactModel.companyName = item;
        break;
      case ContactProperties.designation:
        _contactModel.designation = item;
        break;
      case ContactProperties.address:
        _contactModel.address = item;
        break;
      case ContactProperties.phone:
        _contactModel.phone = item;
        break;
      case ContactProperties.email:
        _contactModel.email = item;
        break;
      case ContactProperties.web:
        _contactModel.website = item;
        break;
    }
    _mergeLineList.clear();
  }
}

class lineItem extends StatefulWidget {
  final String line;

  lineItem(this.line);

  @override
  State<lineItem> createState() => _lineItemState();
}

class _lineItemState extends State<lineItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.line),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (value){
          setState(() {
            isChecked = value!;
          });
          value! ? _mergeLineList.add(widget.line) : _mergeLineList.remove(widget.line);
        },
      ),
    );
  }
}
