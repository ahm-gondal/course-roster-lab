void printWelcome(String appName) {
  print('=== $appName ===');
}
String generateCode(String title) =>
    title.substring(0, 2).toUpperCase() + '101';

void main() {
  printWelcome('Course Roster Manager');

  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();
  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Khaleel', 'Mushtaq', 'Zaheer'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Khaleel': 3, 'Mushtaq': 4, 'Zaheer': 2};

  print(
      '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}');

  String? instructorEmail;
  print(instructorEmail ?? 'TBA');

  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);
  print('Enrollment code: $enrollmentCode');

  print('Instructor email length: ${instructorEmail?.length ?? 0}');

  String rawNames = ' Khaleel , mushtaq ,ZAHEER , Priya ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }

  String description = '''
Course: $courseTitle
Credit Hours: $creditHours
Created At: $createdAt
''';
  print(description);

  print('Seats left: ${capacity - enrolledStudents.length}');

  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 2;
  print('Full groups of 3: $fullGroups, leftover: $leftover');

  Object formInput = 'twenty-two';
  if (formInput is String) {
    print('This is text!');
  }
  if (formInput is! int) {
    print('This is not a number.');
  }

  var report = StringBuffer();
  report
    ..write('Report: $courseTitle')
    ..write(' | Cap: $capacity')
    ..write(' | Roster: ${enrolledStudents.length}');
  print(report.toString());

  List<String>? extraNotes;
  extraNotes?..add('Room change pending');
  print('Extra notes: $extraNotes');

  int? bonusSeats = 2;
  bonusSeats ??= 0;
  print('Bonus seats: $bonusSeats');

  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Sorry, the course is closed or full.');
  }

  int enrollmentStatusCode = 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((key, value) {
    print('$key: $value');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist) 'Reminder: $student, please confirm attendance',
  ];

  for (var note in announcements) {
    print(note);
  }
}
