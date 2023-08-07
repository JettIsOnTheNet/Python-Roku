import requests
import sys

class RokuRemote:
    def __init__(self, tv_address, command, text=None):
        self.tv_address = tv_address
        self.command = command
        self.text = text
        self.headers = {'Content-Type': 'application/x-www-form-urlencoded'}
        self.COMMANDS = {'home': 'Home', 'rev': 'Rev', 'fwd': 'Fwd', 'play': 'Play', 'select': 'Select',
                         'left': 'Left', 'right': 'Right', 'down': 'Down', 'up': 'Up', 'back': 'Back',
                         'replay': 'InstantReplay', 'info': 'Info', 'backspace': 'Backspace',
                         'search': 'Search', 'enter': 'Enter', 'find': 'FindRemote', 'volup': 'VolumeUp',
                         'voldown': 'VolumeDown', 'mute': 'VolumeMute', 'power': 'PowerOff',
                         'upchan': 'ChannelUp', 'downchan': 'ChannelDown', 'input': 'InputTuner',
                         'text': self.text}

    def send_text(self, text):
        for key in text:
            response = requests.post(
                f'http://{self.tv_address}:8060/keypress/Lit_{key}', headers=self.headers)
            print("Sent: " + key)

    def send_key(self, key):
        response = requests.post(f'http://{self.tv_address}:8060/keypress/{key}', headers=self.headers)
        print("Sent: " + key)

    def execute(self):
        if self.command not in self.COMMANDS:
            print(f'Invalid command: {self.command}')
            sys.exit()

        key = self.COMMANDS[self.command]
        if key == 'text':
            self.send_text(self.text)
        else:
            self.send_key(key)
