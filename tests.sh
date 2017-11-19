# Pass SERVER=DOMAIN_NAME PORT="####" as parameters

echo Running tests...

#1 get all entries
ldapsearch -h $1 -p $2  -x -s base "uid=x*" > tests/out.1 2>&1 &

#2 get one entry xkisel02
ldapsearch -h $1 -p $2  -x -s base "uid=xkisel02" > tests/out.2 2>&1 &

#3 get nothing
ldapsearch -h $1 -p $2 -x -s base "uid=xkisel" > tests/out.3 2>&1 &

#4 get xkisel02 or xkisel00
ldapsearch -h $1 -p $2  -x -s base "(|(uid=xkisel02)(uid=xkisel00))" > tests/out.4 2>&1 &

#5 get xkisel02 only if not xkisel00
ldapsearch -h $1 -p $2 -x -s base "(&(uid=xkisel02)(!(uid=xkisel00)))" > tests/out.5 2>&1 & 

#6 get either xkisel02 or anything but xkisel00
ldapsearch -h $1 -p $2 -x -s base "(|(uid=xkisel02)(!(uid=xkisel00)))" > tests/out.6 2>&1 &

#7 error, not implemented by server(message here will differ as everyone has other error messages
ldapsearch -h $1 -p $2 -x -s base "uid<=x" > tests/out.7 2>&1 &

#8 wrong base error
# this should probably not considered as error
#ldapsearch -h $1 -p $2 -x -s sub "uid=x*" > tests/out.8 2>&1

#9 get max 5 results
ldapsearch -h $1 -p $2 -x -s base -z 5 "uid=x*" > tests/out.9 2>&1 & 

#10 get unlimited results
ldapsearch -h $1 -p $2 -x -s base -z 0 "uid=x*" > tests/out.10 2>&1 &

#11 find 442 - everyone except mr. Thanh
ldapsearch -p $2 -h $1 '(!(|(&(cn=*Thanh)(uid=xdolon00))(&(cn=Tomas)(mail=xtomas0@email.cz))))' -s base -x > tests/out.11 2>&1 &

s=2
echo "Sleep for $s seconds to finish all requests"
sleep $s

nums="1 2 3 4 5 6 7 9 10 11"
for tst in $nums
do
  if diff tests/out.$tst tests/exp.$tst > /dev/null; then
    echo TEST $tst OK
  else
    echo "TEST $tst FAILED!!!"
  fi
done

echo FINISHED
