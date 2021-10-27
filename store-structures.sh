#!/bin/bash

. ./substore-init-vars.sh
STORE_DIRECTORY="store"
SUBSTORE_LOCATION=./$STORE_DIRECTORY/$1

rm -rf $SUBSTORE_LOCATION

CreateSubstorePartials () {
mkdir $SUBSTORE_LOCATION
cat > $SUBSTORE_LOCATION/$2.js <<EOF
$3
EOF
return 1
}

if [ -d "$STORE_DIRECTORY" ]; then
  echo "store folder already exists!"
else
  echo "store folder already not exists!"
  mkdir "store"
fi

CreateSubstorePartials $1 actions "$ACTIONS_INIT"
CreateSubstorePartials $1 types "$TYPES_INIT"
CreateSubstorePartials $1 effects "$EFFECTS_INIT"
CreateSubstorePartials $1 selectors "$SELECTORS_INIT"
CreateSubstorePartials $1 reducers "$REDUCERS_INIT"
CreateSubstorePartials $1 services "$SERVICES_INIT"

# if [ -d "$STORE_DIRECTORY" ]; then
#   echo "store folder already exists!"
# else
#   echo "store folder already not exists!"
#   mkdir "store"
#   CreateSubstoreFolder $1
# fi