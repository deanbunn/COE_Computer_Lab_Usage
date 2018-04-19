USE COEAutomation;

CREATE TABLE ComputerLabUsage
(
	clu_id bigint not null auto_increment,
    logged_on datetime not null,
    work_station varchar(50),
    console_active boolean,
    lab_name varchar(50),
    primary key (clu_id)
)

