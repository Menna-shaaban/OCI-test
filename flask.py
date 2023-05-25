from flask import Flask as flask , render_template, url_for, request
import os
import socket
import cx_Oracle
import json

app=flask(__name__)

@app.rout('/')

def O_ATP():
    os.environ['TNS_ADMIN'] = ""
    connection=cx_Oracle.connect=("")
    cursor = connection.cursor()
    for data in cursor.execute("select * from *"):
        result=result+str(data)
        return(data)
    connection.commit()
    connection.close()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)



    