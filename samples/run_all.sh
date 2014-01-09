#!/bin/bash

echo "Running all samples, press escape to jump on next sample"

for dir in `ls`;
do
    test -d "$dir" || continue
    cd $dir
    echo "Running <$dir> sample..."
    love .
    cd ..
done