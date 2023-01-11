# Roku-Remote - Python - Ruby - Swift
This program is a simple command-line utility for sending remote control commands to a Roku TV, made for automation of the TV from anything that can run Python, Ruby or Swift. (Since I have ported it. ;) )

It takes four inputs from the command line:
 - The IP address of the TV (tv_address)
 - The command to run (command)
 - Optional: text input trigger (text)
 - Optional: text value to send

If the command is text, it will send the provided text input, one character at a time, just as a remote works, using the same method as above but with an additional 'Lit_' prefix to the key name.

*EXAMPLES*

`python roku_remote.py 10.0.0.10 mute`

`python roku_remote.py 172.16.0.8 select`

`python roku_remote.py 192.168.1.105 text youtube`
