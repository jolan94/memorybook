import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxBool isLoading = false.obs; // Add isLoading variable

  Future<UserCredential?> signInAnonymously() async {
    try {
      isLoading.value = true; // Set isLoading to true
      final userCredential = await _auth.signInAnonymously();
      return userCredential;
    } catch (e) {
      print(e);
      return null;
    } finally {
      isLoading.value = false; // Set isLoading to false
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      isLoading.value = true; // Set isLoading to true
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuthentication = await googleSignInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print(e);
      return null;
    } finally {
      isLoading.value = false; // Set isLoading to false
    }
  }
}
