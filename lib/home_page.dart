import 'package:flutter/material.dart';
import 'package:osc_flutter/constants/constants.dart';
import 'package:osc_flutter/pages/discovery_page.dart';
import 'package:osc_flutter/pages/news_list_page.dart';
import 'package:osc_flutter/pages/profile_page.dart';
import 'package:osc_flutter/pages/tweet_page.dart';
import 'package:osc_flutter/widgets/my_drawer.dart';
import 'package:osc_flutter/widgets/navigation_icon_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appBarTitle = ['资讯', '动弹', '发现', '我的'];
  List<NavigationIconView> _navigationIconViews;
  var _currentIndex = 0;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _navigationIconViews = [
      NavigationIconView(
          title: '资讯',
          iconPath: 'assets/images/ic_nav_news_normal.png',
          activeIconPath: 'assets/images/ic_nav_news_actived.png'),
      NavigationIconView(
          title: '动弹',
          iconPath: 'assets/images/ic_nav_tweet_normal.png',
          activeIconPath: 'assets/images/ic_nav_tweet_actived.png'),
      NavigationIconView(
          title: '发现',
          iconPath: 'assets/images/ic_nav_discover_normal.png',
          activeIconPath: 'assets/images/ic_nav_discover_actived.png'),
      NavigationIconView(
          title: '我的',
          iconPath: 'assets/images/ic_nav_my_normal.png',
          activeIconPath: 'assets/images/ic_nav_my_pressed.png'),
    ];
    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      ProfilePage()
    ];

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle[_currentIndex],
          style: TextStyle(color: Color(AppColors.COLOR_APPBAR)),),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(AppColors.COLOR_APPBAR)),
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[_currentIndex];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationIconViews.map((view) => view.item).toList(),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
              index, duration: Duration(milliseconds: 1), curve: Curves.ease);
        },
      ),
      drawer: MyDrawer(
        headImgPath: 'assets/images/cover_img.jpg',
        menuIcons: [Icons.send, Icons.home, Icons.error, Icons.settings],
        menuTitles: ['发布动弹', '动弹小黑屋', '关于', '设置'],
      ),
    );
  }
}
