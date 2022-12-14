import 'package:ebook/state_management/dashboard_navigation/dashboard_navigation_cubit.dart';
import 'package:ebook/ui/pages/dashboard/categories/categories_page.dart';
import 'package:ebook/ui/pages/dashboard/favorite/favorite_page.dart';
import 'package:ebook/ui/pages/dashboard/home/home_page.dart';
import 'package:ebook/ui/pages/dashboard/library/library_page.dart';
import 'package:ebook/ui/pages/dashboard/profile/profile_page.dart';
import 'package:ebook/utils/enum/dashboard_navigation_enum.dart';
import 'package:ebook/utils/theme/styling_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'favorite/favorite_page.dart';
export 'home/home_page.dart';

class DashBoard extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const DashBoard());
  }

  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardNavigationCubit>(
      create: (context) => DashboardNavigationCubit(),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar:
              BlocBuilder<DashboardNavigationCubit, DashboardNavigationState>(
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: state.index,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                selectedLabelStyle: StylingText.bottomNavigationSelected,
                unselectedLabelStyle: StylingText.bottomNavigationUnSelected,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category_outlined),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_library),
                    label: 'Library',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                onTap: (index) {
                  if (index == 0) {
                    BlocProvider.of<DashboardNavigationCubit>(context)
                        .getNavBarItem(DashboardNavigationItems.home);
                  } else if (index == 1) {
                    BlocProvider.of<DashboardNavigationCubit>(context)
                        .getNavBarItem(DashboardNavigationItems.categories);
                  } else if (index == 2) {
                    BlocProvider.of<DashboardNavigationCubit>(context)
                        .getNavBarItem(DashboardNavigationItems.library);
                  } else if (index == 3) {
                    BlocProvider.of<DashboardNavigationCubit>(context)
                        .getNavBarItem(DashboardNavigationItems.favorite);
                  } else if (index == 4) {
                    BlocProvider.of<DashboardNavigationCubit>(context)
                        .getNavBarItem(DashboardNavigationItems.profile);
                  }
                },
              );
            },
          ),
          body: BlocBuilder<DashboardNavigationCubit, DashboardNavigationState>(
              builder: (context, state) {
            if (state.navbarItem == DashboardNavigationItems.home) {
              return const HomePage();
            } else if (state.navbarItem ==
                DashboardNavigationItems.categories) {
              return const CategoriesPage();
            } else if (state.navbarItem == DashboardNavigationItems.library) {
              return const LibraryPage();
            } else if (state.navbarItem == DashboardNavigationItems.favorite) {
              return const FavoritePage();
            } else if (state.navbarItem == DashboardNavigationItems.profile) {
              return const ProfilePage();
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
