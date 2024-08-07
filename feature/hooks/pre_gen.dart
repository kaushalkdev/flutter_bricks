import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  var logger = context.logger;

  var progress = logger.progress('Adding state management');

  try {
    var stateManagement =
        context.vars['state_management'].toString().toLowerCase();

    final userBloc = stateManagement == 'bloc';
    final useProvider = stateManagement == 'provider';
    final useCubit = stateManagement == 'cubit';

    context.vars = {
      ...context.vars,
      'use_bloc': userBloc,
      'use_provider': useProvider,
      'use_cubit': useCubit
    };

    await Process.run('dart', ['format', 'lib/{{feature_name}}/']);
  } catch (e) {
    logger.alert('Failed to set state management: $e');
  }

  progress.complete();
}
