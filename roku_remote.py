import requests
import sys

tv_address = sys.argv[1]
command = sys.argv[2]
text = sys.argv[3] if len(sys.argv) > 3 else None
headers = {'Content-Type': 'application/x-www-form-urlencoded'}

COMMANDS = {'home': 'Home', 'rev': 'Rev', 'fwd': 'Fwd', 'play': 'Play', 'select': 'Select',
            'left': 'Left', 'right': 'Right', 'down': 'Down', 'up': 'Up', 'back': 'Back',
            'replay': 'InstantReplay', 'info': 'Info', 'backspace': 'Backspace',
            'search': 'Search', 'enter': 'Enter', 'find': 'FindRemote', 'volup': 'VolumeUp',
            'voldown': 'VolumeDown', 'mute': 'VolumeMute', 'power': 'PowerOff',
            'upchan': 'ChannelUp', 'downchan': 'ChannelDown', 'input': 'InputTuner',
            'text': text}

def send_text(text):
    for key in text:
        response = requests.post(
            f'http://{tv_address}:8060/keypress/Lit_{key}', headers=headers)
        print("Sent: " + key)

def send_key(key):
    response = requests.post(f'http://{tv_address}:8060/keypress/{key}', headers=headers)
    print("Sent: " + key)

if command not in COMMANDS:
    print(f'Invalid command: {command}')
    sys.exit()

key = COMMANDS[command]
if key == 'text':
    send_text(text)
else:
    send_key(key)
