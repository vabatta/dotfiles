# Good and bad tests

A good test verifies behaviour through a public interface. The code can change entirely and the test should not. It reads like a specification, for example "user can check out with a valid cart", and it survives refactors. Use one logical assertion.

Bad tests fall into two families.

- **Implementation-coupled**: mocks internal collaborators, tests private methods, or verifies through a side channel such as querying the database instead of calling the interface. Tell: it breaks on a refactor that changes no behaviour.
- **Tautological**: the assertion recomputes the expected value the way the code does, so it passes by construction. Expected values must come from an independent source of truth, a known-good literal, a worked example, or the spec.
