import mysql.connector
import click
from flask import current_app
from flask import g

def get_db():
    """Connect to the application's configured database. The connection
    is unique for each request and will be reused if this is called
    again.
    """
    mydb = mysql.connector.connect(
            host="10.3.94.3", user='flaskapp', password='soopersecret', database='flaskdb'
        )
    print("Connected db:")
    
    return mydb


def close_db(e=None):
    """If this request connected to the database, close the
    connection.
    """
    db = g.pop("db", None)

    if db is not None:
        db.close()


def init_db():
    """Clear existing data and create new tables."""
    db = get_db()
    cursor = db.cursor()

    with current_app.open_resource("schema.sql") as f:
        sqlscript = f.read().decode("utf8")
        print(f"executing {sqlscript}")
        result = cursor.execute(sqlscript, multi=True)
        #pdb.set_trace()
        print("completed script")
        for r in result:
            print(r)
    
    print("Check:")
    checkresults = cursor.execute('SELECT title from post LIMIT 1;')
    for r in cursor.fetchall():
        print(r)

    

@click.command("init-db")
def init_db_command():
    """Clear existing data and create new tables."""
    init_db()
    click.echo("Initialized the database.")


def init_app(app):
    """Register database functions with the Flask app. This is called by
    the application factory.
    """
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)
