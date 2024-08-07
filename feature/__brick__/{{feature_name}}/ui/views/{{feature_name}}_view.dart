
import 'package:flutter/material.dart';
{{#use_bloc}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/{{feature_name}}_bloc.dart';
{{/use_bloc}}
{{#use_cubit}}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/{{feature_name}}_cubit.dart';
{{/use_cubit}}
{{#use_provider}}
import 'package:provider/provider.dart';
import '../provider/{{feature_name}}_provider.dart';
{{/use_provider}}
import '../../data/repo/{{feature_name}}_repo.dart';


class {{feature_name.pascalCase()}}Builder extends StatelessWidget{
  const {{feature_name.pascalCase()}}Builder({super.key});

  @override
  Widget build(BuildContext context) {
    {{#use_bloc}}
      return BlocProvider(
      create: (_) => {{feature_name.pascalCase()}}Bloc(repo : {{feature_name.pascalCase()}}Repo()),
      child: const {{feature_name.pascalCase()}}View(),
      );
    {{/use_bloc}}
    {{#use_cubit}}
      return BlocProvider(
      create: (_) => {{feature_name.pascalCase()}}Cubit(repo : {{feature_name.pascalCase()}}Repo()),
      child: const {{feature_name.pascalCase()}}View(),
      );
    {{/use_cubit}}
    {{#use_provider}}
      return ChangeNotifierProvider(
      create: (_) => {{feature_name.pascalCase()}}Provider(repo : {{feature_name.pascalCase()}}Repo()),
      child: const {{feature_name.pascalCase()}}View(),
      );
    {{/use_provider}}
  }
}


class {{feature_name.pascalCase()}}View extends StatefulWidget {
  const {{feature_name.pascalCase()}}View({super.key});

  @override
  State<{{feature_name.pascalCase()}}View> createState() => _{{feature_name.pascalCase()}}ViewState();
}

class _{{feature_name.pascalCase()}}ViewState extends State<{{feature_name.pascalCase()}}View> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}