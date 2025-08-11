import psycopg2

def execute_query(connection, query):
    """
    1. the function has one argument, called connection
    2. construct a cursor
    3. execute the query
    4. fetch the result
    5. close the cursor and connection
    """    
    cursor = connection.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    for row in result:
        print(row)
    cursor.close()
    connection.close()
    return result


def create_connection():
    """
    1. link to postgres DB
    2. establish the environment parameter of the template
    """    
    try:
        conn = psycopg2.connect(
            dbname="postgres",
            user="postgres",
            password="raspberry",
            host="host.docker.internal",
            port="5432"
        )
        return conn
    except psycopg2.Error as e:
        print(f"Error connecting to the database: {e}")
        return None
        

def get_allstations():
    conn = create_connection()
    cursor = conn.cursor()
    query = """
    SELECT "stationName" FROM station_info;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    for row in result:
        print(row)
    cursor.close()
    conn.close()
    return result