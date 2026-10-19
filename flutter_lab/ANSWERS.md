
Name: Ahmed Hassaan
Roll no: 04072313022

A1: 7
A2: 10
A3: 9
A4: 20

**B1: which of your classes are Stateless and which are Stateful, and why**

Stateless are LabApp, HomePage, StudentCard and GoalBanner, because they only show the data they get and it never change. Stateful are Tally, Countdown and BuggyCounter, because their data (_count, _left, _builds, _clicks) change while app is running.

**B2: why must the Timer be cancelled in dispose()**

Timer keep running even after the widget is removed. If we not cancel it in dispose, it call setState on a State that is already gone and give error "setState() called after dispose()", and it also waste memory.

**B3: which widgets in your code can be const, and what const buys you**

const MaterialApp in LabApp, const Tally(), const Countdown(), const BuggyCounter(), const SizedBox, const EdgeInsets, const Key and const Text('Reset'). const widget is made one time at compile time, so Flutter reuse it and not build it again, app become faster.
