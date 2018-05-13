#! /usr/bin/env bash

[[ -f "/usr/local/share/bash_utils.sh" && ! $BASH_UTILS_SOURCED -eq 1 ]] && . "/usr/local/share/bash_utils.sh"

DOCKER_SOCKET="/var/run/docker.sock"
DOCKER_CONFIG_NEW="$HOME/.docker/config.json"
DOCKER_CONFIG_OLD="$HOME/.dockercfg"
DOCKER_CONFIG
PROJECT_TMPDIR=$(mktemp -d "$TMPDIR/build.XXXX")

trap "rm -rf $PROJECT_TMPDIR; echo 'Cleaned up tmp dir'" EXIT

if [[ -f "$DOCKER_CONFIG_NEW" ]]; then
  DOCKER_CONFIG="$DOCKER_CONFIG_NEW"
else
  DOCKER_CONFIG="$DOCKER_CONFIG_OLD"
fi

validate_env_vars() {
  [[ ! -z "$GITHUB_USERNAME" ]] \
    || die "GITHUB_USERNAME is not exported"
  [[ ! -z "$DEPLOY_GITHUB_TOKEN" ]] \
    || die "GITHUB_TOKEN is not exported"
  [[ ! -z "$DOCKERHUB_USERNAME" ]] \
    || die "DOCKERHUB_USERNAME is not exported"
  [[ ! -z "$BINTRAY_USERNAME" ]] \
    || die "BINTRAY_USERNAME is not exported"
  [[ ! -z "$BINTRAY_REPO_NAME" ]] \
    || die "BINTRAY_REPO_NAME is not exported"
  [[ ! -z "$BINTRAY_API_KEY" ]] \
    || die "BINTRAY_REPO_NAME is not exported"
}

validate() {
  local git_repo_url="$1"
  local git_branch="$2"
  local version="$3"
  [[ "$(id -u)" == "0" ]] \
    || die "container is not running as root"
  command -v docker \
    || die "docker is not installed"
  [[ -e $DOCKER_SOCKET ]] \
    || die "docker socket is not present"
  curl -ivs --unix-socket $DOCKER_SOCKET http://localhost/version \
    || die "cant communicate with the docker socket"
  [[ ! -z "$(cat "$DOCKER_CONFIG" | jq -r ".auths | .[] | .auth")" ]] \
    || die "not logged into docker registry"
  [[ "$git_repo_url" =~ "https" ]] \
    || die "only accepts git urls with https over token auth for release"
  echo "$git_branch" | egrep '(master|develop|wip|hotfix)' \
    || die "only accepts git branches (master|develop|wip|hotfix) for release"
  echo "$version" | egrep '(major|minor|patch)' \
    || die "only accepts release versions (major|minor|patch) for release"
  validate_env_vars
  ok
}

get_repo_name() {
  local repo_url="$1"
  local repo_name="$(echo $repo_url | cut -d '/' -f5 | sed -e 's#.git##g')"
  echo "$repo_name"
}

clone_repo() {
  local git_repo_url="$1"
  local git_branch="$2"
  local repo_url="$(echo "$git_repo_url" | sed -e "s#github.com#$DEPLOY_GITHUB_TOKEN@github.com#g")"
  cd "$PROJECT_TMPDIR"
  git clone "$repo_url"
  cd "$(get_repo_name "$repo_url")"
  git fetch --all
  git checkout "$git_branch"
  git status
  ok
}

release() {
  local git_repo_url="$1"
  local git_branch="$2"
  local version="$3"
  cd "$PROJECT_TMPDIR/$(get_repo_name "$git_repo_url")"
  case "$git_branch" in
    *wip*)
      make release WIP=1 VERSION="$version" \
        || die "could not release from branch $git_branch for version level $version"
      ;;
    *hotfix*)
      make release HOTFIX=1 VERSION="$version" \
        || die "could not release from branch $git_branch for version level $version"
      ;;
    master|develop)
      make release HOTFIX=1 VERSION="$version" \
        || die "could not release from branch $git_branch for version level $version"
      ;;
    *)
      die "Dont know how to build and release from branch $git_branch"
      ;;
  esac
  ok
}

main() {
  local git_repo_url="$1"
  local git_branch="$2"
  local version="$3"
  log_current_state
  validate "$git_repo_url" "$git_branch" "$version"
  chdir_and_exec clone_repo "$git_repo_url" "$git_branch"
  chdir_and_exec release "$git_repo_url" "$git_branch" "$version"
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
