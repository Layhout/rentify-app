import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/features/joke/provider/joke_view_model.dart';

class JokeScreen extends ConsumerWidget {
  const JokeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jokeViewModelProvider);
    final vm = ref.read(jokeViewModelProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.getNewJoke();
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: state.when(
          data: (joke) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("ID:", style: context.textTheme.titleMedium),
                  context.gapXS,
                  Text(state.value?.joke.id.toString() ?? "", style: context.textTheme.bodyMedium),
                  context.gapMD,
                  Text("Type:", style: context.textTheme.titleMedium),
                  context.gapXS,
                  Text(state.value?.joke.type ?? "", style: context.textTheme.bodyMedium),
                  context.gapMD,
                  Text("setup:", style: context.textTheme.titleMedium),
                  context.gapXS,
                  Text(state.value?.joke.setup ?? "", style: context.textTheme.bodyMedium),
                  context.gapMD,
                  Text("Punchline:", style: context.textTheme.titleMedium),
                  context.gapXS,
                  Text(state.value?.joke.punchline ?? "", style: context.textTheme.bodyMedium),
                ],
              ).paddingSymmetric(horizontal: 16),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
