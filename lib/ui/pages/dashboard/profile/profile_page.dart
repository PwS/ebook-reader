import 'package:ebook/state_management/theme_handler/theme_handler_bloc.dart';
import 'package:ebook/ui/pages/dashboard/profile/language/language_page.dart';
import 'package:ebook/utils/constant/assets_path.dart';
import 'package:ebook/utils/enum/app_theme_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          children: [
            const Text(
              'General Setting',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            const SwitchTheme(),
            const Divider(
              height: 5,
            ),
            ListTile(
              title: const Text('Language'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.language_outlined,
                    size: 20, color: Colors.white),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const LanguagePage()),
              ),
            ),
            const Divider(
              height: 5,
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.lock, size: 20, color: Colors.white),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
              ),
            ),
          ],
        ));
  }
}

class SwitchTheme extends StatelessWidget {
  const SwitchTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeHandlerBloc, ThemeHandlerState>(
      builder: (context, state) {
        return ListTile(
            title: const Text('Theme'),
            leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.cyan, borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(AssetsPath.icChangeTheme,
                    color: Colors.white)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.light_mode),
                Switch(
                  value: state.appTheme == AppTheme.light ? false : true,
                  onChanged: (newValue) {
                    context.read<ThemeHandlerBloc>().add(SwitchThemeEvent(
                        newValue ? AppTheme.dark : AppTheme.light));
                  },
                ),
                const Icon(Icons.dark_mode),
              ],
            ));
      },
    );
  }
}
