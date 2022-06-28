import 'dart:convert';

import 'package:flutter/material.dart';

class catalog{
  static List<item> items = [];
}



class item {
   final String countryname;
   final String continentname;
  item({
    required this.countryname,
    required this.continentname,
  });

  item copyWith({
    String? countryname,
    String? continentname,
  }) {
    return item(
      countryname: countryname ?? this.countryname,
      continentname: continentname ?? this.continentname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countryname': countryname,
      'continentname': continentname,
    };
  }

  factory item.fromMap(Map<String, dynamic> map) {
    return item(
      countryname: map['countryname'] ?? '',
      continentname: map['continentname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory item.fromJson(String source) => item.fromMap(json.decode(source));

  @override
  String toString() => 'item(countryname: $countryname, continentname: $continentname)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is item &&
      other.countryname == countryname &&
      other.continentname == continentname;
  }

  @override
  int get hashCode => countryname.hashCode ^ continentname.hashCode;
}
