# Smell baseline

Fowler's smells (_Refactoring_, ch. 3), used as a heuristic during the Standards axis of **accept-change**. Two binding rules. The repo's documented standard overrides the baseline. Every entry is a judgement call, so label it a possible instance, never a hard violation, and skip anything a tool already enforces.

| Smell | What it is | Fix direction |
|---|---|---|
| Mysterious Name | A name that hides what it does or holds | Rename to say the intent |
| Duplicated Code | The same shape in more than one place | Extract the shared shape |
| Feature Envy | A method more interested in another object's data | Move the method to the data |
| Data Clumps | The same group of fields travels together | Introduce the missing type |
| Primitive Obsession | A primitive standing in for a concept | Brand or model the concept |
| Repeated Switches | The same switch on the same type recurs | Polymorphism or one dispatch table |
| Shotgun Surgery | One change forces many scattered edits | Gather the responsibility |
| Divergent Change | One module changes for unrelated reasons | Split by reason to change |
| Speculative Generality | Hooks and abstraction nobody uses | Delete until needed |
| Message Chains | `a.b().c().d()` navigation | Hide the walk behind one call |
| Middle Man | A class that only forwards | Remove it, call the target |
| Refused Bequest | A subclass that ignores its parent | Composition over inheritance |
