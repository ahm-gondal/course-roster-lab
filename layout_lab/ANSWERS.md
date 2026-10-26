Name: Ahmed Hassaan
Roll no: 04072313022

A1: 33
A2: 7
A3: 4
A4: 75

**B1: which of your classes are Stateless and which are Stateful, and why**

Stateless are LabApp, HomePage, SettingsCard, Probe, Welcome, InfoPanel, SummaryRow, ShareRow, InfoBox and StampStack, because they only show what they get and nothing change inside them. Stateful are Clock, Tile and SwapBoard, because their data change while app run (_seconds and _builds in Clock, taps in Tile, order of tiles in SwapBoard).

**B2: Widget, Element, RenderObject: which one is rebuilt on every setState and which ones are kept? What did Probe show you?**

Widget is rebuilt on every setState, it is cheap and thrown away. Element and RenderObject are kept, Element keep the State and RenderObject do layout and paint. Probe show the Widget # number change every second but the Element # number stay same, so the Element is kept and only widget is new.

**B3: explain "constraints go down, sizes go up" using your Step 7 or Step 8 example**

In Step 7 the Row give its Text unlimited width (constraint go down), so Text pick one long line and overflow. After Expanded, Row give each Text one third of width as max constraint, the Text wrap its words to fit and tell its height back to the Row (size go up), then Row place them side by side.
