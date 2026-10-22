# Mocking

Mock at system boundaries only: external APIs, databases (prefer a real test database), time and randomness, and sometimes the filesystem. Never mock your own classes, internal collaborators, or anything you control.

Design for mockability:

1. **Dependency injection**: pass external dependencies in rather than creating them inside.
2. **SDK-style interfaces**: one specific function per external operation, so each mock returns one shape, holds no conditional logic, and makes clear which endpoints a test exercises.
