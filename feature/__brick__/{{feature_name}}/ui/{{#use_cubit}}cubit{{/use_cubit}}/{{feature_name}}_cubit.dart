import 'package:flutter_bloc/flutter_bloc.dart';
import '{{feature_name}}_state.dart';
import '../../data/repo/{{feature_name}}_repo.dart';

class {{feature_name.pascalCase()}}Cubit extends Cubit<{{feature_name.pascalCase()}}State> {
  final {{feature_name.pascalCase()}}Repo _repo;

  {{feature_name.pascalCase()}}Cubit({required {{feature_name.pascalCase()}}Repo repo})
      : _repo=repo, 
        super({{feature_name.pascalCase()}}Initial());
}
