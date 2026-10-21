#!/usr/bin/env python3
"""Generate stable JSON from a model-policy template."""

from __future__ import annotations

import json
import argparse
import os
import sys
from pathlib import Path

sys.dont_write_bytecode = True

from verify_policy import load_policy


def config_dir() -> Path:
    value = os.environ.get("XDG_CONFIG_HOME")
    return Path(value) if value else Path.home() / ".config"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--template",
        type=Path,
        default=Path(__file__).parent.parent / "templates/model-policy.json",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=config_dir() / "ai/model-policy.json",
    )
    args = parser.parse_args()

    policy = load_policy(args.template)
    output = json.dumps(policy, sort_keys=True, separators=(",", ":")) + "\n"
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(output)
    print(args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
