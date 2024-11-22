import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) async {
  Progress progress =
      context.logger.progress('Installing state management package');

  var useBloc = context.vars['use_bloc'] || context.vars['use_cubit'];
  var useProvider = context.vars['use_provider'];

  // Adding flutter_bloc package.
  if (useBloc) {
    await Process.run('flutter', ['pub', 'add', 'flutter_bloc']);
  } else if (useProvider) {
    await Process.run('flutter', ['pub', 'add', 'provider']);
  }
  progress.complete();

  progress = context.logger.progress('Moving files');
  await Process.run("/bin/mv", ["utils", "../../core/utils"]);
  progress.complete();

  progress = context.logger.progress('Formatting files');
  await Process.run('dart', ['format', '.']);
  progress.complete();
}
