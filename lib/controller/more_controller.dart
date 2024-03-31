import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibank/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unibank/consts/firebase_const.dart';

class MoreController extends GetxController {
  //Controllers
  var nameController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var newpasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  //Variables
  final imagePath = ''.obs;
  var imageDownloadLink = '';
  var isLoading = false.obs;

  //Func
  // pickImage(context) async {
  //   try {
  //     final img = await ImagePicker()
  //         .pickImage(source: ImageSource.gallery, imageQuality: 70);
  //     if (img == null) {
  //       return;
  //     }
  //     imagePath.value = img.path;
  //   } on PlatformException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }
  // }

  // saveImage() async {
  //   var filename = basename(imagePath.value);
  //   var dest = 'images/${currentUser!.uid}/$filename';
  //   Reference ref = FirebaseStorage.instance.ref().child(dest);
  //   await ref.putFile(File(imagePath.value));
  //   imageDownloadLink = await ref.getDownloadURL();
  // }

  saveUpdatedProfileData({name, password, phone, address}) async {
    var firestore = fireStore.collection(userCollection).doc(currentUser!.uid);
    await firestore.set(
      {'name': name, 'password': password, 'phone': phone, 'address': address},
      SetOptions(merge: true),
    );
    isLoading(false);
  }

  updateAuthPassword({email, password, newpass}) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(credential).then((value) {
      currentUser!.updatePassword(newpass);
    });
  }
}
