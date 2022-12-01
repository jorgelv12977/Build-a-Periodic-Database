#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER_SELECTED_SYMBOL=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    ATOMIC_NUMBER_SELECTED_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
    if [[ -z $ATOMIC_NUMBER_SELECTED_SYMBOL && -z $ATOMIC_NUMBER_SELECTED_NAME ]]
    then
      echo "I could not find that element in the database."
    elif [[ -z $ATOMIC_NUMBER_SELECTED_SYMBOL ]] 
    then
      NAME_ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_NAME")
      SYMBOL_ELEMENT=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_NAME")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_NAME")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_NAME")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_NAME")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_NAME")
      NAME_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

      echo "The element with atomic number $ATOMIC_NUMBER_SELECTED_NAME is $NAME_ELEMENT ($SYMBOL_ELEMENT). It's a $NAME_TYPE, with a mass of $ATOMIC_MASS amu. $NAME_ELEMENT has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | tr -s " " | sed 's/( /(/g'
    else
      NAME_ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_SYMBOL")
      SYMBOL_ELEMENT=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_SYMBOL")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_SYMBOL")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_SYMBOL")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_SYMBOL")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED_SYMBOL")
      NAME_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

      echo "The element with atomic number $ATOMIC_NUMBER_SELECTED_SYMBOL is $NAME_ELEMENT ($SYMBOL_ELEMENT). It's a $NAME_TYPE, with a mass of $ATOMIC_MASS amu. $NAME_ELEMENT has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | tr -s " " | sed 's/( /(/g'
    fi
  else
    ATOMIC_NUMBER_SELECTED=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    if [[ -z $ATOMIC_NUMBER_SELECTED ]]
    then
      echo "I could not find that element in the database."
    else
      NAME_ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER_SELECTED")
      SYMBOL_ELEMENT=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER_SELECTED")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER_SELECTED")
      NAME_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

      echo "The element with atomic number $ATOMIC_NUMBER_SELECTED is $NAME_ELEMENT ($SYMBOL_ELEMENT). It's a $NAME_TYPE, with a mass of $ATOMIC_MASS amu. $NAME_ELEMENT has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | tr -s " " | sed 's/( /(/g'
    fi
  fi 

fi

