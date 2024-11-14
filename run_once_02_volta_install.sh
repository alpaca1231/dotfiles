#!/usr/bin/env zsh

# node
if ! command -v node &> /dev/null; then
  volta install node
else
  echo "node is already installed"
fi

# pnpm
if ! command -v pnpm &> /dev/null; then
  volta install pnpm
else
  echo "pnpm is already installed"
fi

# yarn
if ! command -v yarn &> /dev/null; then
  volta install yarn
else
  echo "yarn is already installed"
fi

# deno
if ! command -v deno &> /dev/null; then
  volta install deno
else
  echo "deno is already installed"
fi

# bun
if ! command -v bun &> /dev/null; then
  volta install bun
else
  echo "bun is already installed"
fi

# ni
if ! command -v ni &> /dev/null; then
  volta install @antfu/ni
else
  echo "@antfu/ni is already installed"
fi
