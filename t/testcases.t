# should pass
# simple
ok:a
ok:ab
ok:abc
ok:abc.
ok:abc.html
ok:abc.c
ok:abc-c
ok:abc_c
ok:a-b_c-c
ok:___
ok:---
ok:-
ok:_
ok:_a_
ok:-a-
ok:-a_.txt
ok:-A-b_b034_000.html1
ok:session/125cb612-7a59-4561-9756-95b7045ebcb3

# one level
ok:a/b
ok:a/.b
ok:.a/.b
ok:.a/b
ok:.-a/b
ok:-.-a/b
ok:-_-a/b
ok:-_-..a/b
ok:-_-..a/-_-..a

# multi level
ok:alf/ulf/olf
ok:.a/.b/.c
ok:alf/..a../gg
ok:a.........../..a../gg
ok:a....-......./-/_/gg
ok:a/b/c

# should not pass
fail:.
fail:..
fail:...
fail:./a
fail:../a
fail:./../a
fail:/../a
fail:./../.
fail:./.a/.
fail:a/.a/.
fail:#
fail:#/#/#
fail:a/b/!
fail:!
fail:!_
fail:a/b/
fail:alf/../gamma
fail:>
fail:>/<