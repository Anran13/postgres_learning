import psycopg2
from dotenv import load_dotenv
import os

load_dotenv()

def connection():
    """
    1. link to cloud postgres DB
    2. before linkage, enter the user name and password
    3. if the user name and password match to the correct answer, then connected to the database
    """    
    
    user_name = str(input("Please enter your user name: "))
    user_password = str(input("Please enter your password: "))
    
    if (user_name != os.getenv("USER")) or (user_password != os.getenv("PASSWORD")):
        print(f"Error user name or password!")
        connection()

    else:
        try:
            conn = psycopg2.connect(
                dbname=os.getenv("DBNAME"),
                user=os.getenv("USER"),
                password=os.getenv("PASSWORD"),
                host=os.getenv("HOST"),
                port="5432"
            )
            if conn:
                print("Successfully connected to the database!")
            return conn
        
        except psycopg2.Error as e:
            print(f"Error connecting to the database: {e}")
            return None


def main():
    conn = connection()
    cursor = conn.cursor()
    query = """
    SELECT count(*) FROM station_info;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    print(result)
    cursor.close()
    conn.close()


if __name__ == "__main__":
    main()