PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# declare variables
SYMBOL=$1
DATA=""

# repeating functions
ERROR_MSG () {
  echo "I could not find that element in the database."
}

PROCESSING_DATA () {
  
  if [[ -z $DATA ]]
  then
    ERROR_MSG
  else
    echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR WEIGHT BAR MELTING BAR BOILING BAR TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi

}

# end

# main section

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  
  # if input is not a number
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
  then
    # if input is greater than two letter
    LENGTH=$(echo -n "$SYMBOL" | wc -m)

    if [[ $LENGTH -gt 2 ]]
    then
      # get data by full name
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE name='$SYMBOL'")
      PROCESSING_DATA
      
    else
      # get data by atomic symbol
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$SYMBOL'")
      PROCESSING_DATA
      
    fi

  else
    # get data by atomic number
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$SYMBOL")
    PROCESSING_DATA
  fi

fi










  
