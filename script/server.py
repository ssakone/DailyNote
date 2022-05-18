import os

from PySide2.QtCore import *
from PySide2.QtWebSockets import *
import http.server
import socketserver
from threading import Thread
import random

ip = "localhost"

def launchServer():
	PORT = 8000

	Handler = http.server.SimpleHTTPRequestHandler

	with socketserver.TCPServer(("", PORT), Handler) as httpd:
		print("serving at port", PORT)
		httpd.serve_forever()

app = QCoreApplication([])
watcher = QFileSystemWatcher()
if "script" in os.getcwd():
	os.chdir('..')
socket = QWebSocket()
socket.open(QUrl("ws://{}:8001".format(ip)))
socket.connected.connect(lambda: socket.sendTextMessage('{"status": 0, "message": "Hello World"}'))

def sendUpdate(filename):
	print("update {} detected".format(filename))
	socket.sendTextMessage('{"status": 1, "filename": "'+filename+'", "safe": '+str(random.randrange(0,9999999))+'}')
	watcher.addPath(filename)
watcher.fileChanged.connect(sendUpdate)

for path, subdirs, files in os.walk(os.getcwd()):
	for name in files:
		if name.endswith('.qml'):
			p = os.path.join(path, name).replace("\\","/")
			watcher.addPath(p)
Thread(target=launchServer).start()

app.exec_()
