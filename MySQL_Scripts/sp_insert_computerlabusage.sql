USE COEAutomation;


#04-05-2018-14:52:50

DELIMITER //

CREATE PROCEDURE sp_insert_computerlabusage(IN sd_logged varchar(200),
											IN sd_workstation varchar(50),
                                            IN sd_console boolean,
                                            IN sd_labname varchar(50))
                                            
BEGIN

	DECLARE d_date datetime;
    
    SET d_date = str_to_date(sd_logged, '%m-%d-%Y-%H:%i:s');
    
    INSERT INTO ComputerLabUsage(logged_on,
								 work_station,
                                 console_active,
                                 lab_name)
	VALUES(d_date,
           sd_workstation,
           sd_console,
           sd_labname);
   
   
END //

DELIMITER ;