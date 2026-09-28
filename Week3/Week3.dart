// Week3.dart - Library Desk Assistant
// Name: Ahmed Hassaan     Roll no: 04072313022

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming']
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile']
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design']
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math']
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile']
  },
];

// Part 1
// 1.1
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

// 1.2
String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }
  return '$title by $author';
}

// 1.3
Map<String, dynamic> makeBook(
    {required String title,
    required String author,
    int year = 2024,
    int copies = 1}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

// 1.4
bool isClassic(int year) => year < 2000;

// Part 2
// 2.1
List<String> transformAll(List<String> items, String Function(String) fn) {
  List<String> result = [];
  for (var item in items) {
    result.add(fn(item));
  }
  return result;
}

// 2.2
int count = 0;

int Function() makeCounter() {
  return () {
    count++;
    return count;
  };
}

// 2.3
double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

// 2.4
int sumDigits(int n) {
  if (n < 10) {
    return n;
  }
  return n % 10 + sumDigits(n ~/ 10);
}

// Part 3
// 3.4
Map<String, int> buildStock() {
  return {for (var b in books) b['title'] as String: b['copies'] as int};
}

// Part 4
// 4.1
class Box<T> {
  T value;
  Box(this.value);
}

// 4.2
T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }
  return items.first;
}

// 4.3
class Pair<A, B> {
  A first;
  B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

// Part 5
// 5.1
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

// 5.2
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

// 5.4
Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

// Part 6
// 6.1
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

// 6.3
Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');
  // 1.1
  print('Late fee: ${lateFee(5, 0.5)}');
  // 1.2
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  // 1.3
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  // 1.4
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  // 2.1
  var names = ['Dart in Action', 'Clean Code'];
  print(transformAll(names, (String s) {
    return s.toUpperCase();
  }));
  print(transformAll(names, (s) => '$s!'));

  // 2.2
  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  // 2.3
  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  // 2.4
  print('Sum of digits: ${sumDigits(2024)}');
}

void part3() {
  print('--- Part 3 ---');
  // 3.1
  var titles = books.map((b) => b['title'] as String).toList();
  print('Titles: $titles');

  var available =
      books.where((b) => (b['copies'] as int) > 0).map((b) => b['title']);
  print('Available: $available');

  // 3.2
  int totalCopies = books.fold(0, (sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');

  int oldest =
      books.map((b) => b['year'] as int).reduce((a, b) => a < b ? a : b);
  print('Oldest year: $oldest');

  // 3.3
  var sortedBooks = [...books];
  sortedBooks.sort((x, y) => (x['year'] as int).compareTo(y['year'] as int));
  print('By year: ${sortedBooks.map((b) => b['title']).toList()}');

  // 3.4
  var stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });
  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  // 3.5
  Set<String> allTags = {
    for (var b in books) ...(b['tags'] as List<String>)
  };
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');
  // 4.1
  var intBox = Box<int>(5);
  var strBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${strBox.value}');
  // intBox.value = 'hello';

  // 4.2
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));
  // 4.3
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');
  // 5.3
  var stock = buildStock();
  for (var title in ['Dart in Action', 'Flutter Basics', 'Unknown Book']) {
    try {
      print('Checked out: $title');
      checkOut(stock, title);
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } finally {
      print('Transaction logged.');
    }
  }
  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  // 5.4
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');
  // 6.1
  print('Fetching...');
  String book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  // 6.3
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// Reflection
// 1. Fold use when we want start value or list maybe
//    empty,  Reduce crash if list empty.
// 2. Capturing mean inside function remember outside variable, even after outside finish. In makeCounter, count was captured.
   
// 3. Catch (e) catch everything. If it come first, then specific on clause never run.
   
