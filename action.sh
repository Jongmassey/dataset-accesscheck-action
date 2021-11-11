#!/bin/bash
set -euo pipefail

# Repeat the character 80 times
long_line=$(printf '―%.0s' {1..80})
bold=$(echo -e "\033[1m")
reset=$(echo -e "\033[0m")

echo "$long_line"
echo "${bold}→ Preparing${reset}"
echo
echo "Checking out commit"
echo "https://github.com/$GITHUB_REPOSITORY/commit/$GITHUB_SHA"
echo

if [[ -z "$GITHUB_TOKEN" ]]; then
  auth_header=''
else
  auth_header="authorization: Bearer $GITHUB_TOKEN"
fi
curl \
  --silent \
  --header "$auth_header" \
  -L https://api.github.com/repos/$GITHUB_REPOSITORY/tarball/$GITHUB_SHA \
  | \
  tar --strip-components=1 -xzf -

echo "$long_line"
echo "${bold}→ Preparing${reset}"
echo
echo "Checking out research dataset checker"
echo "https://api.github.com/repos/Jongmassey/research_repository_permissions/tarball/"
echo

if [[ -z "$GITHUB_TOKEN" ]]; then
  auth_header=''
else
  auth_header="authorization: Bearer $GITHUB_TOKEN"
fi
mkdir -p $GITHUB_ACTION_PATH/checker &&
curl \
  --silent \
  --header "$auth_header" \
  -L https://api.github.com/repos/Jongmassey/research_repository_permissions/tarball/ \
  | \
  tar -C $GITHUB_ACTION_PATH/checker --strip-components=1 -xzf -

echo "$long_line"
echo "${bold}→ Preparing${reset}"
echo
echo "Running research dataset checker"
$GITHUB_ACTION_PATH/checker/check.sh $GITHUB_ACTION_PATH