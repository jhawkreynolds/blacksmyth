oldProgram=$1
changelog=$2
oracle=$3

changelog_path="../$changelog"

{ cat $oldProgram; echo ' '; python3 assertionGen.py $3; } >program.elm

program="program.elm"

cat $program >extract/test.elm
cat $program >type/test.elm
cat $program >other/test.elm

cd extract
python3 genLexer.py $changelog_path
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