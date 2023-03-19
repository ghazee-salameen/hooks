import 'package:go_router/go_router.dart';
import 'package:hook/pages/attendance_pages.dart';

import '../main.dart';

import '../pages/copier_pages.dart';
import '../pages/duplicater_pages.dart';
import '../pages/printer_pages.dart';
import '../pages/schoolmainpage.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(routes: <GoRoute>[
    GoRoute(
      path: 'school/:schoolID',
      builder: (context, state) => MainPage(
        schoolID: state.params["schoolID"]!,
      ),
    ),
    GoRoute(
      path: 'menu/:schoolID',
      builder: (context, state) => PageMenu(
        schoolID: state.params["schoolID"]!,
      ),
    ),
    GoRoute(
      path: 'addCopier/:schoolID',
      builder: (context, state) => AddNewCopier(
        schoolID: state.params["schoolID"]!,
      ),
    ),
    GoRoute(
      path: 'copier/:schoolID',
      builder: (context, state) => CopierMenu(
        schoolID: state.params["schoolID"]!,
      ),
    ),
    GoRoute(
      path: 'printer/:schoolID',
      builder: (context, state) => PrinterPages(
        schoolID: state.params["schoolID"]!,
      ),
    ),
    GoRoute(
      path: 'attendance/:schoolID',
      builder: (context, state) => AttendancePages(
        schoolID: state.params["schoolID"]!,
      ),
    ),
    // GoRoute(
    //   path: 'lcd/:schoolID',
    //   builder: (context, state) => LcdPages(
    //     schoolID: state.params["schoolID"]!,
    //   ),
    // ),
    // GoRoute(
    //   path: 'facilities/:schoolID',
    //   builder: (context, state) => FacilitiesMenu(
    //     schoolID: state.params["schoolID"]!,
    //   ),
    // ),
    // GoRoute(
    //   path: 'wireless/:schoolID',
    //   builder: (context, state) => WirelessMenu(
    //     schoolID: state.params["schoolID"]!,
    //   ),
    // ),
    GoRoute(
      path: 'duplicater/:schoolID',
      builder: (context, state) => DuplicaterMenu(
        schoolID: state.params["schoolID"]!,
      ),
    ),
    // GoRoute(
    //   path: 'test2',
    //   builder: (context, state) => TestPage2(),
    // ),
  ], path: '/', builder: ((context, state) => HomePage()))
]);
