#!/bin/sh
#
# SCRIPT: max.awk
# AUTHOR: Janos Gyerik <janos.gyerik@gmail.com>
# DATE:   2004-12-16
# REV:    1.0.T (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PLATFORM: Not platform dependent
#
# PURPOSE: Find the maximum value in the input files or pipe. One number per
#          line is expected in the input.
#

usage () {
    echo "usage: `basename $0` [-h|--help] file"
    exit
}

args=
while [ $# != 0 ]; do
    case $1 in
    -h|--help) usage ;;
    --) shift; for i; do args="$args \"$i\""; done; shift $# ;;
    -?*) echo Unknown option: $1 ; usage ;;
    *) args="$args \"$1\"" ;;
    esac
    shift
done

eval "set -- $args"

#test $# = 0 && usage

awk '
BEGIN {
    getline max;
    while (getline value) if (value > max) max = value;
    print max;
}
' $@

# eof
