#!/usr/bin/env zsh

# Internal: Resolve a single file or directory of YAMLs
_kvals_resolve() {
  local target="$1"

  # Single YAML file
  if [ -f "$target" ]; then
    cat "$target"
    return 0
  fi

  # Directory of YAMLs
  if [ -d "$target" ]; then
    local yaml_files
    yaml_files=($(find "$target" -maxdepth 1 -type f \( -name "*.yaml" -o -name "*.yml" \) | sort))

    if [ ${#yaml_files[@]} -eq 0 ]; then
      echo "No YAML files found in directory: $target" >&2
      return 1
    fi

    cat "${yaml_files[@]}"
    return 0
  fi

  echo "Error: '$target' is not a file or directory" >&2
  return 1
}

# Apply: vals → kubectl apply
kvals() {
  if [ -z "$1" ]; then
    echo "Usage: kvals <file.yaml|directory>"
    return 1
  fi

  _kvals_resolve "$1" | vals eval - | kubectl apply -f -
}

# Diff: vals → kubectl diff, with delta|colordiff|kubectl --color
kvals-diff() {
  if [ -z "$1" ]; then
    echo "Usage: kvals-diff <file.yaml|directory>"
    return 1
  fi

  # Pre-resolve YAML once
  local tmpfile
  tmpfile="$(mktemp)"
  if ! _kvals_resolve "$1" >"$tmpfile"; then
    rm -f "$tmpfile"
    return 1
  fi

  # Run vals first
  local output
  output="$(vals eval -f "$tmpfile")"

  # Priority: kubectl --color > delta > colordiff > plain
  if kubectl diff --help 2>&1 | grep -q -- '--color'; then
    # kubectl can do color itself
    echo "$output" | kubectl diff --color=always -f -
  elif command -v delta >/dev/null 2>&1; then
    # Use delta as diff pager
    echo "$output" | kubectl diff -f - | delta
  elif command -v colordiff >/dev/null 2>&1; then
    echo "$output" | kubectl diff -f - | colordiff
  else
    echo "$output" | kubectl diff -f -
  fi

  local rc=$?
  rm -f "$tmpfile"
  return $rc
}
