import 'package:bloc/bloc.dart';
import 'package:ebook/utils/enum/dashboard_navigation_enum.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_navigation_state.dart';

class DashboardNavigationCubit extends Cubit<DashboardNavigationState> {
  DashboardNavigationCubit()
      : super(const DashboardNavigationState(DashboardNavigationItems.home, 0));

  void getNavBarItem(DashboardNavigationItems navbarItem) {
    switch (navbarItem) {
      case DashboardNavigationItems.home:
        emit(const DashboardNavigationState(DashboardNavigationItems.home, 0));
        break;
      case DashboardNavigationItems.categories:
        emit(const DashboardNavigationState(
            DashboardNavigationItems.categories, 1));
        break;
      case DashboardNavigationItems.library:
        emit(const DashboardNavigationState(
            DashboardNavigationItems.library, 2));
        break;
      case DashboardNavigationItems.favorite:
        emit(const DashboardNavigationState(
            DashboardNavigationItems.favorite, 3));
        break;
      case DashboardNavigationItems.profile:
        emit(const DashboardNavigationState(
            DashboardNavigationItems.profile, 4));
        break;
    }
  }
}
