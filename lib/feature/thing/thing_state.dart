import 'package:flutter/material.dart';

class ThingState {
  const ThingState({
    required this.thing,
    required this.color,
  });

  final String thing;
  final Color color;

  factory ThingState.fromJson(Map<String, dynamic> json) {
    return ThingState(
      thing: json["thing"] as String,
      color: json["color"] as Color,
    );
  }

  Map<String, dynamic> toJson() => {
    'thing': thing,
    'color': color,
  };

  ThingState copWith({
    String? thing,
    Color? color,
  }) =>
      ThingState(
        thing: thing ?? this.thing,
        color: color ?? this.color,
      );
}
