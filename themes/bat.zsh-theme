# ZSH Theme - Preview: http://dl.dropbox.com/u/4109351/pics/gnzh-zsh-theme.png
# Based on gnzh theme

setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%{$FG[000]%}%n'
  PR_USER_OP='%F{magenta}%#%f'
  # Add a space that doesn't get counted in wrapping length to work around wrapping issues.
  PR_PROMPT='🦇%{ %}'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  # Add a space that doesn't get counted in wrapping length to work around wrapping issues.
  PR_PROMPT='🦇%{ %}'
fi

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT "
  else
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg_bold[grey]%}$LAST_EXIT_CODE%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT "
  fi
}

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{green}%M%f' # no SSH
fi


local user_host="${PR_USER}"
local current_dir="%~"
local rvm_ruby=''
if ${HOME}/.rvm/bin/rvm-prompt &> /dev/null; then # detect user-local rvm installation
  rvm_ruby='%F{red}‹$(${HOME}/.rvm/bin/rvm-prompt i v g s)›%f'
elif which rvm-prompt &> /dev/null; then # detect system-wide rvm installation
  rvm_ruby='%F{red}‹$(rvm-prompt i v g s)›%f'
elif which rbenv &> /dev/null; then # detect Simple Ruby Version Management
  rvm_ruby='%F{red}‹$(rbenv version | sed -e "s/ (set.*$//")›%f'
fi
local git_branch='$(git_prompt_info)'

# PROMPT="%{$BG[246]%} ${user_host} %{$BG[015]%} ${current_dir} ${git_branch}%{$FX[reset]%} $PR_PROMPT "
PROMPT="%{$FG[000]%}%{$BG[015]%} ${current_dir} ${git_branch}%{$FX[reset]%} $PR_PROMPT "

#RPROMPT='$(check_last_exit_code)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$BG[098]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$bg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow} 👻%{ %}%f"
ZSH_THEME_GIT_PROMPT_STAGED="%{$bg[red]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$bg[red]%}%{✖︎%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$bg[blue]%}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="ZSH_THEME_GIT_PROMPT_ADDED"
ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX="ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX"
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX"
ZSH_THEME_GIT_PROMPT_ADDED="ZSH_THEME_GIT_PROMPT_ADDED"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR="ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR="ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR"
ZSH_THEME_GIT_PROMPT_DELETED="ZSH_THEME_GIT_PROMPT_DELETED"
ZSH_THEME_GIT_PROMPT_DIVERGED="ZSH_THEME_GIT_PROMPT_DIVERGED"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE"
ZSH_THEME_GIT_PROMPT_MODIFIED="ZSH_THEME_GIT_PROMPT_MODIFIED"
ZSH_THEME_GIT_PROMPT_REMOTE_EXISTS="ZSH_THEME_GIT_PROMPT_REMOTE_EXISTS"
ZSH_THEME_GIT_PROMPT_REMOTE_MISSING="ZSH_THEME_GIT_PROMPT_REMOTE_MISSING"
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED="ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED"
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX="ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX"
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX="ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX"
ZSH_THEME_GIT_PROMPT_RENAMED="ZSH_THEME_GIT_PROMPT_RENAMED"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="ZSH_THEME_GIT_PROMPT_SHA_AFTER"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="ZSH_THEME_GIT_PROMPT_SHA_BEFORE"
ZSH_THEME_GIT_PROMPT_STASHED="ZSH_THEME_GIT_PROMPT_STASHED"
ZSH_THEME_GIT_PROMPT_UNMERGED="ZSH_THEME_GIT_PROMPT_UNMERGED"

}
