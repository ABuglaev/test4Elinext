#!/bin/bash
echo "Hello from Bash again"

dir=$1
if [ -d $dir ]
then
        echo "Check directory... Ok. "
else
        echo "Incorrect directory"
        exit 1
fi

USER="root"
PASS="123123" # :)

FILESLIST=$(find $dir -type f)

SQLCOMMAND="use filesDB; "

for FILENAME in $FILESLIST
do
        FNAME=$(basename $FILENAME)
        FILESIZE=$(stat -c%s $FILENAME)
        FILEMODIFIED=$(stat -c%z $FILENAME)

        SQLCOMMAND="$SQLCOMMAND insert into files (name, path, size, modified) values ('$FNAME', '$FILENAME', '$FILESIZE', '$FILEMODIFIED' ); "

done
        docker exec -it  my-mysql mysql -u $USER -p$PASS -e "$SQLCOMMAND"

        docker exec -it  my-mysql mysql -u $USER -p$PASS -e "use filesDB; select * from files;"
