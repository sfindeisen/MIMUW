#!/bin/sh
#
# Student lookup utility (by numer indeksu).
#
# Copyright (C) 2012 Stanislaw Findeisen <sf181257 at students.mimuw.edu.pl>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Changes history:
#
# 2012-04-17 (STF) Initial version.

prgname=lookup-nrindeksu
#prgnameex=$0
prgnamefl=$prgname.sh
prgver=0.1
prgverdate=2012-04-17

function printHelp {
    echo "$prgname $prgver ($prgverdate)"
    echo ""
    echo "Copyright (C) 2012 Stanislaw Findeisen <sf181257 at students.mimuw.edu.pl>"
    echo "License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/>"
    echo "This is free software: you are free to change and redistribute it."
    echo ""
    echo "This program is distributed in the hope that it will be useful,"
    echo "but WITHOUT ANY WARRANTY; without even the implied warranty of"
    echo "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
    echo "GNU General Public License for more details."
    echo "" ;
    echo "Student lookup utility (by numer indeksu)." ;
    echo "" ;
    echo "Usage: $prgnamefl [options]" ;
    echo "where options are:";
    echo "    -s  start dir" ;
    echo "    -f  finger" ;
    echo "    -i  student number (numer indeksu)" ;
}

if [ $# -le 0 ] ; then
    printHelp ;
else
    startDir=/home/students/
    doFinger=0
    nrInd=0

    while getopts 's:fi:' optionName ; do
        case "$optionName" in
            s) startDir=$OPTARG ;;
            f) doFinger=1 ;;
            i) nrInd=$OPTARG ;;
        esac
    done

    if [ 5 -le ${#nrInd} ] ; then
        # echo "Start dir: $startDir" ;
        # echo "Do finger: $doFinger" ;
        # echo "Nr indeksu: $nrInd" ;

        studentDir=`find $startDir -regextype posix-extended -regex ".*\/[a-z]{2}[0-9]{5,}\$" -type d -prune -printf '%p\n' | grep "$nrInd"`

        for li in $studentDir ; do
            echo "Student dir: $li" ;
	    if [ 1 -eq $doFinger ] ; then
	        sdInd=`echo "$li" | sed 's/^.*\/\([a-zA-Z]\{2\}[0-9]\{5,\}\)$/\1/'` ;
	        finger $sdInd ;
	    fi
        done
    else
        printHelp ;
    fi
fi
