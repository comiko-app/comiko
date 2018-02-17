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
  final PageController pageController = new PageController();

  PageViewWrapper({@required this.store}) {
    _pages = [
      new UpcomingEventsPage(store: store),
      new ArtistsPage(),
      new AboutUsPage(),
    ];
  }

  void navigationTapped(int page) {
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  State<StatefulWidget> createState() {
    return new PageViewState(_pages, pageController, store);
  }
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

  PageViewState(this.pages, this.pageController, this.store);

  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: pages,
      controller: pageController,
      onPageChanged: (index) => onPageChanged(context, index),
    );
  }

  void onPageChanged(BuildContext context, int pageIndex) {
    store.dispatch(new PageChangedAction(pages[pageIndex], pageIndex));
  }
}
