class SchoolColumn {
  static const String sid = 'sid';
  static const String sname = 'sname';
}

class School {
  int sid;
  String sname;

  School({required this.sid, required this.sname});

  Map<String, dynamic> toMap() {
    return {
      SchoolColumn.sid: sid,
      SchoolColumn.sname: sname,
    };
  }

  String toString() {
    return '$sname ';
  }
}

class SchoolModelColumn {
  static const String ID = 'ID';
  static const String shSchoolsTbl = 'shSchoolsTbl';
  static const String schoolID = 'schoolID';
  static const String schoolName = 'schoolName';
  static const String computerLab = 'computerLab';
  static const String sinceLab = 'sinceLab';
  static const String library = 'library';
  static const String wirelessNetwork = 'wirelessNetwork';
  static const String attendanceClock = 'attendanceClock';
  static const String tecLab = 'tecLab';
  static const String lanNetWork = 'lanNetwork';
  static const String internet = 'internet';
  static const String internetSpeed = 'internetSpeed';
}

class SchoolModel {
  int? ID;
  String schoolID;
  String schoolName;
  int computerLab;
  int sinceLab;
  int library;
  int wirelessNetwork;
  int attendanceClock;
  int tecLab;
  int lanNetWork;
  int internet;
  String internetSpeed;

  SchoolModel({
    this.ID,
    required this.schoolID,
    required this.schoolName,
    required this.computerLab,
    required this.tecLab,
    required this.sinceLab,
    required this.library,
    required this.wirelessNetwork,
    required this.attendanceClock,
    required this.lanNetWork,
    required this.internet,
    required this.internetSpeed,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
        ID: int.parse(json['ID']),
        schoolID: json['schoolID'].toString(),
        schoolName: json['schoolName'].toString(),
        computerLab: json['computerLab'] == '0' ? 0 : 1,
        tecLab: json['tecLab'] == '0' ? 0 : 1,
        sinceLab: json['sinceLab'] == '0' ? 0 : 1,
        library: json['library'] == '0' ? 0 : 1,
        wirelessNetwork: json['wirelessNetwork'] == '0' ? 0 : 1,
        attendanceClock: json['attendanceClock'] == '0' ? 0 : 1,
        lanNetWork: json['lanNetwork'] == '0' ? 0 : 1,
        internet: json['internet'] == '0' ? 0 : 1,
        internetSpeed: json['internetSpeed']);
  }

  Map<String, dynamic> toMap() {
    return {
      SchoolModelColumn.schoolID: schoolID,
      SchoolModelColumn.schoolName: schoolName,
      SchoolModelColumn.computerLab: computerLab,
      SchoolModelColumn.tecLab: tecLab,
      SchoolModelColumn.sinceLab: sinceLab,
      SchoolModelColumn.library: library,
      SchoolModelColumn.wirelessNetwork: wirelessNetwork,
      SchoolModelColumn.attendanceClock: attendanceClock,
      SchoolModelColumn.lanNetWork: lanNetWork,
      SchoolModelColumn.internet: internet,
      SchoolModelColumn.internetSpeed: internetSpeed,
    };
  }

  @override
  String toString() {
    return '''
SchoolModel(
        ID: $ID,
        schoolID:$schoolID,
        schoolName: $schoolName,
        computerLab: $computerLab,
        tecLab: $tecLab,
        sinceLab: $sinceLab,
        library: $library,
        wirelessNetwork: $wirelessNetwork,
        attendanceClock: $attendanceClock,
        lanNetWork: $lanNetWork,
        internet: $internet,
        internetSpeed: $internetSpeed)
 ''';
  }
}

