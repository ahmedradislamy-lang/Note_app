import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String? userId;
  final String title;
  final String content;
  final Timestamp createdAT;

  NoteModel({this.id, required this.title, required this.content,this.userId, required this.createdAT});

factory NoteModel.fromJson(Map<String,dynamic> json,String id){
  return NoteModel(
    userId: json['userId'],
    id: id,
    title :json['title'] ?? '',
    content :json['content'] ?? '',
    createdAT :json['createdAT'] ?? Timestamp.now(),
  );
}

Map <String,dynamic> toJson(){
  return{
    'userId' :userId,
    'title':title,
    'content':content,
    'createdAT':createdAT,
  };
}
}