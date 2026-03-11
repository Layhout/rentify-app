import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AppObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    debugPrint('✨ Provider ${context.provider.name} was initialized with $value');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    debugPrint('🗑️ Provider ${context.provider.name} was disposed');
  }

  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    debugPrint('⚡ Provider ${context.provider.name} updated from $previousValue to $newValue');
  }

  @override
  void providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace) {
    debugPrint('💀 Provider ${context.provider.name} threw $error at $stackTrace');
  }
}
