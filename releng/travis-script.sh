#!/usr/bin/env bash
set -o errexit
set -o nounset

git_branch="$1"
git_commit="$2"
version=${3:-$git_commit}

printf "== Begin: travis-script.sh (branch: $git_branch, commit: $git_commit, version: $version) ==\n"

make deps-check
make clean

printf "== Begin: execute tests\n"

make versions setup-develop
make versions test VERSION=${version}

printf "== End:   execute tests\n"

printf "== Begin: build docker image\n"

docker build \
    -t quay.io/datawire/ambassador-gh369:${git_commit} \
    ambassador

docker push quay.io/datawire/ambassador-gh369:${git_commit}

printf "== End:   build docker image\n"

printf "== Begin: create documentation draft\n"

printf "== End:   create documentation draft\n"

printf "== End:   travis-script.sh ==\n"