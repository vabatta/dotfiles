#!/usr/bin/env node
// Validate Mermaid diagrams with the REAL Mermaid parser (mermaid.parse).
//
// Contract (predictable, scriptable):
//   * Reads a diagram from STDIN, or from file path(s) given as arguments.
//   * Accepts raw Mermaid source, or Markdown containing ```mermaid fences
//     (every fenced block is validated; a bare diagram is one block).
//   * On success: prints NOTHING to stdout and exits 0.
//   * On failure: prints the parser's error(s) to stderr and exits 1.
//
// This is the actual Mermaid grammar — the same parser the renderer uses —
// run headless via a jsdom DOM. It catches every syntax error Mermaid itself
// would reject, with line numbers, across all diagram types.

import { JSDOM } from "jsdom";

// Mermaid expects a browser-like global environment even when only parsing.
const dom = new JSDOM("<!DOCTYPE html><body></body>", { pretendToBeVisual: true });
globalThis.window = dom.window;
globalThis.document = dom.window.document;

const mermaid = (await import("mermaid")).default;
mermaid.initialize({ startOnLoad: false, securityLevel: "loose" });

const FENCE = /^[ \t]*```+[ \t]*mermaid[ \t]*\r?\n([\s\S]*?)^[ \t]*```+[ \t]*$/gim;

function extractBlocks(text) {
  const blocks = [];
  let m;
  FENCE.lastIndex = 0;
  let i = 0;
  while ((m = FENCE.exec(text)) !== null) {
    i += 1;
    blocks.push({ label: `mermaid block ${i}`, source: m[1] });
  }
  if (blocks.length === 0) return [{ label: "diagram", source: text }];
  return blocks;
}

function readStdin() {
  return new Promise((resolve) => {
    let data = "";
    process.stdin.setEncoding("utf8");
    process.stdin.on("data", (chunk) => (data += chunk));
    process.stdin.on("end", () => resolve(data));
  });
}

async function main() {
  const fs = await import("node:fs/promises");
  const args = process.argv.slice(2);

  let sources;
  if (args.length > 0) {
    sources = [];
    for (const path of args) {
      try {
        sources.push({ origin: path, text: await fs.readFile(path, "utf8") });
      } catch (err) {
        process.stderr.write(`cannot read ${path}: ${err.message}\n`);
        process.exit(1);
      }
    }
  } else {
    sources = [{ origin: "<stdin>", text: await readStdin() }];
  }

  let hadErrors = false;
  for (const { origin, text } of sources) {
    for (const { label, source } of extractBlocks(text)) {
      const where = origin === "<stdin>" ? label : `${origin} (${label})`;
      if (source.trim() === "") {
        hadErrors = true;
        process.stderr.write(`${where}: empty diagram — no content found\n`);
        continue;
      }
      try {
        await mermaid.parse(source);
      } catch (err) {
        hadErrors = true;
        const msg = (err && (err.message || err.str)) || String(err);
        process.stderr.write(`${where}: ${msg}\n`);
      }
    }
  }

  process.exit(hadErrors ? 1 : 0);
}

main();
