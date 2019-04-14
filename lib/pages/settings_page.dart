import 'package:flutter/material.dart';
import 'package:osc_flutter/common/event_bus.dart';
import 'package:osc_flutter/constants/constants.dart';
import 'package:osc_flutter/utils/data_utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '设置',
          style: TextStyle(color: Color(AppColors.COLOR_APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.COLOR_APPBAR)),
      ),
      body: Center(
        child: FlatButton(
            onPressed: () {
              //退出登录
              DataUtils.clearLoginInfo().then((_) {
                eventBus.fire(LogoutEvent());
                Navigator.of(context).pop();
              });
            },
            child: Text(
              '退出登录',
              style: TextStyle(fontSize: 25.0),
            )),
      ),
    );
  }
}
