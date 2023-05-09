part of 'app_cubit.dart';

 abstract class AppState extends Equatable {
  @override
  List<Object> get props =>[];
 }
 class InitialState extends AppState{}
 class FileState extends AppState{

 }
class AddMarkerState extends AppState{}
class RemoveMarkerState extends AppState{}
class ChangeTabState extends AppState{}
class GetLocationState extends AppState{}



