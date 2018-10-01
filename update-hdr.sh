#!/bin/bash
#save the current working directory
cur_dir=$(pwd)

if [[ -f /var/nascent/part-numbers/ons-part.pn ]]; then
  tail=$(</var/nascent/part-numbers/ons-part.pn)
  echo $tail
  tailFour=$(echo $tail | tail -c 5)
  echo $tailFour
#now only 2 digits
  initNewTail=${tailFour:0:1}
  echo $initNewTail
  lastLetter=$(echo $tail | tail -c 2)
  echo last $lastLetter
  secondlastLetter=$(echo ${tail:13:1})
  echo secondlast $secondlastLetter
  thirdlastLetter=$(echo ${tail:12:1})
  echo thirdlast $thirdlastLetter


if [ "$lastLetter" = "Z" ] && [ "$secondlastLetter" = "9" ]; then
    newLastLetter="A"
    echo $newLastLetter
    newsecondLastLetter="0"
    echo $newsecondLastLetter
    newthirdlastLetter=$(tr "0-9A-Z" "1-9A-Z_" <<< $thirdlastLetter)
    echo newthirdlast $newthirdlastLetter
    updatedTail=NCT-Z-10MA-$initNewTail$newthirdlastLetter$newsecondLastLetter$newLastLetter
  elif [ "$lastLetter" = "Z" ];then
    newLastLetter="A"
    newsecondLastLetter=$(tr "0-9A-Z" "1-9A-Z_" <<< $secondlastLetter)
    echo newsecondlast $newsecondLastLetter
    updatedTail=NCT-Z-10MA-$initNewTail$thirdlastLetter$newsecondLastLetter$newLastLetter
  else
    newLastLetter=$(tr "0-9A-Z" "1-9A-Z_" <<< $lastLetter)
    updatedTail=NCT-Z-10MA-$initNewTail$thirdlastLetter$secondlastLetter$newLastLetter
    echo newLastLetter $newLastLetter
  fi
echo $updatedTail
sed -i "s/NCT-Z-01MA-S00B/$updatedTail/g" ${cur_dir}/apps/bars/files/cbb/etc/partslist/bars.hdr
fi
cat ${cur_dir}/apps/bars/files/cbb/etc/partslist/bars.hdr
