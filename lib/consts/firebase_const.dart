import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;

User? currentUser = auth.currentUser;
const userCollection = "user";
const manageTransaction = "manageTransactions";

// const productCollection = "products";
// const cartCollection = "cart";
