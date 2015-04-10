' listObject test suite

global testnum, testok, testfailed

run "listObject", #list
run "listObject", #list2

call test "isnull()"
call assertn #list isnull(), 0

call test "debug$()"
call assert #list debug$(), "List"

call test "new()"
call assertn #list new(""), 0
call assertn #list new("|"), 1
call assertn #list count(), 0
call assert #list list$(","), ""

call test "demimiter$()"
call assertn #list new(","), 1
call assert #list delimiter$(), ","

call test  "list$()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assert #list list$("|"), "dog|cat||gold-fish|miniature pig"

call test  "count()"
call assertn #list new("++"), 1
call assertn #list add("dog++cat++++gold-fish++miniature pig"), 1
call assertn #list count(), 5

call test "first$()"
call assertn #list new("||"), 1
call assertn #list add("dog||cat||||gold-fish||miniature pig"), 1
call assert #list first$(), "dog"

call test "last$()"
call assertn #list new("||"), 1
call assertn #list add("dog||cat||||gold-fish||miniature pig"), 1
call assert #list last$(), "miniature pig"

call test "find()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assertn #list find("apple"), 0
call assertn #list find(""), 3
call assertn #list find("cat"), 2

call test "add()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assertn #list add("parrot"), 1
call assertn #list count(), 6
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,parrot"

call test "addFirst()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assertn #list addFirst("parrot"), 1
call assertn #list count(), 6
call assert #list list$(","), "parrot,dog,cat,,gold-fish,miniature pig"

call test "addLast()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assertn #list addLast("parrot"), 1
call assertn #list count(), 6
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,parrot"

call test "addAll()"
call assertn #list new(","), 1
call assertn #list2 new("|"), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assertn #list2 add("apple|pear"), 1
call assertn #list addAll(#list2), 1
call assertn #list count(), 7
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,apple,pear"

call test "addAllFirst()"
call assertn #list new(","), 1
call assertn #list2 new("|"), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assertn #list2 add("apple|pear"), 1
call assertn #list addAllFirst(#list2), 1
call assertn #list count(), 7
call assert #list list$(","), "apple,pear,dog,cat,,gold-fish,miniature pig"

call test "addAllLast()"
call assertn #list new(","), 1
call assertn #list2 new("|"), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assertn #list2 add("apple|pear"), 1
call assertn #list addAllLast(#list2), 1
call assertn #list count(), 7
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,apple,pear"

call test "remove()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig,cat"), 1
call assertn #list remove("apple"), 0
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,cat"
call assertn #list remove("cat"), 1
call assert #list list$(","), "dog,,gold-fish,miniature pig,cat"

call test "removeAll()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig,dog,cat"), 1
call assertn #list removeAll("apple"), 0
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,dog,cat"
call assertn #list removeAll("cat"), 1
call assert #list list$(","), "dog,,gold-fish,miniature pig,dog"

call test "removeFirst()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig,dog,cat"), 1
call assertn #list removeFirst(), 1
call assert #list list$(","), "cat,,gold-fish,miniature pig,dog,cat"

call test "removeLast()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig,dog,cat"), 1
call assertn #list removeLast(), 1
call assert #list list$(","), "dog,cat,,gold-fish,miniature pig,dog"

call test "removeIndex()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig,dog,cat"), 1
call assertn #list removeIndex(3), 1
call assert #list list$(","), "dog,cat,gold-fish,miniature pig,dog,cat"
call assertn #list removeIndex(5), 1
call assert #list list$(","), "dog,cat,gold-fish,miniature pig,cat"
call assertn #list removeIndex(8), 0
call assert #list list$(","), "dog,cat,gold-fish,miniature pig,cat"

call test "item$()"
call assertn #list new(","), 1
call assertn #list add("dog,cat,,gold-fish,miniature pig"), 1
call assert #list item$(1), "dog"
call assert #list item$(2), "cat"
call assert #list item$(3), ""
call assert #list item$(5), "miniature pig"
call assert #list item$(10), ""

call test "sort()"
call assertn #list new("***"), 1
call assertn #list add("dog***cat******gold-fish***miniature pig"), 1
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
