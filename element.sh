#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then 
  echo -e "Please provide an element as an argument."
else
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      RESULT_ELEMENT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number=$1")"
    else
      RESULT_ELEMENT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol='$1' OR name='$1'")"
    fi
    if [[ -z $RESULT_ELEMENT ]]
    then
      echo -e "I could not find that element in the database."
    else
      echo $RESULT_ELEMENT|while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING BOILING TYPE_ID
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
fi