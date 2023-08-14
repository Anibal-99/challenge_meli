import MySQLdb


def connection(name, host, port, username, password):
    try:
        return MySQLdb.connect(
            db=name,
            user=username,
            passwd=password,
            host=host,
            port=port,
        )
    except Exception as e:
        print(f"Error al conectar a la base de datos {e}")


def get_cursor(name, host, port, username, password):
    con = connection(
        name=name, host=host, port=port, username=username, password=password
    )
    cursor = con.cursor()
    return con, cursor


def close_cursor(con, cursor):
    con.commit()
    cursor.close()
    con.close()
