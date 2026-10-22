#!/usr/bin/env python3
"""Validate the shared AI model policy."""

from __future__ import annotations

import json
import argparse
import os
import re
from pathlib import Path


ROLE_NAMES = {"exploration", "implementation", "judgment", "prose"}
TOP_LEVEL_NAMES = {"default", "roles"}

_HEADERS_NAME = re.compile(r"^[A-Za-z0-9-]+$")
_PROVIDER_KEY = re.compile(r"^[a-z][a-z_0-9]*$")


def config_dir() -> Path:
    value = os.environ.get("XDG_CONFIG_HOME")
    return Path(value) if value else Path.home() / ".config"


def _is_model(value: object) -> bool:
    return isinstance(value, str) and bool(value.strip())


def _is_provider_options(value: object) -> bool:
    if not isinstance(value, dict) or not value:
        return False
    return all(
        isinstance(key, str) and _PROVIDER_KEY.match(key) for key in value
    )


def _is_headers(value: object) -> bool:
    if not isinstance(value, dict):
        return False
    return all(
        isinstance(key, str)
        and _HEADERS_NAME.match(key)
        and isinstance(item, str)
        for key, item in value.items()
    )


def _is_pinned_model(value: object) -> bool:
    if not isinstance(value, dict) or "model" not in value:
        return False
    if set(value) - {"model", "provider", "headers"}:
        return False
    if not _is_model(value["model"]):
        return False
    if "provider" in value and not _is_provider_options(value["provider"]):
        return False
    if "headers" in value and not _is_headers(value["headers"]):
        return False
    return True


def _is_single(value: object) -> bool:
    return _is_model(value) or _is_pinned_model(value)


def _model_id(value: object) -> str:
    return value["model"] if isinstance(value, dict) else value


def _is_role_value(value: object) -> bool:
    if _is_single(value):
        return True
    if not isinstance(value, list) or not value or not all(_is_single(i) for i in value):
        return False
    ids = [_model_id(i) for i in value]
    return len(set(ids)) == len(ids)


def load_policy(path: Path) -> dict[str, object]:
    try:
        value = json.loads(path.read_text())
    except (OSError, json.JSONDecodeError) as error:
        raise SystemExit(f"invalid policy {path}: {error}") from error

    if not isinstance(value, dict):
        raise SystemExit("policy must be a JSON object")
    if set(value) != TOP_LEVEL_NAMES:
        raise SystemExit(f"policy keys must be {sorted(TOP_LEVEL_NAMES)}")
    if not _is_model(value["default"]):
        raise SystemExit("default must be a non-empty string")

    roles = value["roles"]
    if not isinstance(roles, dict) or set(roles) != ROLE_NAMES:
        raise SystemExit(f"role keys must be {sorted(ROLE_NAMES)}")
    for role, role_value in roles.items():
        if not _is_role_value(role_value):
            raise SystemExit(
                f"role {role} must be inherit, a model string, a pinned model object, or a flat pool of distinct models"
            )

    return value


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "policy",
        nargs="?",
        type=Path,
        default=config_dir() / "ai/model-policy.json",
    )
    args = parser.parse_args()
    load_policy(args.policy)
    print("valid AI model policy")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
