unset PATH
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

function link_bins {
  ln -fs $0 "$1/bin/$(basename $0)"
}

function build_bins {
  mkdir -p $out/bin

  for t in $baseInputs $buildInputs; do
    find "$t/bin" \
      -type f     \
      -executable \
      -maxdepth 1 \
      -exec /bin/bash -c 'link_bins $@ $out' {} \;
  done
}

function build_dotfiles {
  for d in $dotfiles; do
    file_path=${d%=*}
    store_path=${d#*=}

    if [[ $file_path == *"/"* ]]; then
      mkdir -p $(dirname "$out/$file_path")
    fi

    ln -fs $store_path "$out/$file_path"
  done
}

export -f build_bins \
          build_dotfiles \
          link_bins

function build {
  build_bins
  build_dotfiles
}
