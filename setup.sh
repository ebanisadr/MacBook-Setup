#!/bin/bash

for f in `ls -v scripts/*.sh`; do
  echo "running $f"
  bash "$f"
done
