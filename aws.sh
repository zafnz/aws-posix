#!/bin/sh
#
# Copyright 2017 Nick Clifford.... who probably shouldn't admit to
#    writing this.
#
# Licence: GPLv3 - because why not, sounds good to me.
#
# Oh dear god the most masochistic thing ever. Part of the AWS API implemented
# in POSIX shell.
#
# The rules:
# It's POSIX shell. Not bash. shell.
# Use as few external programs as possible. And no, call perl, python, 
# or aws cli is not allowed
#
# Current external dependencies:
#
# tr: It's quite useful and found many places. It can do a few things sed can't.
# sed: I'm not sure this world could cope without sed.
# dirname: purely for simplicity in script locations.
# openssl: Ok. *YOU* write sha256 and HMAC in shell. Go on. I'm waiting.
# curl: I'm not even sure you *can* write curl in shell. Although, technically
#    we can do the https with openssl, so therefore can *possibly* replace curl.
#
# 
#
# And that's it for now.
# 
# What's working?
# route53: HostedDomain.
#
# ... yeah... that's about it.
# 

# Require you to specify the full path to the script, because fuck
# you I don't know how to figure it out.
rootdir=$(dirname $0)

. $rootdir/lib/common
. $rootdir/lib/request
. $rootdir/lib/route53
. $rootdir/lib/selftest

# Globals:
aws_timestamp=$(date -u '+%Y%m%dT%H%M%SZ' )
aws_date=$(date -u '+%Y%m%d' )
aws_dry_run=1

read_aws_config


usage() {
	echo "$0 <options> <command> [<command-options>]

An AWS RESTful API client, written in POSIX shell.
Outputs debugging information in debug.txt

 --really     Actually does contact aws

Avaialble commands:

 *  test: self testing
 *  route53

That is all. 
"
	exit 1
}

echo "*****" > debug.txt


exit=
while [ -z "$exit" -a ! -z "$1" ]; do
	case "$1" in
	--really)
		# Default to safe 
		aws_dry_run=0 
		;;
	--help) 
		usage 
		;;
	--show-leaks)
		show_leaks=1
		;;
	-*) 
		echo "Unknown options"
		usage 
		;;
	*)
		exit=1
	esac
	[ -z "$exit" ] && shift
done


cmd=$1
[ -z "$cmd" ] && usage
shift

case "$cmd" in
"test") selftest "$@" ;;
route53) route53 "$@" ;;
test) selftest "$@" ;;
*) usage ;;
esac

if [ "$show_leaks" = "1" ]; then
	aws_secret_access_key=""
	aws_access_key_id=""
	set
fi
exit 0

