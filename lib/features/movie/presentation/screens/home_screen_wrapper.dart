import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({super.key});

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  int _indexValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const LogoutEvent());
            },
            icon: const Icon(Icons.logout,),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(
            () {
              _indexValue = value;
            },
          );
        },
        currentIndex: _indexValue,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              AppImages.homeDarkFilled,
              width: 22,
              height: 22,
            ),
            icon: Image.asset(
              AppImages.homeDark,
              width: 22,
              height: 22,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              AppImages.ticketsDarkFilled,
              width: 22,
              height: 22,
            ),
            icon: Image.asset(
              AppImages.ticketsDark,
              width: 22,
              height: 22,
            ),
            label: "Tickets",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              AppImages.profileDarkFilled,
              width: 22,
              height: 22,
            ),
            icon: Image.asset(
              AppImages.profileDark,
              width: 22,
              height: 22,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
