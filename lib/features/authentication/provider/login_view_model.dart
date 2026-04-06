import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentify_app/config/providers/supabase/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  late final SupabaseClient supabase;

  @override
  FutureOr<void> build() async {
    supabase = ref.watch(supabaseProvider);
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await supabase.auth.signInWithPassword(email: email, password: password);
    });
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final GoogleSignIn signIn = GoogleSignIn.instance;
      final googleAccount = await signIn.authenticate(scopeHint: ['email']);
      final googleAuthorization = await googleAccount.authorizationClient.authorizationForScopes(["email"]);
      final googleAuthentication = googleAccount.authentication;
      final idToken = googleAuthentication.idToken;
      final accessToken = googleAuthorization?.accessToken;

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await supabase.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken, accessToken: accessToken);
    });
  }

  void clearError() {
    state = AsyncValue.data(null);
  }
}
