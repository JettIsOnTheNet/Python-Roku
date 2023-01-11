import Foundation

let tvAddress = CommandLine.arguments[1]
let command = CommandLine.arguments[2]
var text: String? = nil
if CommandLine.argc > 3 {
    text = CommandLine.arguments[3]
}
let headers = ["Content-Type": "application/x-www-form-urlencoded"]

let COMMANDS = [
    "home": "Home",
    "rev": "Rev",
    "fwd": "Fwd",
    "play": "Play",
    "select": "Select",
    "left": "Left",
    "right": "Right",
    "down": "Down",
    "up": "Up",
    "back": "Back",
    "replay": "InstantReplay",
    "info": "Info",
    "backspace": "Backspace",
    "search": "Search",
    "enter": "Enter",
    "find": "FindRemote",
    "volup": "VolumeUp",
    "voldown": "VolumeDown",
    "mute": "VolumeMute",
    "power": "PowerOff",
    "upchan": "ChannelUp",
    "downchan": "ChannelDown",
    "input": "InputTuner",
    "text": text
]

func sendText(_ text: String) {
    for key in text {
        guard let char = key.unicodeScalars.first else { continue }
        let key = "Lit_\(char)"
        let url = URL(string: "http://\(tvAddress):8060/keypress/\(key)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        let task = URLSession.shared.dataTask(with: request) { _, _, _ in }
        task.resume()
        print("Sent: \(key)")
    }
}

func sendKey(_ key: String) {
    let url = URL(string: "http://\(tvAddress):8060/keypress/\(key)")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    let task = URLSession.shared.dataTask(with: request) { _, _, _ in }
    task.resume()
    print("Sent: \(key)")
}

guard let key = COMMANDS[command] else {
    print("Invalid command: \(command)")
    exit(0)
}

if key == "text" {
    guard let text = text else {
        print("No text provided for command 'text'")
        exit(0)
    }
    sendText(text)
} else {
    sendKey(key)
}
