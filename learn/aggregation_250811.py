import psycopg2
import tools

def main():
    # conn = tools.create_connection()
    # if conn:
    #     print("Successfully connected to the database!")
    #     query = """
    #     SELECT COUNT(*)
    #     FROM station_number LEFT JOIN station_info ON "staCode" = "stationCode"
    #     WHERE "stationName" = '基隆';
    #     """
    #     tools.execute_query(conn, query)
    #     conn.close()
    #     print("Connection closed.")
    # else:
    #     print("Failed to connect to the database.")
    tools.get_allstations()


if __name__ == "__main__":
    main()

