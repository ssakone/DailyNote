from flask import Flask, request
from peewee import *

db = SqliteDatabase('_storeDb.db')

class Modules(Model):
    name = CharField()
    version = CharField()
    description = TextField()
    lastUpdate = DateField()
    createdAt = DateField(default=datetime.datetime.now)
    dependencies = TextField()
    path = CharField()

    class Meta:
        database = db # This model uses the "people.db" database.

app = Flask(__name__)


@app.route('/')
def index():
	return '200 Ok'


@app.route('/createModules', )



app.run(debug=True)