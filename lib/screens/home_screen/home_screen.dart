import 'package:evently_c17_fri/providers/auth_provider.dart';
import 'package:evently_c17_fri/providers/home_provider.dart';
import 'package:evently_c17_fri/screens/add_event/add_event_screen.dart';
import 'package:evently_c17_fri/screens/home_screen/tabs/fav_page.dart';
import 'package:evently_c17_fri/screens/home_screen/tabs/home_page.dart';
import 'package:evently_c17_fri/screens/home_screen/tabs/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});
  static const Color _scaffoldBg       = Color(0xFFEEF0FF);
  static const Color _primaryBlue      = Color(0xFF1A237E);
  static const Color _accentBlue       = Color(0xFF3949AB);
  static const Color _cardWhite        = Color(0xFFFFFFFF);
  static const Color _inactiveIcon     = Color(0xFFB0B8D8);
  static const Color _appBarBg         = Color(0xFFEEF0FF);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var homeProvider = Provider.of<HomeProvider>(context);
        return Theme(
          data: Theme.of(context).copyWith(
            scaffoldBackgroundColor: _scaffoldBg,
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: _appBarBg,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: _primaryBlue,
              foregroundColor: Colors.white,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: _cardWhite,
              selectedItemColor: _primaryBlue,
              unselectedItemColor: _inactiveIcon,
              elevation: 8,
              type: BottomNavigationBarType.fixed,
            ),
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: _primaryBlue,
              secondary: _accentBlue,
              surface: _cardWhite,
            ),
          ),
          child: Scaffold(
            backgroundColor: _scaffoldBg,
            appBar: AppBar(
              backgroundColor: _appBarBg,
              elevation: 0,
              actions: [
                ImageIcon(
                  AssetImage("assets/images/sun.png"),
                  color: _primaryBlue,
                ),
                SizedBox(width: 12),
                Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _primaryBlue,
                  ),
                  child: Center(
                    child: Text(
                      "EN",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
              ],
              title: ListTile(
                title: Text(
                  "Welcome Back ✨",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _primaryBlue.withOpacity(0.65),
                  ),
                ),
                subtitle: Text(
                  provider.userModel?.name ?? "NA",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: _primaryBlue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              centerTitle: false,
            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: _primaryBlue,
              onPressed: () {
                Navigator.of(context).pushNamed(AddEventScreen.routeName);
              },
              child: Icon(Icons.add, color: Colors.white),
            ),

            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: _cardWhite,
              selectedItemColor: _primaryBlue,
              unselectedItemColor: _inactiveIcon,
              onTap: (value) {
                homeProvider.changeSelectedIndex(value);
              },
              currentIndex: homeProvider.selectedIndex,
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/home-2.png")),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/heart.png")),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/user.png")),
                  label: "Profile",
                ),
              ],
            ),

            body: tabs[homeProvider.selectedIndex],
          ),
        );
      },
    );
  }

  List<Widget> tabs = [HomePage(), FavouritePage(), ProfilePage()];
}