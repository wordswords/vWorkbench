#!/bin/bash
if [ -z "$STY" ]; then exec screen -dm -S update-explainshell /bin/bash "$0"; fi

cd explainshell
rm manlist.txt
find /usr/share/man/ -type f -print >> manlist.txt
cat manlist.txt | wc -l
OLDIFS=$IFS
IFS="
"
for mpage in $(cat ./manlist.txt) ; do
    echo Processing: $mpage
    docker-compose exec -T web bash -c "PYTHONPATH=. python explainshell/manager.py --log info $mpage" 2>/dev/null | grep successfully
done
IFS=$OLDIFA
echo "All man pages processed."

