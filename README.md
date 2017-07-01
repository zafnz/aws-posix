# aws-posix
The biggest sin in the world, an aws RESTful API client using almost pure 
POSIX shell.

## Wait, what?
It's an aws cli client, using the AWS RESTful API, just like the 
official one, and uses almost *no* external programs, not perl,
python, xargs, etc. 

## But why????
Because I was bored.

## No, why??????
Told you, I got bored. I decided to try my hand at writing an aws shell 
client, because all the other ones were using those kiddy high level 
languages and no true scotsman uses anything but POSIX shell.

## Ok, you must use some programs...

It only uses the following external dependencies:
* tr: Because damn I love that.
* sed: The world wouldn't operate without it
* basename: I really don't need it, but it's useful for testing some
... stuff
* openssl: Because implementing crypto in shell script is.... tricky.
... Only use dgst -sha256 and dgst -mac functionality
* curl: Technicalllly... I could get away with not using it, if 
used s\_client, and wrote a pure uri-encode function.  


# Does it work?
Well....... technically????

Currently one command works, route53 list-zones... just.

It also only outputs XML, because that's all AWS exposes

# I.... I.... I just can't
I know. Hush... It's ok... Go back to Visual Basic, it's ok...


