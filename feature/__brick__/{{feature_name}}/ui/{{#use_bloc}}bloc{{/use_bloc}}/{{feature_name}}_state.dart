abstract class {{feature_name.pascalCase()}}State {}

class {{feature_name.pascalCase()}}Initial extends {{feature_name.pascalCase()}}State {}


class {{feature_name.pascalCase()}}Loading extends {{feature_name.pascalCase()}}State {}

class {{feature_name.pascalCase()}}Error extends {{feature_name.pascalCase()}}State {
  final String message;

  {{feature_name.pascalCase()}}Error({required this.message});
}

class {{feature_name.pascalCase()}}Loaded extends {{feature_name.pascalCase()}}State {
  final dynamic data;

  {{feature_name.pascalCase()}}Loaded({required this.data});
}