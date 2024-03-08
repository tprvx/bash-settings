# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# определяем цвет для названия ветке, смотрим stash или modified файлы
parse_git_bg() {
  if [[ $(git status -s 2> /dev/null) ]]; then
    echo -e "\033[0;31m"
  else
    echo -e "\033[0;32m"
  fi
}

# это определяет ветку git
source ~/.bash_git

# убрал перенос строки потому что он рушит преемедение стрелками по истории команд
# иногда возникает баг что курсор на начало строки перемещается
export PS1="\e[0;36m\u@\h\e[m \e[0;32m\w\e[m\[$(parse_git_bg)\]\e[3;91m\$(__git_ps1)\e[m\e[3;37m\$\e[m "

# сколько максимум директорий отображать
PROMPT_DIRTRIM=8