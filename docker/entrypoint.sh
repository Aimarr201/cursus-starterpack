#!/bin/sh
set -eu

git_user_name="${GIT_AUTHOR_NAME:-${GIT_COMMITTER_NAME:-${USER42:-}}}"
git_user_email="${GIT_AUTHOR_EMAIL:-${GIT_COMMITTER_EMAIL:-${MAIL42:-}}}"

if [ -n "$git_user_name" ]; then
    git config --global user.name "$git_user_name"
fi

if [ -n "$git_user_email" ]; then
    git config --global user.email "$git_user_email"
fi

git config --global --add safe.directory /42 >/dev/null 2>&1 || true

exec "$@"
