# Deepening

Deepening a cluster of code depends on what sits behind the seam. Categorise each dependency first, since the category decides how it is tested.

1. **In-process**: pure computation or in-memory, no I/O. Always deepenable, no adapter.
2. **Local-substitutable**: a local stand-in exists, such as PGLite for Postgres or an in-memory filesystem. The seam is internal, no port at the external interface.
3. **Remote but owned**: your services across a network. Define a **port** at the seam and inject the transport as an **adapter**. Tests use an in-memory adapter, production uses HTTP, gRPC, or a queue.
4. **True external**: a third party such as Stripe. Inject a port and use a mock adapter.

Seam discipline: do not introduce a port unless two adapters are justified, and do not expose an internal seam through the public interface just because tests use it.

Testing strategy, replace rather than layer. Once interface tests exist, delete the old shallow-module unit tests, write new tests at the deepened interface, assert observable outcomes rather than internal state, and keep tests that survive internal refactors.
