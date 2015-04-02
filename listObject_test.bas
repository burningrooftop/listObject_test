' listObject test suite

global testnum, testok, testfailed

run "listObject", #list

call test "isnull()"
call assertn #list isnull(), 0

call test "debug$()"
call assert #list debug$(), "List"

call test "new()"
call assertn #list new("", ""), 0
call assertn #list new("", "|"), 1
call assertn #list new("dog,cat,gold-fish,miniature pig", ""), 0
call assertn #list new("dog,cat,,gold-fish,miniature pig", ","), 1

call test "demimiter$()"
call assertn #list new("dog,cat,,gold-fish,miniature pig", ","), 1
call assert #list delimiter$(), ","

call test  "list$()"
call assertn #list new("dog,cat,,gold-fish,miniature pig", ","), 1
call assert #list list$("|"), "dog|cat||gold-fish|miniature pig"

call test  "count()"
call assertn #list new("dog++cat++++gold-fish++miniature pig", "++"), 1
call assertn #list count(), 5

call test "last$()"
call assertn #list new("dog||cat||||gold-fish||miniature pig", "||"), 1
call assert #list last$(), "miniature pig"

call test "find()"
call assertn #list new("dog,cat,,gold-fish,miniature pig", ","), 1
call assertn #list find("apple"), 0
call assertn #list find(""), 3
call assertn #list find("cat"), 2

call test "add()"
call assertn #list new("dog,cat,,gold-fish,miniature pig", ","), 1
call assertn #list add("parrot"), 0
call assertn #list count(), 6
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,parrot"

call test "remove()"
call assertn #list new("dog,cat,,gold-fish,miniature pig,cat", ","), 1
call assertn #list remove("apple"), 0
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,cat"
call assertn #list remove("cat"), 1
call assert #list list$(","), "dog,,gold-fish,miniature pig,cat"

call test "removeAll()"
call assertn #list new("dog,cat,,gold-fish,miniature pig,dog,cat", ","), 1
call assertn #list removeAll("apple"), 0
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,dog,cat"
call assertn #list removeAll("cat"), 1
call assert #list list$(","), "dog,,gold-fish,miniature pig,dog"

call test "item$()"
call assertn #list new("dog,cat,,gold-fish,miniature pig", ","), 1
call assert #list item$(1), "dog"
call assert #list item$(2), "cat"
call assert #list item$(3), ""
call assert #list item$(5), "miniature pig"
call assert #list item$(10), ""

call test "sort()"
call assertn #list new("dog***cat******gold-fish***miniature pig", "***"), 1
call assertn #list sort(0), 0
call assert #list list$(","), ",cat,dog,gold-fish,miniature pig"
call assertn #list sort(1), 0
call assert #list list$(", "), "miniature pig, gold-fish, dog, cat, "

call summary

sub test what$
  testnum = 0
  print
  print "-----------------------------------------------"
  print "Starting testing of "; what$
  print "-----------------------------------------------"
end sub
 
sub assert in$, expected$
  testnum = testnum + 1
  print "Test "; testnum; " got <"; in$; ">, expected <"; expected$; "> - ";
  if in$ <> expected$ then
    testfailed = testfailed + 1
    print " FAILED"
  else
    testok = testok + 1
    print " Passed"
  end if
end sub

sub assertn in, expected
  call assert str$(in), str$(expected)
end sub

sub summary
  print
  print "==============================================="
  print testok + testfailed; " tests run"
  print testok; " test passed"
  print testfailed; " tests failed"
  print "==============================================="
end sub
