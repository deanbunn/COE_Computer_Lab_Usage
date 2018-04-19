
import pymysql
import rds_config

#Var for RDS Connection
rds_dbhost = rds_config.db_host
rds_dbname = rds_config.db_name
rds_dbuser = rds_config.db_username
rds_dbpwd = rds_config.db_password

#Make Connection to RDS Instance
coedbcon = pymysql.connect(rds_dbhost, user=rds_dbuser, passwd=rds_dbpwd, db=rds_dbname, connect_timeout=5)

def handler(event,context):

    #Var for Return Status
    rtn_status = ""

    #Initialize DB Cursor
    coedbcr = coedbcon.cursor()

    if(event['logged'] and len(event['logged']) > 0 and
       event['workstation'] and len(event['workstation']) > 0 and
       event['console'] and len(event['console']) > 0 and
       (event['console'] == "0" or event['console'] == "1") and
       event['lab'] and len(event['lab']) > 0):
        
        #Var for Stored Procedure Call
        labusage_sp = ("CALL sp_insert_computerlabusage('" +
                        event['logged'] + "','" +
                        event['workstation'] + "'," +
                        event['console'] + ",'" +
                        event['lab'] + "')")

        #Call SP
        coedbcr.execute(labusage_sp)
        coedbcon.commit()







    #Close Out Cursor   
    coedbcr.close()


    return rtn_status






