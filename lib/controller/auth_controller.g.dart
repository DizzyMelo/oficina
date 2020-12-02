// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on AuthControllerBase, Store {
  final _$loadingAtom = Atom(name: 'AuthControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$obscureAtom = Atom(name: 'AuthControllerBase.obscure');

  @override
  bool get obscure {
    _$obscureAtom.reportRead();
    return super.obscure;
  }

  @override
  set obscure(bool value) {
    _$obscureAtom.reportWrite(value, super.obscure, () {
      super.obscure = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('AuthControllerBase.login');

  @override
  Future<dynamic> login(dynamic cpfcnpj, dynamic password, dynamic context) {
    return _$loginAsyncAction
        .run(() => super.login(cpfcnpj, password, context));
  }

  final _$AuthControllerBaseActionController =
      ActionController(name: 'AuthControllerBase');

  @override
  dynamic changeObscure() {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.changeObscure');
    try {
      return super.changeObscure();
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
obscure: ${obscure}
    ''';
  }
}
