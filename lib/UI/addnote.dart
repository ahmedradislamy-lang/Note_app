import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documents/logic/createnote/bloc.dart';
import 'package:documents/logic/createnote/event.dart';
import 'package:documents/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNote extends StatefulWidget {
  const AddNote(this.existingnote, this.noteid, {super.key});
  final NoteModel ? existingnote;
  final String ? noteid;

  @override
  State<AddNote> createState() => _HomeState();
}

class _HomeState extends State<AddNote> {
  final TextEditingController titlecontroller =TextEditingController();
  final TextEditingController contentcontroller =TextEditingController();

@override
  void initState() {
    super.initState();
    if (widget.existingnote != null){
      titlecontroller.text=widget.existingnote!.title;
      contentcontroller.text=widget.existingnote!.content;
    }
  }

  void _SubmitNote(){
    if (titlecontroller.text.isEmpty || contentcontroller.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields...')));
    return;
    }
    final note =NoteModel(title:  titlecontroller.text, content: contentcontroller.text, createdAT: widget.existingnote?.createdAT ?? Timestamp.now());

    if (widget.existingnote !=null && widget.noteid!=null){
      context.read<CreateNoteBloc>().add(EditNoteEvent(noteid: widget.noteid!, updatednote: note));
    }else{
      context.read<CreateNoteBloc>().add(SubmitNoteEvent(note));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A001F),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height : 133,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            SizedBox(width: 35,),
            Text('Create New Note ', style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight(700),
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            ),
            ],
          ),
          SizedBox(height: 17,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 42,),
              Text('Head line', style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight(400),
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              ),
            ],
          ),
          SizedBox(height: 9,),
          Padding(
            padding: const EdgeInsets.only(right: 36,left: 42,),
            child: TextField(
              controller: titlecontroller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Note Address",
                hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.7),),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 17,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 42,),
              Text('Description', style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight(400),
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 36,left: 42,),
            child: TextField(
              controller: contentcontroller,
              maxLines: 8,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Note Address",
                hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.7),),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 180,),
          SizedBox(
            width: 320,
            height: 48,
            child: ElevatedButton(
              onPressed: () {_SubmitNote();},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Select Media"),
            ),
          ),
          SizedBox(height: 9,),
          SizedBox(
            width: 320,
            height: 48,
            child: ElevatedButton(
              onPressed: () {_SubmitNote();},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Create"),
            ),
          ),
        ],
      ),
    );
  }
}
