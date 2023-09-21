
function flash_git_branch_name
  command git for-each-ref --format='%(objectname) %(refname:short)' refs/heads | awk "/^$(git rev-parse HEAD)/ {print \$2}"
end

function fish_right_prompt
  set -l code $status

  function status::color -S
    test $code -ne 0; and echo (flash_snd); or echo (flash_fst)
  end

  if test $CMD_DURATION -gt 0
    printf (flash_dim)" "(printf "%.3fs " (math "$CMD_DURATION / 1000"))(flash_off)
  end

  if test -d .git
    echo (flash_snd)"("(flash_fst)(flash_git_branch_name)(flash_snd)")"(flash_off)
  end

  printf " "(flash_trd)(date +%H(status::color):(flash_dim)%M(status::color):(flash_trd)%S)(flash_snd)" "(flash_off)

  if test $code -ne 0
    echo (flash_fst)"≡ "(flash_snd)"$code"(flash_off)
  end
end
