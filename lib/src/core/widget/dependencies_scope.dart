import 'package:flutter/material.dart';
import 'package:flutter_wrap_architecture/src/core/model/dependencies_storage.dart';
import 'package:flutter_wrap_architecture/src/core/widget/scope.dart';

class DependenciesScope extends Scope {
  static const DelegateAccess<_DependenciesScopeDelegate> _delegateOf =
      Scope.delegateOf<DependenciesScope, _DependenciesScopeDelegate>;

  final IDependenciesStorage Function(BuildContext context) create;

  const DependenciesScope({
    required this.create,
    required super.child,
    super.key,
  });

  static IDependenciesStorage of(
    BuildContext context,
  ) =>
      _delegateOf(context).storage;

  @override
  ScopeDelegate<DependenciesScope> createDelegate() =>
      _DependenciesScopeDelegate();
}

class _DependenciesScopeDelegate extends ScopeDelegate<DependenciesScope> {
  late final IDependenciesStorage storage = widget.create(context);

  @override
  void dispose() {
    storage.close();
    super.dispose();
  }
}
