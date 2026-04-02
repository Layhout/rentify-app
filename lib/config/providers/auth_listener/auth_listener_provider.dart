import 'package:rentify_app/config/providers/supabase/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rentify_app/config/providers/auth_listener/auth_state.dart';

part 'auth_listener_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthListener extends _$AuthListener {
  @override
  AuthState build() {
    final client = ref.watch(supabaseProvider);

    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(isLoading: false);
    });

    final subscription = client.auth.onAuthStateChange.listen((data) {
      state = state.copyWith(session: data.session);
    });

    ref.onDispose(subscription.cancel);

    return AuthState(isLoading: true, session: client.auth.currentSession);
  }
}
