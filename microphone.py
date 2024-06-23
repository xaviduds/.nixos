import os

print(str(os.system("amixer -M get Master | awk -F'[\\[\\]]' 'END{print $2}")).strip())
