import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c17_fri/models/task_model.dart';
import 'package:evently_c17_fri/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunctions {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<UserModel> _getUsersCollection() {
    return _firestore.collection("Users").withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> _createUserDB(UserModel user) {
    var collection = _getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static CollectionReference<TaskModel> getTasksCollection() {
    return _firestore.collection("Tasks").withConverter<TaskModel>(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> createTask(TaskModel task) {
    var collection = getTasksCollection();
    var doc = collection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<void> deleteTask(TaskModel task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTask(TaskModel task) {
    return getTasksCollection().doc(task.id).update(task.toJson());
  }

  static Stream<QuerySnapshot<TaskModel>> getFavoriteTasks() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }
    return getTasksCollection()
        .where("userId", isEqualTo: currentUser.uid)
        .where("isFavorite", isEqualTo: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<TaskModel>> getStreamTasks({String? category}) {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }
    var query = getTasksCollection().where("userId", isEqualTo: currentUser.uid);

    if (category != null) {
      query = query.where("category", isEqualTo: category);
    }

    return query.snapshots();
  }

  static Future<void> signOut() {
    return _auth.signOut();
  }

  static Future<UserModel?> readUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return null;
    var userDoc = await _getUsersCollection().doc(currentUser.uid).get();
    return userDoc.data();
  }

  static Future<void> signInWithGoogle(
      {required Function onSuccess, required Function(String) onError}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      var userExist = await _getUsersCollection().doc(userCredential.user!.uid).get();

      if (!userExist.exists) {
        await _createUserDB(
          UserModel(
            email: userCredential.user!.email!,
            name: userCredential.user!.displayName!,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: userCredential.user!.uid,
          ),
        );
      }
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "An unknown error occurred.");
    } catch (e) {
      onError("Something went wrong. Please try again.");
    }
  }

  static Future<void> createUser(
    String email,
    String password,
    String name,
    Function onSuccess,
    Function(String) onError,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _createUserDB(
        UserModel(
          email: email,
          name: name,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: credential.user!.uid,
        ),
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "An unknown error occurred.");
    } catch (e) {
      onError("Something went wrong. Please try again.");
    }
  }

  static Future<void> login(
    String emailAddress,
    String password,
    Function onSuccess,
    Function(String) onError,
    Function onLoading,
  ) async {
    try {
      onLoading();
      await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "An unknown error occurred.");
    } catch (e) {
      onError("Something went wrong. Please try again.");
    }
  }
}
