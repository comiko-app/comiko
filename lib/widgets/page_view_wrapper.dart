import 'package:comiko/app_state.dart';
import 'package:comiko/pages/about_us_page.dart';
import 'package:comiko/pages/artists_page.dart';
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/pages/liked_events_page.dart';
import 'package:comiko/pages/upcoming_events_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class PageViewWrapper extends StatefulWidget {
  final List<IsPage> _pages;
  final PageController _pageController = new PageController();

  PageViewWrapper()
      : _pages = [
          const UpcomingEventsPage(),
          const LikedEventsPage(),
          const ArtistsPage(),
          const AboutUsPage(),
        ];

  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  State<StatefulWidget> createState() => new PageViewState(
        pages: _pages,
        pageController: _pageController,
      );
}

class PageViewState extends State<PageViewWrapper> {
  final PageController pageController;
  final List<IsPage> pages;

  PageViewState({
    @required this.pages,
    @required this.pageController,
  });

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(
          BuildContext context, Store<AppState> store, int pageIndex) =>
      store.dispatch(new PageChangedAction(pages[pageIndex], pageIndex));

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, Store<AppState>>(
        onInit: (Store<AppState> store) => onPageChanged(context, store, 0),
        builder: (context, Store<AppState> store) => new PageView(
              children: pages,
              controller: pageController,
              onPageChanged: (index) => onPageChanged(context, store, index),
            ),
        converter: (Store<AppState> store) => store,
      );
}
