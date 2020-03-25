unset PATH
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

function link_bins {
  ln -fs $0 "$1/bin/$(basename $0)"
}
export -f link_bins

function build {
  mkdir -p $out/bin

  for t in $baseInputs $buildInputs; do
    find "$t/bin" \
      -type f     \
      -executable \
      -maxdepth 1 \
      -exec /bin/bash -c 'link_bins $@ $out' {} \;
  done

  for d in $dotfiles; do
    file_name=${d%=*}
    store_path=${d#*=}

    if [[ $file_name == *"/"* ]]; then
      mkdir -p $(dirname "$out/$file_name")
    fi

    ln -fs $store_path "$out/$file_name"
  done
}
