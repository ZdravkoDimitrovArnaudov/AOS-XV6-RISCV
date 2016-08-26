#!/bin/sh
wget http://www.cs.wisc.edu/~remzi/OSTEP/Homework/all.tgz 
mkdir HW; cd HW
tar xf ../all.tgz
find . -type d | xargs -L1 -I{}  sh -c 'cd {}; tar xf *.tgz; rm *.tgz' 
cd ../; rm all.tgz
