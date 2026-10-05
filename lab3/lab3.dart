// lab3.dart - Campus Cafe Order System
// Name: Ahmed Hassaan     Roll no: 04072313022

const String rollNo = '04072313022';
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; 
final int u = seed % 10; 

const List<String> menu = [
  'Chai', 'Latte', 'Mocha', 'Samosa', 'Brownie',
  'Sandwich', 'Cold Coffee', 'Fries', 'Pakora', 'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; 
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;

// Step 1
class Dish {
  late String name;
  late int price;
}

// Step 2, 3
class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  MenuItem.free(this.name) : price = 0;

  MenuItem.fromString(String text)
      : name = text.split(':')[0],
        price = int.parse(text.split(':')[1]);

}
// Think 2: If price final, we cannot change value after.
// Final can set only one time before body run.

// Think 3: free() is another constructor. It not run main constructor body.
 // Floor check never happen there. free() skip floor check.

// Step 4
class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    _instance ??= OrderLog._internal();
    return _instance!;
  }

  void add(String msg) => entries.add(msg);
}
// Think 4:Underscore make it private.Outside code cannot call OrderLog._internal().
// So nobody can make second log object. 
// If not private, anyone make new object. 
// Then singleton break.


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
  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  var item2 = Dish();
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
  item2.price = item2.price - u;
}

void step2() {
  print('--- Step 2 ---');
  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);
  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
}

void step3() {
  print('--- Step 3 ---');
  var freebie = MenuItem.free('Water');
  int i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

void step4() {
  print('--- Step 4 ---');
  var log1 = OrderLog();
  var log2 = OrderLog();
  for (var i = 1; i <= u + 2; i++) {
    String msg = 'order #${100 * t + i}';
    if (i % 2 == 1) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }
  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

void step5() { print('--- Step 5 ---'); }
void step6() { print('--- Step 6 ---'); }
void step7() { print('--- Step 7 ---'); }
void step8() { print('--- Step 8 ---'); }
void step9() { print('--- Step 9 ---'); }
void step10() { print('--- Step 10 ---'); }
