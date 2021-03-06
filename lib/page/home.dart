
import 'dart:async';

import 'package:demoflutter/bridge/native_method.dart';
import 'package:demoflutter/bridge/plugin_method.dart';
import 'package:flutter/material.dart';

import 'appbar.dart';
import 'dialog_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          children: <Widget>[
            MyAppBar(title: "自定义AppBar", centerTitle: true),
            SingleChildScrollView(
                child: new Center(
                    child: new Column(
                        children: <Widget>[
                          new RaisedButton(
                              child: Text("Show Toast"),
                              onPressed: () => NativeMethod.showMyToast("使用原生toast")),
                          new RaisedButton(
                              child: Text("Use Plugin"),
                              onPressed: () => _getSysInfo(context)),
                          new RaisedButton(
                              child: Text("跳转到原生页"),
                              onPressed: () => NativeMethod.jump("simplePage")),
                          new RaisedButton(
                              child: Text("关闭"),
                              onPressed: () => NativeMethod.finishActivity()),
                        ]
                    )
                )
            )
          ],
        )
    );
  }

  _getSysInfo(BuildContext context) {
    Future<String> platformVersion = PluginMethod.getSysInfo();
    platformVersion.then(
            (onValue) => DialogUtil.showMyDialog(context, "来自plugin", '版本号 $onValue'));
  }

}