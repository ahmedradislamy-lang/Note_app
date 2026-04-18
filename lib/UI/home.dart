import 'package:documents/logic/get_notes/bloc.dart';
import 'package:documents/logic/get_notes/event.dart';
import 'package:documents/logic/get_notes/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState(){
    super.initState();
    context.read<NoteBloc>().add(LoadNotesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A001F),
      body: Column(
        children: [
          SizedBox(height: 137.21),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 35),
              Container(
                width: 164,
                height: 48,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Add Note',
                    style: TextStyle(fontWeight: FontWeight(600), fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 17.75),
              Container(
                width: 164,
                height: 48,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Log out',
                    style: TextStyle(fontWeight: FontWeight(600), fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 34.03),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<NoteBloc,NoteState>(builder:(context,state){
                if(state is NoteLoadingState){
              return Center(child: CircularProgressIndicator(),);
                }
                else if(state is NoteLoadedState) {
                  final notes = state.notes;
                  if (notes.isEmpty){
                   return Center(child: Text('No Notes Yet...',style: TextStyle(color: Colors.white),),);
                  }
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context,index){
                      final note=notes[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10,),
                        height: 80,
                        width: 390,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(242, 214, 241, 0.14),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.11),
                            Row(
                              children: [
                                SizedBox(width: 20.23),
                                Text(
                                  note.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight(500),
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.71),
                            Row(
                              children: [
                                SizedBox(width: 20.11),
                                Text(
                                  note.content,
                                  style: TextStyle(
                                    fontWeight: FontWeight(400),
                                    fontSize: 12,
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 11.24),
                                  child: Text(
                                    '${note.createdAT.toDate().hour.toString().padLeft(2,'0')}:${note.createdAT.toDate().minute.toString().padLeft(2,'0')}',
                                    style: TextStyle(
                                      fontWeight: FontWeight(400),
                                      fontSize: 10,
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },

                  );

                }
                else if(state is NoteErrorState){
                  return Center(
                    child: Text('Error ${state.error}',style: TextStyle(color: Colors.red),),
                  );
                }
                return SizedBox();
              }),
            ),
          ),




        ],
      ),
    );
  }
}
