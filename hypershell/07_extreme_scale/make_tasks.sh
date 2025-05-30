#!/bin/bash
while read arg
do
	case ${arg} in
		000000042)
			echo 'sleep 10 && echo "`hostname`:' ${arg}'"  && false'
			;;
		*)
			echo 'sleep 10 && echo "`hostname`:' ${arg}'"  && true'
			;;
	esac
done < <(seq -w 100000000)
