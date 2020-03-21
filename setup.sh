unset PATH
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

#echo $dotfiles

function linkUp {
  ln -fs $0 "$1/bin/$(basename $0)"
}
export -f linkUp

function build {
  mkdir -p $out/bin

  for t in $baseInputs $buildInputs; do
    find "$t/bin" \
      -type f     \
      -executable \
      -maxdepth 1 \
      -exec /bin/bash -c 'linkUp $@ $out' {} \;
  done
}
