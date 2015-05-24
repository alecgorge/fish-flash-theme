set -g CMD_DURATION 0

function fst; set_color -o fa0; end
function snd; set_color -o C00; end
function trd; set_color -o 666; end
function dim; set_color -o 333; end
function off; set_color normal; end
function bc; command bc -l $argv; end

function fish_prompt
  set -l code $status

  set -l prompt (prompt_pwd)
  set -l base (basename (prompt_pwd))

  printf (snd)"( "(begin
    if test "$PWD" = "/"
      test $code -eq 0; and echo (fst)"/"(off); or echo (dim)"/"(off)
    else
      echo ""
    end
  end)(echo $prompt \
  | sed "s|~|"(begin
      test $code -eq 0; and echo (fst); or echo (dim)
    end)"⌁"(off)"|g" \
  | sed "s|/|"(snd)" ) "(off)"|g" \
  | sed "s|"$base"|"(fst)$base(off)" |g")(snd)(begin
    test "$PWD" = "$HOME"; and echo " "; echo ""
    end)(begin
      if test "$PWD" = "/"
        echo ""
      else
        echo ") "
      end
    end)(off)
end