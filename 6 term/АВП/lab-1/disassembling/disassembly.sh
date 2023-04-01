#!/bin/zsh
for file in *.cpp
do
  echo "Compiling $file..."
  g++ -O2 -fopt-info-vec-optimized -march=native -Wall -mavx -mfma -o "${file%.cpp}.out" "$file"
done

for file in *.out
do
  echo "Disassembling $file..."
  objdump -d "$file" > asm/"${file%.out}.asm"
done
