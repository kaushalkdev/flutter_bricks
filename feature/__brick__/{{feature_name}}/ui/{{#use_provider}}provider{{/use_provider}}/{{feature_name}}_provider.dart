import 'package:flutter/material.dart';
import '../../data/repo/{{feature_name}}_repo.dart';

class {{feature_name.pascalCase()}}Provider extends ChangeNotifier {
  final {{feature_name.pascalCase()}}Repo _repo;

  {{feature_name.pascalCase()}}Provider({required {{feature_name.pascalCase()}}Repo repo})
      : _repo=repo;
}
