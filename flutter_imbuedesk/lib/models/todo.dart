import 'package:cloud_firestore/cloud_firestore.dart';

//This is just TodoModel declaration, which is used to store todos
//It has 3 variables, i.e., id, content and boolean value which indicates if it is done or not.
class TodoModel {
  String todoId;
  String content;
  bool done;

  TodoModel({
    this.todoId,
    this.content,
    this.done,
  });

  TodoModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    todoId = documentSnapshot.id;
    content = documentSnapshot.data()['content'] as String;
    done = documentSnapshot.data()['done'] as bool;
  }
}
