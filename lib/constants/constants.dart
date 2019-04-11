abstract class AppColors {
  //主题色
  static const COLOR_PRIMARY = 0xff63ca6c;
  static const COLOR_APPBAR = 0xffffffff;
}

abstract class AppInfos {
  static const String CLIENT_ID = 'lTNVxfgUbVQ3x3tfVlEf'; //应用id
  static const String CLIENT_SECRET = 'VPRsboeeJgXoC6zJP4xxBK0ounhceVwV'; //应用密钥
  static const String REDIRECT_URI = 'https://www.baidu.com'; //回调地址
}

abstract class AppUrls {
  static const String HOST = 'https://www.oschina.net';

  //授权登录
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';

  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';
}
