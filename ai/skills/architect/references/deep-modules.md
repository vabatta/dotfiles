# Deep modules

Shared vocabulary for designing modules. Use these terms exactly and do not substitute "component", "service", "API", or "boundary".

- **Module**: anything with an interface and an implementation, at any scale, a function, class, package, or tier-spanning slice.
- **Interface**: everything a caller must know, the type signature plus invariants, ordering constraints, error modes, required configuration, and performance characteristics.
- **Implementation**: the body inside a module.
- **Depth**: behaviour per unit of interface learned. A **deep** module hides a large behaviour behind a small interface. A **shallow** module has an interface nearly as complex as its implementation.
- **Seam**: a place to alter behaviour without editing there, the location where an interface lives.
- **Adapter**: the concrete thing satisfying an interface at a seam. One adapter means a hypothetical seam, two adapters mean a real one.
- **Leverage**: what callers get from depth, one implementation paying back across many call sites and tests.
- **Locality**: what maintainers get, change and bugs and knowledge concentrated in one place.

## Tests

- **Deletion test**: delete the module. If the complexity vanishes it was a pass-through; if it reappears across the callers it was earning its keep.
- The interface is the test surface. Accept dependencies rather than creating them, return results rather than producing side effects, and keep the surface small.
- A module may have internal seams private to its implementation for its own tests, separate from the external seam.
