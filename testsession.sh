#!/bin/bash

rm cookies || true >/dev/null

#BASE="curl -b cookies -c cookies -v http://localhost:5000"
BASE="curl -b cookies -c cookies -s http://localhost:5000"

save=`$BASE/saveit`
echo $save
echo "-------------------------------------------------------------------------------"

load=`$BASE/loadit`
load="${load%?}"

if [ "$load" != "Saved" ]; then
  echo "Did not save session variable."
  exit 1
else
  echo "Saved Ok."
fi


echo "-------------------------------------------------------------------------------"
data=`$BASE/data`
echo "Data iterator: "
echo $data

echo "-------------------------------------------------------------------------------"


notset=`$BASE/notset`
notset="${notset%?}"

if [ "$notset" != "" ]; then
  echo "Non-existent session variable should return empty string but did not."
  exit 1
else
  echo "Non-existent session variable returns empty string."
fi

echo "-------------------------------------------------------------------------------"

sleep 5

load=`$BASE/loadit`
load="${load%?}"

if [ "$load" != "Saved" ]; then
  echo "Session variable did not persist."
  exit 1
else
  echo "Still saved after a few seconds."
fi

echo "-------------------------------------------------------------------------------"

sleep 70

load=`$BASE/loadit`
load="${load%?}"

if [ "$load" == "Saved" ]; then
  echo "Session did NOT expire correctly."
  exit 1
else
  echo "Session expired correctly."
fi

echo "-------------------------------------------------------------------------------"
save=`$BASE/saveit`

load=`$BASE/loadit`
load="${load%?}"

if [ "$load" != "Saved" ]; then
  echo "Did not save session variable."
  exit 1
else
  echo "Saved ok after new session."
fi

echo "-------------------------------------------------------------------------------"

clear=`$BASE/clearit`

load=`$BASE/loadit`

load="${load%?}"

if [ "$load" == "Saved" ]; then
  echo "Did NOT clear session. Incorrect."
  exit 1
else
  echo "Session cleared ok."
fi
