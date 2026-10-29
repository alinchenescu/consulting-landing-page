part of '../home.dart';

enum HomeServiceType { project, month, engagement }

@model
class HomeServiceModel extends DModel {
  const HomeServiceModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.price,
    required this.benefits,
    required this.type,
    this.isFeatured = false,
  });

  @variable
  final IconData icon;

  @variable
  final String title;

  @variable
  final String description;

  /// Starting price in USD.
  @variable
  final int price;

  @variable
  final String benefits;

  @Variable(defaultsTo: HomeServiceType.project)
  final HomeServiceType type;

  @variable
  final bool isFeatured;

  /// Price formatted with thousands separators, e.g. `12,500`.
  String get formattedPrice {
    return price.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (_) => ',',
        );
  }
}
