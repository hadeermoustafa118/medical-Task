
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home_screen.dart';
part 'app_state.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super( InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  GoogleMapController? controller;
  var markers = HashSet<Marker>();
  late BitmapDescriptor customMarker;
  static LatLng currentLatLng = LatLng(30.033333, 31.233334);

  Position? currentPosition;
  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;

  // pick file function
  // void pickFile() async{
  //   try {
  //     isLoading = true;
  //     result= await FilePicker.platform.pickFiles(
  //       type: FileType.any,
  //       allowMultiple: false,
  //     );
  //     if (result !=null){
  //       fileName = result!.files.first.name;
  //       pickedFile = result!.files.first;
  //       fileToDisplay = File(pickedFile!.path.toString());
  //     }
  //     isLoading = false;
  //     emit(FileState());
  //
  //   } catch (e) {debugPrint(e.toString());}
  // }

// show dialog function for date
  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select your birthdate '),
          content: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(1990, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                // Do something
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //alert for date and time

  Future<void> showMyDialogDateAndTime(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select your birthdate '),
          content: SizedBox(
              height: 200,
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }

                  return true;
                },
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              )),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles();
//   }
//
//   Future uploadFile() async {}


  Future<File> pickFile(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file selected'),
      ));

    }

    return File(pickedFile!.path);
  }


  //map


Future getPer(BuildContext context) async {
  bool services;
  LocationPermission per;

  services = await Geolocator.isLocationServiceEnabled();
  if (services == false) {
    AwesomeDialog(
        context: context,
        title: 'services',
        body: const SizedBox(
          height: 100,
          child:  Center(
              child: Text('Location Service is not enabled.',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center)),
        )).show();
  }
  per = await Geolocator.checkPermission();
  if (per == LocationPermission.denied) {
    per = await Geolocator.requestPermission();
    if (per == LocationPermission.always) {
      getLoc();
    }
  }
}


void addMarker() {
    markers.add(Marker(
      markerId: const MarkerId('1'),
      position: currentLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    ));
    emit(AddMarkerState());
  }

  void removeMarker() {
    markers.remove(const Marker(markerId: MarkerId('1')));
    emit(RemoveMarkerState());
  }



  void tab(value) async {
    currentLatLng = value;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    CameraPosition cameraPosition =
        CameraPosition(target: currentLatLng, zoom: 12);
    controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        currentLatLng.latitude, currentLatLng.longitude);
    debugPrint(placeMarks[0].administrativeArea);
    removeMarker();
    addMarker();
    debugPrint(
        'hello from ${currentLatLng.latitude}${currentLatLng.longitude}');
    emit(ChangeTabState());
  }

  void getLoc() {
    Geolocator.getCurrentPosition().then((currLocation) async {
      currentLatLng = LatLng(currLocation.latitude, currLocation.longitude);
      debugPrint('this is ${currentLatLng.latitude}${currentLatLng.longitude}');
      currentPosition = currLocation;
      CameraPosition cameraPosition =
          CameraPosition(target: currentLatLng, zoom: 12);
      controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      emit(GetLocationState());
    });
  }



  //auth

  //for sign up
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var formKeySign = GlobalKey<FormState>();

//for login
  var emailForLoginController = TextEditingController();
  var passForLoginController = TextEditingController();
  var formKeyLogin = GlobalKey<FormState>();

  // add user
  addUserData({required String username, required String mail, }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'email': mail, 'username': username});
    debugPrint('user added');
  }

  // registeration

  // Future<void> register()async {
  //   try {
  //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.toString(),
  //       password: passController.toString(),
  //     );
  //     debugPrint(credential.toString());
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }


//   //register
  UserCredential? userCredential;

Future<void> registers (BuildContext context)async {
  try {
    if (formKeySign.currentState!
        .validate()) {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text);
      debugPrint('$userCredential');
      addUserData(
          username: usernameController.text,
          mail: emailController.text);

    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
     const AwesomeDialog(
          body: SizedBox(
            height: 100,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                'weak pass',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
          context: context,
          dialogType: DialogType.warning)
          .show();
      } else if (e.code == 'email-already-in-use') {
     const AwesomeDialog(
          body: SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'mail in use',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
          context: context,
          dialogType: DialogType.warning)
          .show();

      }
  } catch (e) {
    debugPrint('$e');
  }
}

//login
Future<void> login(BuildContext context)async {
  try {
    if (formKeyLogin.currentState!.validate()) {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email:
          emailForLoginController.text,
          password:
          passForLoginController.text);

    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    const  AwesomeDialog(
          body: SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'no user',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
          context: context,
          dialogType: DialogType.warning)
          .show();

    } else if (e.code == 'wrong-password') {
      const AwesomeDialog(
          body: SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'wrong pass',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
          context: context,
          dialogType: DialogType.WARNING)
          .show();
    }
  }
}
}
