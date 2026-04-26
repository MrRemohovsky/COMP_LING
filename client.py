import requests

url = "http://127.0.0.1:8000/aZj6awUBVn/"

wav_file = "1.wav"

with open(wav_file, 'rb') as f:
    files = {'file': (wav_file, f, 'audio/wav')}
    r = requests.post(url, files=files)

print("Ответ сервера:", r.text)
