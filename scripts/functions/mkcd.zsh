mkcd() {
  local mkdir_args=()
  local cd_args=()
  local found_double_dash=0

  # Separate arguments before and after --
  for arg in "$@"; do
    if [[ $arg == "--" ]]; then
      found_double_dash=1
      continue
    fi

    if [[ $found_double_dash -eq 0 ]]; then
      mkdir_args+=("$arg")
    else
      cd_args+=("$arg")
    fi
  done

  if [[ ${#mkdir_args[@]} -eq 0 ]]; then
    echo "mkcd: no directories specified"
    return 1
  fi

  # Run mkdir with all pre-- arguments
  mkdir "${mkdir_args[@]}" || return 1

  # If there are post-- arguments, cd into them; otherwise cd into last mkdir dir
  if [[ ${#cd_args[@]} -gt 0 ]]; then
    cd "${cd_args[@]}" || return 1
  else
    cd "${mkdir_args[-1]}" || return 1
  fi
}
