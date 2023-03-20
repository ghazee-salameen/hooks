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
  School(sid:27112272, sname:'ذكور ابن خلدون الأساسية  27112272'),
  School(sid:27112233, sname:'بنات الحدب الثانوية  27112233'),
  School(sid:27112234, sname:'أبو الغزلان الأساسية المختلطة  27112234'),
  School(sid:27113445, sname:'إمريش الأساسية المختلطة  27113445'),
  School(sid:27112249, sname:'الظاهر بيبرس الاساسية المختلطة  27112249'),
  School(sid:27113299, sname:'ذكور رافات الأساسية  27113299'),
  School(sid:27111052, sname:'ذكور صلاح الدين الثانوية  27111052'),
  School(sid:27112235, sname:'ذكور شهداء إذنا الأساسية  27112235'),
  School(sid:27113461, sname:'ذكور ضرار بن الأزور الأساسية  27113461'),
  School(sid:27112029, sname:'ذكور امريش الاساسية  27112029'),
  School(sid:27111240, sname:'اليرموك الأساسية المختلطة  27111240'),
  School(sid:27112015, sname:'بنات البرج الثانوية  27112015'),
  School(sid:27112204, sname:'بنات سكينة بنت الحسين الثانوية  27112204'),
  School(sid:27112229, sname:'عناب الكبيرة الأساسية المختلطة  27112229'),
  School(sid:27112284, sname:'ذكور كرم الأشقر الأساسية  27112284'),
  School(sid:27113462, sname:'الكويتية الأساسية المختلطة  27113462'),
  School(sid:27111107, sname:'بنات شهداء دورا الاساسية  27111107'),
  School(sid:27112048, sname:'ذكور الشهيد ياسر عرفات الثانوية  27112048'),
  School(sid:27113292, sname:'ذكور الحدب الأساسية  27113292'),
  School(sid:27112223, sname:'بنات الصرة الثانوية  27112223'),
  School(sid:27111154, sname:'ذكور الشهيد ماجد ابو شرار الثانوية  27111154'),
  School(sid:27112155, sname:'ذكور خرسا الثانوية  27112155'),
  School(sid:27113460, sname:'ذكور الخوارزمي الأساسية  27113460'),
  School(sid:27112181, sname:'ذكور رافات الثانوية  27112181'),
  School(sid:27113290, sname:'شعيب العواودة الأساسية المختلطة  27113290'),
  School(sid:27113430, sname:'الفاتحين الأساسية المختلطة  27113430'),
  School(sid:27113434, sname:'السموع الأساسية المختلطة   27113434'),
  School(sid:27111236, sname:'ذكور ابن سينا الأساسية  27111236'),
  School(sid:27113294, sname:'ذكور شهداء البرج الأساسية  27113294'),
  School(sid:27112191, sname:'بنات دوما الثانوية  27112191'),
  School(sid:27113467, sname:'بنات حيفا الأساسية  27113467'),
  School(sid:27112008, sname:'بنات المجد الثانوية  27112008'),
  School(sid:27113447, sname:'عمر بن الخطاب الأساسية المختلطة  27113447'),
  School(sid:27112189, sname:'ذكور الظاهرية الاساسية  27112189'),
  School(sid:27112039, sname:'ذكور الظاهرية الثانوية  27112039'),
  School(sid:27113446, sname:'عقبة بن نافع الأساسية المختلطة  27113446'),
  School(sid:27112262, sname:'البيرة الأساسية المختلطة  27112262'),
  School(sid:27113429, sname:'ذكور المدينه المنوره الأساسية  27113429'),
  School(sid:27112258, sname:'بنات شهداء الظاهرية الثانوية  27112258'),
  School(sid:27112051, sname:'ذكور كرزا الثانوية  27112051'),
  School(sid:27112275, sname:'خرسا الاساسية المختلطة  27112275'),
  School(sid:27112222, sname:'بنات بيت عوا الأساسية   27112222'),
  School(sid:27112065, sname:'مدرسة الطبقة الأساسية المختلطة  27112065'),
  School(sid:27112050, sname:'دير العسل التحتا الأساسية المختلطة  27112050'),
  School(sid:27113443, sname:'الأشرفية الأساسية المختلطة  27113443'),
  School(sid:27112060, sname:'ذكور المجد الثانوية  27112060'),
  School(sid:27113437, sname:'فدوى طوقان الأساسية المختلطة  27113437'),
  School(sid:27112248, sname:'بنات الحرمين الاساسية  27112248'),
  School(sid:27112062, sname:'ذكور الياسرية الثانوية  27112062'),
  School(sid:27112274, sname:'بنات خولة بنت الازور الاساسية  27112274'),
  School(sid:27113456, sname:'خلة حماد الأساسية المختلطة  27113456'),
  School(sid:27112036, sname:'دير رازح الأساسية المختلطة  27112036'),
  School(sid:27112251, sname:'بنات الضياء الأساسية  27112251'),
  School(sid:27112156, sname:'دير العسل الفوقا الثانوية المختلطة  27112156'),
  School(sid:27112063, sname:'سكة الاساسية المختلطة  27112063'),
  School(sid:27111030, sname:'بنات دورا الثانوية  27111030'),
  School(sid:27112253, sname:'عرب الفريجات الأساسية المختلطة  27112253'),
  School(sid:27111053, sname:'ذكور الرازي الاساسية  27111053'),
  School(sid:27111273, sname:'جبل طاروسة الاساسية المختلطة  27111273'),
  School(sid:27111283, sname:'ذكور طه الرجعي الأساسية  27111283'),
  School(sid:27112080, sname:'بنات اشبيلية الثانوية  27112080'),
  School(sid:27113432, sname:'ذكور السيميا الأساسية  27113432'),
  School(sid:27113468, sname:'ذكور الفالوجة الاساسية  27113468'),
  School(sid:27113457, sname:'واد دومة الأساسية المختلطة  27113457'),
  School(sid:27112038, sname:'ذكور الريحية الثانوية  27112038'),
  School(sid:27112250, sname:'خالد بن الوليد الأساسية المختلطة  27112250'),
  School(sid:27113288, sname:'ذكور معاذ بن جبل الأساسية  27113288'),
  School(sid:27112326, sname:'ذكور شهداء الفوار الثانوية  27112326'),
  School(sid:27112226, sname:'ذكور الكرامة الأساسية  27112226'),
  School(sid:27112049, sname:'السيميا الاساسية المختلطة  27112049'),
  School(sid:27113458, sname:'التحدي 13 السيميا الاساسية المختلطة  27113458'),
  School(sid:27113452, sname:'الشهيد موفق السلطي الاساسية المختلطة  27113452'),
  School(sid:27112180, sname:'ذكور جعفر بن أبي طالب الأساسية   27112180'),
  School(sid:27113287, sname:'يافا الاساسية المختلطة  27113287'),
  School(sid:27112115, sname:'بنات السموع الأساسية  27112115'),
  School(sid:27112077, sname:'بنات مؤتة الثانوية  27112077'),
  School(sid:27112078, sname:'بنات السموع الثانوية  27112078'),
  School(sid:27112192, sname:'ذكور البخاري الاساسية  27112192'),
  School(sid:27112042, sname:'ذكور السموع الثانوية  27112042'),
  School(sid:27112184, sname:'ذكور السموع الاساسية  27112184'),
  School(sid:27112225, sname:'بنات رافات الاساسية   27112225'),
  School(sid:27112114, sname:'بنات خليل الوزير الأساسية  27112114'),
  School(sid:27113464, sname:'واد علي الأساسية المختلطة  27113464'),
  School(sid:27113433, sname:'علي بن أبي طالب الأساسية المختلطة  27113433'),
  School(sid:27113439, sname:'الشهيد أبوعمار الأساسية المختلطة  27113439'),
  School(sid:27112210, sname:'بنات إذنا الأساسية  27112210'),
  School(sid:27112224, sname:'بنات تل الربيع الأساسية  27112224'),
  School(sid:27112178, sname:'بنات إذنا الثانوية  27112178'),
  School(sid:27112207, sname:'بنات حفصة بنت عمر الاساسية  27112207'),
  School(sid:27113448, sname:'خلة الغزال الاساسية المختلطة  27113448'),
  School(sid:27113440, sname:'ذكور إذنا الأساسية  27113440'),
  School(sid:27112037, sname:'ذكور إذنا الثانوية  27112037'),
  School(sid:27112218, sname:'ذكور العودة الاساسية  27112218'),
  School(sid:27112401, sname:'ذكور المجدل الأساسية  27112401'),
  School(sid:27112179, sname:'ذكور بني حارث الاساسية  27112179'),
  School(sid:27112025, sname:'ذكور محمود درويش الأساسية  27112025'),
  School(sid:27112320, sname:'عسقلان الأساسية المختلطة   27112320'),
  School(sid:27113471, sname:'ذكور جمال علي الاساسية  27113471'),
  School(sid:27113423, sname:'الرافدين الأساسية المختلطة  27113423'),
  School(sid:27112265, sname:'شويكة الأساسية المختلطة  27112265'),
  School(sid:27113455, sname:'بادية الرماضين الاساسية المختلطة  27113455'),
  School(sid:27112009, sname:'بنات الاندلس الاساسية  27112009'),
  School(sid:27113431, sname:'بنات الرماضين الثانوية  27113431'),
  School(sid:27112007, sname:'بنات الظاهرية الاساسية  27112007'),
  School(sid:27112081, sname:'بنات الظاهرية الثانوية   27112081'),
  School(sid:27112006, sname:'بنات عائشة الاساسية  27112006'),
  School(sid:27112040, sname:'ذكور ابو عبيدة الاساسية  27112040'),
  School(sid:27113451, sname:'ذكور ابو نجيم الاساسية   27113451'),
  School(sid:27112239, sname:'ذكور الرماضين الثانوية  27112239'),
  School(sid:27112190, sname:'ذكور الغزالي الاساسية  27112190'),
  School(sid:27112035, sname:'ذكور دوما الاساسية  27112035'),
  School(sid:27112045, sname:'ذكور الفاروق الأساسية  27112045'),
  School(sid:27112066, sname:'ذكور عناب الصغيرة الاساسية  27112066'),
  School(sid:27112186, sname:'ذكور عثمان بن عفان الأساسية   27112186'),
  School(sid:27112287, sname:'واد السلطان الأساسية المختلطة  27112287'),
  School(sid:27113454, sname:'زنوتا الاساسية المختلطة  27113454'),
  School(sid:27113286, sname:'زهرة المدائن الأساسية المختلطة  27113286'),
  School(sid:27112034, sname:'أبو العرقان الاساسية المختلطة  27112034'),
  School(sid:27112252, sname:'ابو العسجا الاساسية المختلطة  27112252'),
  School(sid:27112242, sname:'البيادر الأساسية المختلطة  27112242'),
  School(sid:27112403, sname:'الصره الاساسية المختلطه  27112403'),
  School(sid:27112032, sname:'ذكور الصرة الثانوية  27112032'),
  School(sid:27112286, sname:'بنات امريش الثانوية  27112286'),
  School(sid:27112185, sname:'بنات كرزا الثانوية  27112185'),
  School(sid:27112277, sname:'بنات كرمة الثانوية  27112277'),
  School(sid:27113450, sname:'خلة العقد الاساسية المختلطة  27113450'),
  School(sid:27112033, sname:'ذكور كرمة الثانوية  27112033'),
  School(sid:27112188, sname:'رابود الثانوية المختلطة   27112188'),
  School(sid:27113295, sname:'دلال المغربي الاساسية المختلطة  27113295'),
  School(sid:27113442, sname:'الرحمة الأساسية المختلطة  27113442'),
  School(sid:27113453, sname:'الدير الاساسية المختلطة  27113453'),
  School(sid:27112255, sname:'الكوم الأساسية المختلطة  27112255'),
  School(sid:27111241, sname:'القادسية الاساسية المختلطة  27111241'),
  School(sid:27111256, sname:'القدس الأساسية المختلطة  27111256'),
  School(sid:27111260, sname:'بنات الاقصى الاساسية  27111260'),
  School(sid:27111106, sname:'بنات دار السلام الثانوية  27111106'),
  School(sid:27113444, sname:'بنات دار السلام الأساسية  27113444'),
  School(sid:27113282, sname:'بنات الفوار الثانوية   27113282'),
  School(sid:27112116, sname:'بنات خرسا الثانويه  27112116'),
  School(sid:27111221, sname:'فلسطين الأساسية المختلطة  27111221'),
  School(sid:27112183, sname:'بنات كريسة الثانوية   27112183'),
  School(sid:27112270, sname:'كريسة الاساسية المختلطة  27112270'),
  School(sid:27113449, sname:'كنار الاساسية المختلطة  27113449'),
  School(sid:27112153, sname:'زيد بن حارثة الأساسية المختلطة  27112153'),
  School(sid:27113459, sname:'ذكور إبراهيم طوقان الأساسية  27113459'),
  School(sid:27112280, sname:'بنات الزهراء الاساسية  27112280'),
  School(sid:27113436, sname:'الهجرة الأساسية المختلطه  27113436'),
  School(sid:27113469, sname:'ذكور كفر قاسم الأساسية  27113469'),
  School(sid:27113289, sname:'لقمان الحكيم الاساسية المختلطة  27113289'),
  School(sid:27112047, sname:'ذكور بيت الروش الثانوية  27112047'),
  School(sid:27112046, sname:'ذكور البرج الثانوية   27112046'),
  School(sid:27111271, sname:'ذكور دورا الثانوية المهنية  27111271'),
  School(sid:27113438, sname:'عين فارس الأساسية المختلطة  27113438'),
  School(sid:27112269, sname:'المجد الأساسية المختلطة  27112269'),
  School(sid:27112264, sname:'بنات الريحية الاساسية  27112264'),
  School(sid:27112082, sname:'بنات الريحية الثانوية   27112082'),
  School(sid:27112044, sname:'بيت مرسم الأساسية المختلطة  27112044'),
  School(sid:27112187, sname:'ذكور الشهيد أبو جهاد الثانوية  27112187'),
  School(sid:27112261, sname:'بيت الروش التحتا الاساسية المختلطة  27112261'),
  School(sid:27112043, sname:'بنات بيت عوا الثانوية  27112043'),
  School(sid:27113441, sname:'ذكور بيت عوا الأساسية  27113441'),
  School(sid:27112093, sname:'ذكور دير سامت الأساسية  27112093'),
  School(sid:27113285, sname:'الوحده الاساسيه المختلطه  27113285'),
  School(sid:27112041, sname:'ذكور دير سامت الثانوية  27112041'),
  School(sid:27112182, sname:'بنات الشهيد عبد العزيز الرجوب الثانوية   27112182'),
  School(sid:27112079, sname:'دير سامت الأساسية المختلطة  27112079'),
  School(sid:27113466, sname:'ذكور عيلبون الأساسية  27113466'),
  School(sid:27112259, sname:'بنات بيت الروش الثانوية  27112259'),
  School(sid:27112322, sname:'بنات بيسان الاساسية  27112322'),
 School(sid:27112064, sname:'ذكور بيت عوا الثانوية  27112064'),
 School(sid:27112237, sname:'شهداء السموع الأساسية المختلطة  27112237'),
 School(sid:27113435, sname:'غوين الأساسية المختلطة  27113435'),
 School(sid:27112206, sname:'بنات دير سامت الثانوية  27112206'),
 School(sid:27113463, sname:'ذكور دير العسل الفوقا الثانوية  27113463'),
 School(sid:27113421, sname:'عكا الأساسية المختلطه  27113421'),
 School(sid:27113465, sname:'ذكور الصخرة الأساسية  27113465'),
 School(sid:27113477, sname:'زكي خلاوي الاساسية المختلطة  27113477'),
 School(sid:27113479, sname:'ذكور الخنساء الاساسية  27113479'),
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
