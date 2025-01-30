#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ ! -z $1 ]] 
then

  QUERY=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE  symbol='$1' OR name='$1' OR atomic_number::TEXT ='$1' ")

  if [[ -z $QUERY ]]
  then
    echo "I could not find that element in the database."
    exit 
  fi

  echo "$QUERY" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME MASS MELTING BOILING TYPE
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done


else 
  echo -e "Please provide an element as an argument."
fi
