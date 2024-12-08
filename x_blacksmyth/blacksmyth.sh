cat test.elm >extract/test.elm
cat test.elm >type/test.elm
cat test.elm >other/test.elm

cd extract
make
cat test.elm | ./main.native >../funcs.elm
rm test.elm
cd ..

cd type
make
cat test.elm | ./main.native >../typelines.elm
rm test.elm
cd ..

cd other
make
cat test.elm | ./main.native >../otherlines.elm
rm test.elm
cd ..

cat typelines.elm >reforged.elm
cat funcs.elm >>reforged.elm
cat otherlines.elm >>reforged.elm

rm typelines.elm
rm funcs.elm
rm otherlines.elm

cat reforged.elm