# UI prototype

Use when the question is "what should this look like?". The artifact is a route that renders three, at most five, radically different variants behind `?variant=`.

## Variants

Structurally different, not colour or copy differences. Generate them against real data and the real component library, with clear `VariantA`, `VariantB`, `VariantC` exports. Keep the layout shared only when the layout is not the question.

## Sub-shapes

- Preferred, adjust an existing page. Keep its data, params, and auth, and swap only the rendering. Mount inside the host page if the thing would naturally live there.
- Last resort, add a throwaway route named `prototype` following existing routing conventions.

## Switcher

Wire one switcher and a floating bottom-centre bar. Left and right arrows wrap, the bar shows the variant label, `←` and `→` keys work except inside inputs and contenteditable, and the bar is visually distinct from the page and hidden in production.

## Rules and capture

No real mutations and no direct promotion to production. Hand over the URL, capture the winning variant, fold it in, and move the full variant set to a throwaway branch.
