from notejam import app
import urllib
import logging
# Configure Database URI: 

params = urllib.quote_plus("DRIVER={SQL Server};SERVER=jonhysql.database.windows.net;DATABASE=notejam;UID=jonhy@jonhysql;PWD=P@ssw0rd!")


app.config['SQLALCHEMY_DATABASE_URI'] = "mssql+pyodbc:///?odbc_connect=%s" % params
logging.basicConfig(filename='log.log',level=logging.DEBUG)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
