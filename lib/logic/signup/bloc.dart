import 'package:firebase_auth/firebase_auth.dart';
import 'package:documents/logic/signup/events.dart';
import 'package:documents/logic/signup/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState> {
final FirebaseAuth auth;

  SignUpBloc(this.auth) : super(SignUpInitialState()){
    on<SignUpButtonPressed>((event,emit)async{
      emit(SignUpLoadingState());

      try{
        await auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        emit(SignUpSuccessState());
      }
      on FirebaseAuthException catch(e){
        emit(SignUpErrorState(e.message ?? 'an error has occured'));
      }
      catch(e) {
        emit(SignUpErrorState('Something Went Wrong'));
      }

    });
  }



}