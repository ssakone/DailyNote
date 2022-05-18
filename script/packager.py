import sys
from  base64 import b64encode as e64 
import os

# data = {
# 	"config.json":"",
# 	"Main.qml":"",
# 	"controlleur": {
# 		""
# 	}
# }

if sys.argv[1] == "":
	print("no folder given")

package_folder = sys.argv[1]
controlleur = os.listdir(os.path.join(package_folder,'qml/SpeedNote/controlleur'))
views = os.listdir(os.path.join(package_folder,'qml/SpeedNote/views'))
model = os.listdir(os.path.join(package_folder,'qml/SpeedNote/model'))
assets = os.listdir(os.path.join(package_folder,'qml/SpeedNote/assets'))

main = open(os.path.join(package_folder,'qml/SpeedNote/Main.qml'),'rb').read()

data = {
	"config.json":e64(open(os.path.join(package_folder,'config.json'),'rb').read()),
	"Main.qml":e64(open(os.path.join(package_folder,'qml/SpeedNote/Main.qml'),'rb').read()),
	"controlleur": {},
	"model": {},
	"views": {},
	"assets": {}
}
for file in controlleur:
	data['controlleur'][file] = e64(open(os.path.join(os.path.join(package_folder,'qml/SpeedNote/controlleur'), file), 'rb').read())

for file in views:
	data['views'][file] = e64(open(os.path.join(os.path.join(package_folder,'qml/SpeedNote/views'), file), 'rb').read())

for file in model:
	data['model'][file] = e64(open(os.path.join(os.path.join(package_folder,'qml/SpeedNote/model'), file), 'rb').read())

for file in assets:
	data['assets'][file] = e64(open(os.path.join(os.path.join(package_folder,'qml/SpeedNote/assets'), file), 'rb').read())

open(os.path.join(package_folder,'Package.bm'),'wb').write(e64(str(data).encode()))

print('packaged')

#print(base64.b64encode(b'enokas'))