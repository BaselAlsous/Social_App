// ignore_for_file: must_be_immutable

part of 'call_cubit.dart';

@immutable
abstract class CallState {}

class CallInitial extends CallState {}



// todo : Classes Make Calling

class MakeCallSccess extends CallState {}

class MakeCallError extends CallState {
  String error;
  MakeCallError({required this.error});
}


// todo : Classes End Calling

class EndCallSccess extends CallState {}

class EndCallError extends CallState {
  String error;
  EndCallError({required this.error});
}