List<School> SchoolsList = [
  School(sid: 27112272, sname: 'ذكور ابن خلدون الأساسية'),
  School(sid: 27112233, sname: 'بنات الحدب الثانوية'),
  School(sid: 27112234, sname: 'أبو الغزلان الأساسية المختلطة'),
  School(sid: 27113445, sname: 'إمريش الأساسية المختلطة'),
  School(sid: 27112249, sname: 'الظاهر بيبرس الاساسية المختلطة'),
  School(sid: 27113299, sname: 'ذكور رافات الأساسية'),
  School(sid: 27111052, sname: 'ذكور صلاح الدين الثانوية'),
  School(sid: 27112235, sname: 'ذكور شهداء إذنا الأساسية'),
  School(sid: 27113461, sname: 'ذكور ضرار بن الأزور الأساسية'),
  School(sid: 27112029, sname: 'ذكور امريش الاساسية'),
  School(sid: 27111240, sname: 'اليرموك الأساسية المختلطة'),
  School(sid: 27112015, sname: 'بنات البرج الثانوية'),
  School(sid: 27112204, sname: 'بنات سكينة بنت الحسين الثانوية'),
  School(sid: 27112229, sname: 'عناب الكبيرة الأساسية المختلطة'),
  School(sid: 27112284, sname: 'ذكور كرم الأشقر الأساسية'),
  School(sid: 27113462, sname: 'الكويتية الأساسية المختلطة'),
  School(sid: 27111107, sname: 'بنات شهداء دورا الاساسية'),
  School(sid: 27112048, sname: 'ذكور الشهيد ياسر عرفات الثانوية'),
  School(sid: 27113292, sname: 'ذكور الحدب الأساسية'),
  School(sid: 27112223, sname: 'بنات الصرة الثانوية'),
  School(sid: 27111154, sname: 'ذكور الشهيد ماجد ابو شرار الثانوية'),
  School(sid: 27112155, sname: 'ذكور خرسا الثانوية'),
  School(sid: 27113460, sname: 'ذكور الخوارزمي الأساسية'),
  School(sid: 27112181, sname: 'ذكور رافات الثانوية'),
  School(sid: 27113290, sname: 'شعيب العواودة الأساسية المختلطة'),
  School(sid: 27113430, sname: 'الفاتحين الأساسية المختلطة'),
  School(sid: 27113434, sname: 'السموع الأساسية المختلطة '),
  School(sid: 27111236, sname: 'ذكور ابن سينا الأساسية'),
  School(sid: 27113294, sname: 'ذكور شهداء البرج الأساسية'),
  School(sid: 27112191, sname: 'بنات دوما الثانوية'),
  School(sid: 27113467, sname: 'بنات حيفا الأساسية'),
  School(sid: 27112008, sname: 'بنات المجد الثانوية'),
  School(sid: 27113447, sname: 'عمر بن الخطاب الأساسية المختلطة'),
  School(sid: 27112189, sname: 'ذكور الظاهرية الاساسية'),
  School(sid: 27112039, sname: 'ذكور الظاهرية الثانوية'),
  School(sid: 27113446, sname: 'عقبة بن نافع الأساسية المختلطة'),
  School(sid: 27112262, sname: 'البيرة الأساسية المختلطة'),
  School(sid: 27113429, sname: 'ذكور المدينه المنوره الأساسية'),
  School(sid: 27112258, sname: 'بنات شهداء الظاهرية الثانوية'),
  School(sid: 27112051, sname: 'ذكور كرزا الثانوية'),
  School(sid: 27112275, sname: 'خرسا الاساسية المختلطة'),
  School(sid: 27112222, sname: 'بنات بيت عوا الأساسية '),
  School(sid: 27112065, sname: 'مدرسة الطبقة الأساسية المختلطة'),
  School(sid: 27112050, sname: 'دير العسل التحتا الأساسية المختلطة'),
  School(sid: 27113443, sname: 'الأشرفية الأساسية المختلطة'),
  School(sid: 27112060, sname: 'ذكور المجد الثانوية'),
  School(sid: 27113437, sname: 'فدوى طوقان الأساسية المختلطة'),
  School(sid: 27112248, sname: 'بنات الحرمين الاساسية'),
  School(sid: 27112062, sname: 'ذكور الياسرية الثانوية'),
  School(sid: 27112274, sname: 'بنات خولة بنت الازور الاساسية'),
  School(sid: 27113456, sname: 'خلة حماد الأساسية المختلطة'),
  School(sid: 27112036, sname: 'دير رازح الأساسية المختلطة'),
  School(sid: 27112251, sname: 'بنات الضياء الأساسية'),
  School(sid: 27112156, sname: 'دير العسل الفوقا الثانوية المختلطة'),
  School(sid: 27112063, sname: 'سكة الاساسية المختلطة'),
  School(sid: 27111030, sname: 'بنات دورا الثانوية'),
  School(sid: 27112253, sname: 'عرب الفريجات الأساسية المختلطة'),
  School(sid: 27111053, sname: 'ذكور الرازي الاساسية'),
  School(sid: 27111273, sname: 'جبل طاروسة الاساسية المختلطة'),
  School(sid: 27111283, sname: 'ذكور طه الرجعي الأساسية'),
  School(sid: 27112080, sname: 'بنات اشبيلية الثانوية'),
  School(sid: 27113432, sname: 'ذكور السيميا الأساسية'),
  School(sid: 27113468, sname: 'ذكور الفالوجة الاساسية'),
  School(sid: 27113457, sname: 'واد دومة الأساسية المختلطة'),
  School(sid: 27112038, sname: 'ذكور الريحية الثانوية'),
  School(sid: 27112250, sname: 'خالد بن الوليد الأساسية المختلطة'),
  School(sid: 27113288, sname: 'ذكور معاذ بن جبل الأساسية'),
  School(sid: 27112326, sname: 'ذكور شهداء الفوار الثانوية'),
  School(sid: 27112226, sname: 'ذكور الكرامة الأساسية'),
  School(sid: 27112049, sname: 'السيميا الاساسية المختلطة'),
  School(sid: 27113458, sname: 'التحدي 13 السيميا الاساسية المختلطة'),
  School(sid: 27113452, sname: 'الشهيد موفق السلطي الاساسية المختلطة'),
  School(sid: 27112180, sname: 'ذكور جعفر بن أبي طالب الأساسية '),
  School(sid: 27113287, sname: 'يافا الاساسية المختلطة'),
  School(sid: 27112115, sname: 'بنات السموع الأساسية'),
  School(sid: 27112077, sname: 'بنات مؤتة الثانوية'),
  School(sid: 27112078, sname: 'بنات السموع الثانوية'),
  School(sid: 27112192, sname: 'ذكور البخاري الاساسية'),
  School(sid: 27112042, sname: 'ذكور السموع الثانوية'),
  School(sid: 27112184, sname: 'ذكور السموع الاساسية'),
  School(sid: 27112225, sname: 'بنات رافات الاساسية '),
  School(sid: 27112114, sname: 'بنات خليل الوزير الأساسية'),
  School(sid: 27113464, sname: 'واد علي الأساسية المختلطة'),
  School(sid: 27113433, sname: 'علي بن أبي طالب الأساسية المختلطة'),
  School(sid: 27113439, sname: 'الشهيد أبوعمار الأساسية المختلطة'),
  School(sid: 27112210, sname: 'بنات إذنا الأساسية'),
  School(sid: 27112224, sname: 'بنات تل الربيع الأساسية'),
  School(sid: 27112178, sname: 'بنات إذنا الثانوية'),
  School(sid: 27112207, sname: 'بنات حفصة بنت عمر الاساسية'),
  School(sid: 27113448, sname: 'خلة الغزال الاساسية المختلطة'),
  School(sid: 27113440, sname: 'ذكور إذنا الأساسية'),
  School(sid: 27112037, sname: 'ذكور إذنا الثانوية'),
  School(sid: 27112218, sname: 'ذكور العودة الاساسية'),
  School(sid: 27112401, sname: 'ذكور المجدل الأساسية'),
  School(sid: 27112179, sname: 'ذكور بني حارث الاساسية'),
  School(sid: 27112025, sname: 'ذكور محمود درويش الأساسية'),
  School(sid: 27112320, sname: 'عسقلان الأساسية المختلطة '),
  School(sid: 27113471, sname: 'ذكور جمال علي الاساسية'),
  School(sid: 27113423, sname: 'الرافدين الأساسية المختلطة'),
  School(sid: 27112265, sname: 'شويكة الأساسية المختلطة'),
  School(sid: 27113455, sname: 'بادية الرماضين الاساسية المختلطة'),
  School(sid: 27112009, sname: 'بنات الاندلس الاساسية'),
  School(sid: 27113431, sname: 'بنات الرماضين الثانوية'),
  School(sid: 27112007, sname: 'بنات الظاهرية الاساسية'),
  School(sid: 27112081, sname: 'بنات الظاهرية الثانوية '),
  School(sid: 27112006, sname: 'بنات عائشة الاساسية'),
  School(sid: 27112040, sname: 'ذكور ابو عبيدة الاساسية'),
  School(sid: 27113451, sname: 'ذكور ابو نجيم الاساسية '),
  School(sid: 27112239, sname: 'ذكور الرماضين الثانوية'),
  School(sid: 27112190, sname: 'ذكور الغزالي الاساسية'),
  School(sid: 27112035, sname: 'ذكور دوما الاساسية'),
  School(sid: 27112045, sname: 'ذكور الفاروق الأساسية'),
  School(sid: 27112066, sname: 'ذكور عناب الصغيرة الاساسية'),
  School(sid: 27112186, sname: 'ذكور عثمان بن عفان الأساسية '),
  School(sid: 27112287, sname: 'واد السلطان الأساسية المختلطة'),
  School(sid: 27113454, sname: 'زنوتا الاساسية المختلطة'),
  School(sid: 27113286, sname: 'زهرة المدائن الأساسية المختلطة'),
  School(sid: 27112034, sname: 'أبو العرقان الاساسية المختلطة'),
  School(sid: 27112252, sname: 'ابو العسجا الاساسية المختلطة'),
  School(sid: 27112242, sname: 'البيادر الأساسية المختلطة'),
  School(sid: 27112403, sname: 'الصره الاساسية المختلطه'),
  School(sid: 27112032, sname: 'ذكور الصرة الثانوية'),
  School(sid: 27112286, sname: 'بنات امريش الثانوية'),
  School(sid: 27112185, sname: 'بنات كرزا الثانوية'),
  School(sid: 27112277, sname: 'بنات كرمة الثانوية'),
  School(sid: 27113450, sname: 'خلة العقد الاساسية المختلطة'),
  School(sid: 27112033, sname: 'ذكور كرمة الثانوية'),
  School(sid: 27112188, sname: 'رابود الثانوية المختلطة '),
  School(sid: 27113295, sname: 'دلال المغربي الاساسية المختلطة'),
  School(sid: 27113442, sname: 'الرحمة الأساسية المختلطة'),
  School(sid: 27113453, sname: 'الدير الاساسية المختلطة'),
  School(sid: 27112255, sname: 'الكوم الأساسية المختلطة'),
  School(sid: 27111241, sname: 'القادسية الاساسية المختلطة'),
  School(sid: 27111256, sname: 'القدس الأساسية المختلطة'),
  School(sid: 27111260, sname: 'بنات الاقصى الاساسية'),
  School(sid: 27111106, sname: 'بنات دار السلام الثانوية'),
  School(sid: 27113444, sname: 'بنات دار السلام الأساسية'),
  School(sid: 27113282, sname: 'بنات الفوار الثانوية '),
  School(sid: 27112116, sname: 'بنات خرسا الثانويه'),
  School(sid: 27111221, sname: 'فلسطين الأساسية المختلطة'),
  School(sid: 27112183, sname: 'بنات كريسة الثانوية '),
  School(sid: 27112270, sname: 'كريسة الاساسية المختلطة'),
  School(sid: 27113449, sname: 'كنار الاساسية المختلطة'),
  School(sid: 27112153, sname: 'زيد بن حارثة الأساسية المختلطة'),
  School(sid: 27113459, sname: 'ذكور إبراهيم طوقان الأساسية'),
  School(sid: 27112280, sname: 'بنات الزهراء الاساسية'),
  School(sid: 27113436, sname: 'الهجرة الأساسية المختلطه'),
  School(sid: 27113469, sname: 'ذكور كفر قاسم الأساسية'),
  School(sid: 27113289, sname: 'لقمان الحكيم الاساسية المختلطة'),
  School(sid: 27112047, sname: 'ذكور بيت الروش الثانوية'),
  School(sid: 27112046, sname: 'ذكور البرج الثانوية '),
  School(sid: 27111271, sname: 'ذكور دورا الثانوية المهنية'),
  School(sid: 27113438, sname: 'عين فارس الأساسية المختلطة'),
  School(sid: 27112269, sname: 'المجد الأساسية المختلطة'),
  School(sid: 27112264, sname: 'بنات الريحية الاساسية'),
  School(sid: 27112082, sname: 'بنات الريحية الثانوية '),
  School(sid: 27112044, sname: 'بيت مرسم الأساسية المختلطة'),
  School(sid: 27112187, sname: 'ذكور الشهيد أبو جهاد الثانوية'),
  School(sid: 27112261, sname: 'بيت الروش التحتا الاساسية المختلطة'),
  School(sid: 27112043, sname: 'بنات بيت عوا الثانوية'),
  School(sid: 27113441, sname: 'ذكور بيت عوا الأساسية'),
  School(sid: 27112093, sname: 'ذكور دير سامت الأساسية'),
  School(sid: 27113285, sname: 'الوحده الاساسيه المختلطه'),
  School(sid: 27112041, sname: 'ذكور دير سامت الثانوية'),
  School(sid: 27112182, sname: 'بنات الشهيد عبد العزيز الرجوب الثانوية '),
  School(sid: 27112079, sname: 'دير سامت الأساسية المختلطة'),
  School(sid: 27113466, sname: 'ذكور عيلبون الأساسية'),
  School(sid: 27112259, sname: 'بنات بيت الروش الثانوية'),
  School(sid: 27112322, sname: 'بنات بيسان الاساسية'),
  School(sid: 27112064, sname: 'ذكور بيت عوا الثانوية'),
  School(sid: 27112237, sname: 'شهداء السموع الأساسية المختلطة'),
  School(sid: 27113435, sname: 'غوين الأساسية المختلطة'),
  School(sid: 27112206, sname: 'بنات دير سامت الثانوية'),
  School(sid: 27113463, sname: 'ذكور دير العسل الفوقا الثانوية'),
  School(sid: 27113421, sname: 'عكا الأساسية المختلطه'),
  School(sid: 27113465, sname: 'ذكور الصخرة الأساسية'),
  School(sid: 27113477, sname: 'زكي خلاوي الاساسية المختلطة'),
  School(sid: 27113479, sname: 'ذكور الخنساء الاساسية'),
];

List schoolnames = [
  'ذكور ابن خلدون الأساسية',
  'بنات الحدب الثانوية',
  'أبو الغزلان الأساسية المختلطة',
  'إمريش الأساسية المختلطة',
  'الظاهر بيبرس الاساسية المختلطة',
  'ذكور رافات الأساسية',
  'ذكور صلاح الدين الثانوية',
];
