part of 'dashboard_navigation_cubit.dart';

class DashboardNavigationState extends Equatable {
  final DashboardNavigationItems navbarItem;
  final int index;

  const DashboardNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}