import 'package:documents/UI/addnote.dart';
import 'package:documents/UI/home.dart';
import 'package:documents/logic/get_notes/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (_) => NoteBloc(), child: Home()),

      debugShowCheckedModeBanner: false,
    );
  }
}
