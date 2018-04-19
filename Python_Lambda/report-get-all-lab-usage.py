
import pymysql
import json
import rds_config

#Var for RDS Connection
rds_dbhost = rds_config.db_host
rds_dbname = rds_config.db_name
rds_dbuser = rds_config.db_username
rds_dbpwd = rds_config.db_password

#Make Connection to RDS Instance
coedbcon = pymysql.connect(rds_dbhost, user=rds_dbuser, passwd=rds_dbpwd, db=rds_dbname, connect_timeout=5)

def handler(event,context):

    #Initialize DB Cursor
    coedbcr = coedbcon.cursor()

    #Call Stored Procedure
    coedbcr.callproc("sp_pull_computer_lab_usage_all",())

    #Commit to Get Current Values (No Cached)
    coedbcon.commit()

    #Fetch Results of Query
    tdb_rslt = coedbcr.fetchall()

    #Report List
    rlLabUsageRpt = []

    #Cycle Through Table Result 
    for rptEntry in tdb_rslt:

        wsData = {'id':'','logged':'','workstation':'','console':0,'lab':'' }
        wsData['id'] = str(rptEntry[0])
        wsData['logged'] = rptEntry[1].strftime('%Y-%m-%d %H:%M:%S')
        wsData['workstation'] = str(rptEntry[2])
        wsData['console'] = rptEntry[3]
        wsData['lab'] = str(rptEntry[4])
        
        rlLabUsageRpt.append(wsData)




    #Close Out Cursor   
    coedbcr.close()


    return rlLabUsageRpt






