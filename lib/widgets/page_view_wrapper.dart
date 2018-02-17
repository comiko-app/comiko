import 'package:comiko/app_state.dart';
import 'package:comiko/pages/about_us_page.dart';
import 'package:comiko/pages/artists_page.dart';
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/pages/upcoming_events_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class PageViewWrapper extends StatefulWidget {
  final Store<AppState> store;
  List<IsPage> _pages;
  final PageController _pageController = new PageController();

  PageViewWrapper({
    @required this.store,
  }) {
    _pages = [
      new UpcomingEventsPage(store: store),
      new ArtistsPage(),
      new AboutUsPage(),
    ];
  }

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
        store: store,
      );
}

class PageViewState extends State<PageViewWrapper> {
  final PageController pageController;
  final List<IsPage> pages;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  final Store<AppState> store;

  PageViewState({
    @required this.pages,
    @required this.pageController,
    @required this.store,
  });

  @override
  Widget build(BuildContext context) => new PageView(
        children: pages,
        controller: pageController,
        onPageChanged: (index) => onPageChanged(context, index),
      );

  void onPageChanged(BuildContext context, int pageIndex) =>
      store.dispatch(new PageChangedAction(pages[pageIndex], pageIndex));
}
