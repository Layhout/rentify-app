import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify_app/config/providers/api/api_provider.dart';
import 'package:rentify_app/config/providers/supabase/supabase_provider.dart';

class EagerInitProvider extends ConsumerWidget {
  const EagerInitProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(apiClientProvider);
    ref.watch(supabaseProvider);

    return child;
  }
}
