import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/services/item_service.dart';
import 'components/message_dialog.dart';
import 'services/logger_service.dart';

class EditeItemScreen extends StatefulWidget {
  EditeItemScreen(this.documentId, this.name, this.description);
  String documentId;
  String name;
  String description;
  @override
  State<EditeItemScreen> createState() => _EditeItemScreenState();
}

class _EditeItemScreenState extends State<EditeItemScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();

  final ItemService iService = ItemService();

  @override
  Widget build(BuildContext context) {
    itemNameController.text = widget.name;
    itemDescriptionController.text = widget.description;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Item"),
          //backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(labelText: "Item Name"),
                      controller: itemNameController,
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: "Item Description"),
                      controller: itemDescriptionController,
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text("Delete items"),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            _deleteItem(context);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: const Text("Save items"),
                          onPressed: () {
                            _updateItem(context);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }

  void _updateItem(BuildContext context) {
    if (itemNameController.text == "" || itemDescriptionController.text == "") {
      showMessageBox(context, "Error",
          "Please enter name and description before adding it to firebase",
          actions: [dismissButton(context)]);
      logger.e("item name or item description can't be null");
    } else {
      iService
          .saveItem(
              context,
              {
                "name": itemNameController.text,
                "description": itemDescriptionController.text
              },
              widget.documentId)
          .then((value) => Navigator.pop(context));
      itemNameController.text = "";
      itemDescriptionController.text = "";
    }
  }

  void _deleteItem(BuildContext context) {
    if (itemNameController.text == "" || itemDescriptionController.text == "") {
      showMessageBox(context, "Error",
          "Please enter name and description before adding it to firebase",
          actions: [dismissButton(context)]);
      logger.e("item name or item description can't be null");
    } else {
      iService
          .deleteItem(context, widget.documentId)
          .then((value) => Navigator.pop(context));
      itemNameController.text = "";
      itemDescriptionController.text = "";
    }
  }
}
