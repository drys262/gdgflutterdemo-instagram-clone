import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'data/reducer/app_state_reducer.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/screens/app.dart' show App;

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial());
  runApp(App(store));
}
