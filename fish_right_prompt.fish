
function git::is_stashed
  command git rev-parse --verify --quiet refs/stash >/dev/null
end

function git::branch_name
  command git symbolic-ref --short HEAD
end

function git::is_touched
  test -n (echo (command git status --porcelain))
end

function fish_right_prompt
  set -l code $status

  function status::color -S
    test $code -ne 0; and echo (snd); or echo (fst)
  end

  if test $CMD_DURATION -gt 1000
    printf (dim)" ~"(printf "%.1fs " (math "$CMD_DURATION / 1000"))(off)
  end

  if test -d .git
    if git::is_stashed
      echo (dim)"<"(off)
    end
    printf (begin
      git::is_touched
        and echo (fst)"(*"(snd)(git::branch_name)(fst)")"(off)
        or echo (snd)"("(fst)(git::branch_name)(snd)")"(off)
    end)(off)
  end

  printf " "(trd)(date +%H(status::color):(dim)%M(status::color):(trd)%S)(snd)" "(off)

  if test $code -ne 0
    echo (fst)"≡ "(snd)"$code"(off)
  end
end
