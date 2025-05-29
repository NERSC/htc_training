#!/bin/bash
while read arg
do
	case ${arg} in
		000042)
			echo 'sleep 1 && echo "`hostname`:' ${arg}'"  && false'
			;;
		*)
			echo 'sleep 1 && echo "`hostname`:' ${arg}'"  && true'
			;;
	esac
done < <(seq -w 100000)
