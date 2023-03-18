import 'package:flutter/material.dart';

class Choice {
  Choice({required this.title, required this.icon, required this.deviceid});
  final String title;
  final IconData icon;
  final int deviceid;
}

List<Choice> choices = <Choice>[
  Choice(title: 'ماكنات التصوير', icon: Icons.copy_rounded, deviceid: 1),
  Choice(title: 'ماكنات السحب', icon: Icons.scanner_rounded, deviceid: 2),
  Choice(title: 'اجهزة العرض', icon: Icons.movie_rounded, deviceid: 3),
  Choice(title: 'الطابعات', icon: Icons.print_rounded, deviceid: 4),
  Choice(title: 'الشبكة اللاسلكية', icon: Icons.wifi, deviceid: 5),
  Choice(title: 'مرافق المدرسة', icon: Icons.library_books, deviceid: 6),
  Choice(title: 'مختبر العلوم', icon: Icons.build_circle, deviceid: 7),
  Choice(title: 'مختبر الحاسوب', icon: Icons.computer, deviceid: 8),
  Choice(title: 'ساعات الدوام', icon: Icons.punch_clock_outlined, deviceid: 9),
];
