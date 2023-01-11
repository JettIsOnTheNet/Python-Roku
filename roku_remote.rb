require 'net/http'

tv_address = ARGV[0]
command = ARGV[1]
headers = { 'Content-Type' => 'application/x-www-form-urlencoded' }

COMMANDS = { 'home' => 'Home', 'rev' => 'Rev', 'fwd' => 'Fwd', 'play' => 'Play', 'select' => 'Select',
            'left' => 'Left', 'right' => 'Right', 'down' => 'Down', 'up' => 'Up', 'back' => 'Back',
            'replay' => 'InstantReplay', 'info' => 'Info', 'backspace' => 'Backspace',
            'search' => 'Search', 'enter' => 'Enter', 'find' => 'FindRemote', 'volup' => 'VolumeUp',
            'voldown' => 'VolumeDown', 'mute' => 'VolumeMute', 'power' => 'PowerOff',
            'upchan' => 'ChannelUp', 'downchan' => 'ChannelDown', 'input' => 'InputTuner',
            'text' => 'text' }

def send_text(tv_address, headers, text)
  text.each_char do |key|
    key = "Lit_#{key}"
    uri = URI("http://#{tv_address}:8060/keypress/#{key}")
    req = Net::HTTP::Post.new(uri, headers)
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    puts "Sent: #{key}"
  end
end

def send_key(tv_address, headers, key)
    uri = URI("http://#{tv_address}:8060/keypress/#{key}")
    req = Net::HTTP::Post.new(uri, headers)
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    puts "Sent: #{key}"
end

if ARGV.count < 2
  puts "You must pass two arguments: the IP address of the TV and the command."
  exit
end

if command == 'text' && ARGV.count < 3
  puts "You must pass the text to send when using the 'text' command."
  exit
end

if command == 'text'
  text = ARGV[2]
  send_text(tv_address, headers, text)
else
  key = COMMANDS[command]
  if key.nil?
    puts "Invalid command: #{command}"
    exit
  else
    send_key(tv_address, headers, key)
  end
end
