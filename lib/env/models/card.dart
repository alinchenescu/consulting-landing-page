part of '../env.dart';

@model
class CardModel extends DModel {
  const CardModel({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @variable
  final IconData icon;

  @variable
  final String title;

  @variable
  final String subtitle;
}
