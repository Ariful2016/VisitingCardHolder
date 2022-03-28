
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card_holder/models/contact_model.dart';
import 'package:visiting_card_holder/pages/contact_details_page.dart';
import 'package:visiting_card_holder/providers/contact_provider.dart';

class ContactRowItem extends StatefulWidget {
  final ContactModel contact;
 // final VoidCallback refreshCallback; this.refreshCallback
   ContactRowItem( this.contact);


  @override
  State<ContactRowItem> createState() => _ContactRowItemState();
}

class _ContactRowItemState extends State<ContactRowItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.black12,
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.delete, color: Colors.red,),
          ),
        ),
        confirmDismiss: _confirmDelete,
        child: Card(
          elevation: 8.0,
          child: ListTile(
            onTap: (){
              Navigator.pushNamed(context, ContactDetailsPage.routeName, arguments: widget.contact.id);
            },
            title: Text(widget.contact.name),
            tileColor: Colors.blueGrey,
            textColor: Colors.white,
            subtitle: Text(widget.contact.designation),
            trailing: Consumer<ContactProvider>(
              builder: (context, provider, _) => IconButton(
                icon: Icon(widget.contact.isFavorite? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  final value = widget.contact.isFavorite ? 0 : 1;
                  //Provider.of<ContactProvider>(context, listen: false)
                  provider
                  .updateContactFav(widget.contact.id!, value)
                  .then((_) {
                   // widget.contact.isFavorite = !widget.contact.isFavorite;
                    provider.updateList(widget.contact);
                   /* setState(() {
                      widget.contact.isFavorite = !widget.contact.isFavorite;
                     });*/
                  });

                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(DismissDirection direction){
   return showDialog(barrierDismissible: false, context: context, builder: (context) => AlertDialog(
      title: Text('Delete ${widget.contact.name}?'),
      content: const Text('Are you sure to delete this contact?'),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context, false);
            },
            child: const Text('No')),
        TextButton(
            onPressed: () async {
              await Provider.of<ContactProvider>(context, listen: false)
              .deleteContact(widget.contact);
              Navigator.pop(context, true);
            },
            child: const Text('Yes')),
      ],
    ));
     
  }
}
