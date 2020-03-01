import 'package:flutter/material.dart';
import 'package:quran_app/baselib/base_state_mixin.dart';
import 'package:quran_app/baselib/base_widgetparameter_mixin.dart';
import 'package:quran_app/pages/splash/splash_widget.dart';
import 'package:quran_app/routes/routes.dart';

import 'main_store.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key}) : super(key: key);

  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget>
    with BaseStateMixin<MainStore, MainWidget> {
  final _store = MainStore();
  @override
  MainStore get store => _store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: Routes.routes,
      onGenerateRoute: (s) {
        var widgetBuilder = Routes.routes[s.name];
        return MaterialPageRoute(
          builder: (BuildContext context) {
            var widget = widgetBuilder(context);
            if (widget is BaseWidgetParameterMixin) {
              var baseWidgetParameterMixin = widget;
              if (s.arguments != null) {
                baseWidgetParameterMixin.parameter.addAll(
                  Map.from(
                    s.arguments,
                  ),
                );
              }
            }
            return widget;
          },
        );
      },
      navigatorKey: store.appServices.navigatorStateKey,
    );
  }
}