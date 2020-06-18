// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceController on ServiceControllerBase, Store {
  final _$numeroDeClicksAtom =
      Atom(name: 'ServiceControllerBase.numeroDeClicks');

  @override
  int get numeroDeClicks {
    _$numeroDeClicksAtom.reportRead();
    return super.numeroDeClicks;
  }

  @override
  set numeroDeClicks(int value) {
    _$numeroDeClicksAtom.reportWrite(value, super.numeroDeClicks, () {
      super.numeroDeClicks = value;
    });
  }

  final _$ServiceControllerBaseActionController =
      ActionController(name: 'ServiceControllerBase');

  @override
  dynamic addClick() {
    final _$actionInfo = _$ServiceControllerBaseActionController.startAction(
        name: 'ServiceControllerBase.addClick');
    try {
      return super.addClick();
    } finally {
      _$ServiceControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
numeroDeClicks: ${numeroDeClicks}
    ''';
  }
}
