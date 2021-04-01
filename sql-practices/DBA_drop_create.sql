drop database employees;
drop user 'employees'@'localhost';

--

create database cdmall;
create user 'cdmall'@'localhost' identified by 'cdmall';
grant all privileges on cdmall.* to 'cdmall'@'localhost';
flush privileges;