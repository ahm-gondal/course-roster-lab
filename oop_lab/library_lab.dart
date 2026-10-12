// library_lab.dart  -  Campus Library System
// Name: Ahmed Hassaan   Roll no: 04072313022

const String rollNo = '04072313022';   // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;   // tens digit
final int u = seed % 10;    // units digit

const List<String> titles = [
  'Dart Basics', 'Flutter In Action', 'Data Structures', 'Operating Systems',
  'Mobile Design', 'Clean Code', 'Algorithms Unlocked', 'Computer Networks',
  'Database Systems', 'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;      // publication year of titles[i]
final int feePerDay = 5 + t;                // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6;       // normal number of days late
final int daysBig = 10 + u;                 // a long overdue period
final int feeCap = 150 + 10 * t;            // no single fee may exceed this
final int renewLimit = 1 + t % 3;           // renewals allowed per item
final int renewAttempts = 2 + u;            // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4;            // items on the shelf in Steps 9-10
// ===========================================================================

// Step 1, 2, 3
abstract class LibraryItem {
  static int created = 0;

  final String title;
  final int year;

  LibraryItem(this.title, this.year) {
    created++;
  }

  static int capFee(int fee) {
    if (fee > feeCap) {
      return feeCap;
    }
    return fee;
  }

  String describe() => '$title ($year)';

  int lateFee(int days);
}

// Step 4
abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

// Step 5
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }
    renewals++;
    return true;
  }
}

class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

// Step 2
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '$title, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

// Step 3
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);
 @override
  String describe() => '${super.describe()}, $minutes min';
 @override
  int lateFee(int days) => days * feePerDay * 2;
}
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}
Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}
Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

// Think 1: item type is LibraryItem so compiler only see title and year.
// pages is only in Book, compiler dont know item is Book so error come.

// Think 2: Without @override and name descibe() it become new method.
// describe() of parent run so pages not print, no error show.

// Think 3: Abstract class is not complete, lateFee() has no body.
// So Dart dont allow object of it, only subclasse fill the body.

// Step 6
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;
  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - fee * discountPercent ~/ 100;
}

// Step 7
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) => fold(0, (sum, i) => sum + i.lateFee(days));
}

// Step 8
class Fine {
  final int amount;
  const Fine(this.amount);

  Fine operator +(Fine o) => Fine(amount + o.amount);

  bool operator >(Fine o) => amount > o.amount;

  @override
  bool operator ==(Object other) => other is Fine && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

// Step 9
List<LibraryItem> buildShelf() {
  List<LibraryItem> shelf = [];
  for (var k = 0; k < shelfSize; k++) {
    int i = (u + k) % 10;
    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }
  return shelf;
}

// Step 10
class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    int fee = item.lateFee(days);
    fee = LibraryItem.capFee(fee);
    fee = type.applyDiscount(fee);
    return Fine(fee);
  }
}

// Think 4: extends Borrowable give nothing really because it has no body,
// and Book already extends LibraryItem, Dart allow only one extends.
// implements is just promise, we write own code.

// Think 5: If renew is in LibraryItem then Magazine also get it but it
// should not. Mixin only add it to Book and Dvd which we want.

// Think 6: string 'student' can be typed wrong like 'studnet' and no error.
// Enum is checked by compiler so mistake caught early.

// Think 7: 72.rs read like normal english and IDE show it after dot,
// it look like int have this method already.

// Think 8: Without hashCode set size become 3 because two equal Fine have
// different hash, set put them in different place. == and hashCode must agree.

// Think 9: static belong to class not object, so we use class name
// LibraryItem.created, no object needed.

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  var b = mainBook();
  LibraryItem item = b;
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
}
void step3() {
  print('--- Step 3 ---');
  print('Step 3: Book late fee for $daysLate days = ${mainBook().lateFee(daysLate)}');
  print('Step 3: Magazine late fee for $daysLate days = ${mainMagazine().lateFee(daysLate)}');
  print('Step 3: Dvd late fee for $daysLate days = ${mainDvd().lateFee(daysLate)}');
}
void step4() {
  print('--- Step 4 ---');
  var book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (var item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }
}
void step5() {
  print('--- Step 5 ---');
  var book = mainBook();
  int ok = 0;
  for (var i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }
  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');
}
void step6() {
  print('--- Step 6 ---');
  var type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');
}
void step7() {
  print('--- Step 7 ---');
  var type = MemberType.values[seed % 3];
  int discounted = type.applyDiscount(mainBook().lateFee(daysLate));
  List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];
  print('Step 7: ${discounted.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print('Step 7: shelf fee for $daysLate days = ${shelf.totalLateFee(daysLate).rs}');
}
void step8() {
  print('--- Step 8 ---');
  var f1 = Fine(mainBook().lateFee(daysLate));
  var f2 = Fine(mainMagazine().lateFee(daysLate));
  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');
}
void step9() {
  print('--- Step 9 ---');
  buildShelf();
  var shelf = buildShelf();
  print('Step 9: items created = ${LibraryItem.created}');
  print('Step 9: capped fee = ${LibraryItem.capFee(shelf.first.lateFee(daysBig))} (cap $feeCap)');
  print('Step 9: const copies identical? ${identical(const Fine(10), const Fine(10))}');
  print('Step 9: new copies identical? ${identical(Fine(10), Fine(10))}');
}
void step10() {
  print('--- Step 10 ---');
  var shelf = buildShelf();
  var member = Member('S$seed', MemberType.values[seed % 3]);
  Fine total = shelf.fold(Fine(0), (sum, item) => sum + member.feeFor(item, daysLate));
  int b = 0;
  int r = 0;
  for (var item in shelf) {
    if (item is Borrowable) {
      b++;
    }
    if (item is Renewable) {
      r++;
    }
  }
  print('Step 10: ${shelf.length} items, $b borrowable, $r renewable');
  print('Step 10: ${member.name} (${member.type.name}) owes $total');
  print('Step 10: over the cap? ${total > Fine(feeCap)}');
}
