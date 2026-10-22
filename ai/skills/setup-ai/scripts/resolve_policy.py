#!/usr/bin/env python3
"""Resolve the effective AI model policy for the current session.

Lookup order:
1. `.ai/model-policy.json` in the project root, found by walking up from the
   current directory to the git worktree boundary. The file is committed repo
   state, shared with the team.
2. The runtime policy at `$XDG_CONFIG_HOME/ai/model-policy.json`, or
   `~/.config/ai/model-policy.json` when `XDG_CONFIG_HOME` is unset. Personal
   and runtime-owned.
3. The skill's `templates/model-policy.json` bootstrap, so resolution never
   fails on a fresh machine.

The resolved policy is validated with the same schema as `verify_policy.py`.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from pathlib import Path

sys.dont_write_bytecode = True

from verify_policy import load_policy


ROLE_NAMES = ("exploration", "implementation", "judgment", "prose")

POLICY_NAME = "model-policy.json"


def config_dir() -> Path:
    value = os.environ.get("XDG_CONFIG_HOME")
    return Path(value) if value else Path.home() / ".config"


def global_policy_path() -> Path:
    return config_dir() / "ai" / POLICY_NAME


def template_path() -> Path:
    return Path(__file__).parent.parent / "templates" / POLICY_NAME


def project_root() -> Path | None:
    try:
        top = subprocess.run(
            ["git", "rev-parse", "--show-toplevel"],
            capture_output=True,
            text=True,
            check=True,
        ).stdout.strip()
    except (OSError, subprocess.CalledProcessError):
        return None
    return Path(top) if top else None


def project_policy_path() -> Path | None:
    root = project_root()
    if root is None:
        return None
    candidate = root / ".ai" / POLICY_NAME
    return candidate if candidate.is_file() else None


def first_model(value: object) -> str:
    """Model id of a role value: a string, a pinned object, or a pool's first entry."""
    if isinstance(value, list):
        return first_model(value[0])
    if isinstance(value, dict):
        return value["model"]
    return value


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--role",
        choices=ROLE_NAMES,
        help="print only this role's value",
    )
    parser.add_argument(
        "--source",
        action="store_true",
        help="print which file the policy resolved from",
    )
    parser.add_argument(
        "--policy",
        type=Path,
        help="resolve this file directly, skipping the lookup order",
    )
    args = parser.parse_args()

    if args.policy is not None:
        paths = [args.policy]
    else:
        candidates = (project_policy_path(), global_policy_path(), template_path())
        paths = [p for p in candidates if p is not None and p.is_file()]
        if not paths:
            raise SystemExit("no policy found: no project policy, no runtime policy, no template")

    source = paths[0]
    if not source.is_file():
        raise SystemExit(f"missing policy {source}")
    policy = load_policy(source)

    if args.source:
        print(source)
        return 0

    if args.role:
        value = policy["roles"][args.role]
        print(first_model(value))
        return 0

    print(json.dumps(policy, sort_keys=True, separators=(",", ":")))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
