import os
import urllib

basedir = os.path.abspath(os.path.dirname(__file__))

# Configure Database URI: 

params = urllib.quote_plus("DRIVER={SQL Server};SERVER=jonhysql.database.windows.net;DATABASE=notejam;UID=jonhy@jonhysql;PWD=P@ssw0rd!")


class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    SQLALCHEMY_DATABASE_URI = "mssql+pyodbc:///?odbc_connect=%s" % params


class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True



class TestingConfig(Config):
    TESTING = True
    """
    Tests will run WAY faster using in memory SQLITE database
    See: https://docs.sqlalchemy.org/en/13/dialects/sqlite.html#connect-strings
    """
    SQLALCHEMY_DATABASE_URI = 'sqlite://'
