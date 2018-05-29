import os

BASEDIR = os.path.abspath(os.path.dirname(__file__))
#SQLITE_DB = 'sqlite:///' + os.path.join(BASEDIR, 'db.sqlite')
SQLALCHEMY_TRACK_MODIFICATIONS = False

class Config(object):
    DEBUG = False
    SECRET_KEY = 'bf0926d3-1fd6-4d26-bb79-fb845c'

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    #SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL', SQLITE_DB)
    

    CELERY_TIMEZONE = 'Europe/Berlin'
    BROKER_URL = 'redis://redis:6379/0'
    CELERY_RESULT_BACKEND = 'redis://redis:6379/0'
    CELERY_SEND_TASK_SENT_EVENT = True


class DevelopmentConfig(Config):
    DEBUG = True
    #SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:admin@flask:3306/db'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')


class ProductionConfig(Config):
    pass

config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig
}
