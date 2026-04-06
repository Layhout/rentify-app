import 'package:rentify_app/config/providers/supabase/supabase_provider.dart';
import 'package:rentify_app/features/home/provider/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final SupabaseClient supabase;

  @override
  FutureOr<HomeState> build() async {
    supabase = ref.watch(supabaseProvider);

    return HomeState(currentUser: supabase.auth.currentUser);
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
