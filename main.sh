#!/bin/bash

DIR=./mails_file.csv
STR1="DevOps"
FILENAME="./terraform/vars.tf"
LINE1='variable "name"{'
LINE2='type = list(string)'
LINE3='default = ['
LINE4='}'
QUOTES='"'
BRACKET=']'
COMMA=','

getUsers()
{
    touch $FILENAME
    printf "$LINE1" >> $FILENAME
    printf "%s\n" >> $FILENAME
    printf "$LINE2" >> $FILENAME
    printf "%s\n" >> $FILENAME
    printf "$LINE3" >> $FILENAME
    n=1
    echo "DevOps Users"
    cat $DIR | while read line; do
    if [[ $line == *$STR1* ]]; then
        IFS=','
        read -a strarr <<< "$line"
        IFS='@'
        read -a strarr2 <<< "${strarr[2]}"
        echo "user: ${strarr2[0]}"
        if [ $n -eq 1 ]
        then
          printf "$QUOTES${strarr2[0]}$QUOTES" >> $FILENAME
        else
          printf "$COMMA$QUOTES${strarr2[0]}$QUOTES" >> $FILENAME
        fi
    fi
    n=$((n+1))
    done
    printf "$BRACKET" >> $FILENAME
    printf "%s\n" >> $FILENAME
    printf "$LINE4" >> $FILENAME
    printf "%s\n" >> $FILENAME

}

checkfile()
{
  if test -f "$FILENAME"; then
    rm "$FILENAME"
fi

}

main()
{
  checkfile
  getUsers
}

main
