import 'package:rentify_app/config/providers/supabase/supabase_provider.dart';
import 'package:rentify_app/features/authentication/provider/login_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'signup_view_model.g.dart';

@riverpod
class SignupViewModel extends _$SignupViewModel {
  late final SupabaseClient supabase;

  @override
  Future<void> build() async {
    supabase = ref.watch(supabaseProvider);
  }

  Future<bool> signupWithEmailAndPassword(String email, String password) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      return await supabase.auth.signUp(email: email, password: password);
    });

    state = result;
    return !result.hasError;
  }

  Future<void> signupWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(loginViewModelProvider.notifier).loginWithGoogle();
    });
  }

  void clearError() {
    state = const AsyncData(null);
  }
}
