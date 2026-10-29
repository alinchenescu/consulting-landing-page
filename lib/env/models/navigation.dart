part of '../env.dart';

class NavigationModel extends DModel {
  const NavigationModel({
    required this.id,
    required this.name,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final String id, name;
  final IconData activeIcon, inactiveIcon;

  static const NavigationModel home = NavigationModel(
    id: 'home',
    name: 'Home',
    activeIcon: Icons.home_rounded,
    inactiveIcon: Icons.home_outlined,
  );

  static const NavigationModel about = NavigationModel(
    id: 'about-us',
    name: 'About Us',
    activeIcon: Icons.groups_rounded,
    inactiveIcon: Icons.groups_outlined,
  );

  static const NavigationModel services = NavigationModel(
    id: 'services',
    name: 'Services',
    activeIcon: Icons.work_rounded,
    inactiveIcon: Icons.work_outline_rounded,
  );

  static const NavigationModel contact = NavigationModel(
    id: 'contact',
    name: 'Contact',
    activeIcon: Icons.mail_rounded,
    inactiveIcon: Icons.mail_outline_rounded,
  );
}
