#!/usr/bin/env bash
set -e
set -x

simdjson_version=${1:?git release tag (e.g. v0.9.5) is required}
npm_version=$(echo "$simdjson_version" | tr -d v)

echo "will update simdjson..."
echo "will use version $simdjson_version"
echo "and release on npm as $npm_version"
echo

if ! [[ -d "simdjson-repo" ]]; then
  echo "cloning repo..."
  git clone git@github.com:simdjson/simdjson.git simdjson-repo
fi

echo "updating repo..."
cd simdjson-repo
git checkout master
git pull
git checkout "${simdjson_version}"
cd ..

echo "removing old cpp files..."
if [[ -d "src" ]]; then
  rm -fr src
fi

echo "copying new cpp files..."
mkdir src
cp simdjson-repo/singleheader/simdjson.cpp src
cp simdjson-repo/singleheader/simdjson.h src

echo "committing files..."
git add src/simdjson.cpp
git add src/simdjson.h
git commit -m "Updating src files for simdjson ${simdjson_version}"

echo "tagging package.json..."
npm version "$npm_version"

echo "release on npm..."
npm publish

echo "push to git..."
git push origin main
git push --tags
