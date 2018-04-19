USE COEAutomation;

DELIMITER //

CREATE PROCEDURE sp_pull_computer_lab_usage_all()

BEGIN

	SELECT clu_id,
           logged_on,
		   work_station,
           console_active,
           lab_name
    FROM ComputerLabUsage;
    
END //

DELIMITER ;