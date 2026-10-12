
Name: Ahmed Hassaan
Roll no: 04072313022

**Q1. What can a subclass using extends use for free that a class using implements has to write itself?**
With extends, child class get all field and method from parent free. Like describe() method come already. With implements, only shape come. We must write all method body by our self.

**Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?**

Mixin use when same code need in some class but they not same family. Like Book and Dvd use it, but Magazine not use it.
Abstract parent use when all child class same kind thing and have same base. Like every LibraryItem have title and year.

**Q3. Why must you override hashCode whenever you override ==?**

Because Set and Map first check hashCode then ==. If two object equal but hashCode different, Set think they different and keep both.

**Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?**

String is built in final class, so we not can extend it. Extension not change class. It only add method from outside, so it allow.
