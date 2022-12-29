import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Employee');

class FirebaseCrud {

  static Future<Response> addEmployee({
    required String name,
    required String mail_id,
    required String contactno,
    required String dob,
    required String gender,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "email_id": mail_id,
      "contact_no": contactno,
      "dob": dob,
      "gender": gender
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updateEmployee({
    required String name,
    required String mail_id,
    required String contactno,
    required String dob,
    required String gender,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "contact_no": contactno,
      "dob": dob,
      "mail_id": mail_id,
      "gender": gender
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Successfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
