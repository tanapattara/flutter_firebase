import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../components/message_dialog.dart';
import 'logger_service.dart';

class ItemService {
  Future<void> addItem(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection('item')
        .add(data)
        .then((value) {
      showMessageBox(
          context, "Success", "Added item($documentName) to Firestore",
          actions: [dismissButton(context)]);
      logger.i("setData success");
    }).catchError((error) => logger.e(error));
  }

  Future<void> saveItem(
      BuildContext context, Map<String, dynamic> data, String documentName) {
    return FirebaseFirestore.instance
        .collection('item')
        .doc(documentName)
        .update(data)
        .then((value) => showMessageBox(
            context, "Success", "Update item($documentName) to Firestore",
            actions: [dismissButton(context)]))
        .catchError((error) => logger.e(error));
  }

  Future<void> deleteItem(BuildContext context, String documentName) {
    return FirebaseFirestore.instance
        .collection('item')
        .doc(documentName)
        .delete()
        .then((value) => showMessageBox(
            context, "Success", "Update item($documentName) to Firestore",
            actions: [dismissButton(context)]))
        .catchError((error) => logger.e(error));
  }
}
