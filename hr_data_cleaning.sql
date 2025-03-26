create database if not exists human_resources;

describe hr_table;
truncate table hr_table;

show global variables like 'local_infile';

set global local_infile=1;

load data local infile  "path_to_your_file.csv"
into table YourTable
fields terminated by ','
ignore 1 lines;

select *from hr_table limit 10;

-- changing column name
alter table hr_table
change column ï»¿id emp_id varchar(20)null;

-- changing dateformat from text to date
select birthdate from hr_table;

update hr_table
set birthdate = case
					-- when birthdate like '%/%' then str_to_date(birthdate, '%m/%d/%Y')
					-- when birthdate like '%-%' then str_to_date(birthdate, '%m-%d-%Y')
                    
                    when birthdate like '%/%' then str_to_date(birthdate, '%Y-%m-%d')
					when birthdate like '%-%' then str_to_date(birthdate, '%Y-%m-%d')
                    else null
end;
                
	-- changing the datatype of datebirth column to date
    alter table hr_table
    modify column birthdate date;
    
    
update hr_table    
set hire_date = case
				-- when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
				-- when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
                    
                    when hire_date like '%/%' then str_to_date(hire_date, '%Y-%m-%d')
					when hire_date like '%-%' then str_to_date(hire_date, '%Y-%m-%d')
                    else null
end;

select hire_date from hr_table;

-- changing the datatype of column hire_date to date from text
alter table hr_table
modify column hire_date date;

-- update hr_table
-- set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
-- where termdate is not null and termdate !='';

update hr_table
set termdate = if(termdate is not null and termdate !='', date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')),
'0000-00-00')
where true;

-- The following query is used to change the security setting to allow invalid date formats for one time only
set sql_mode = 'ALLOW_INVALID_DATES';

select termdate from hr_table;

alter table hr_table
modify column termdate date;

-- Adding age column into the table
alter table  hr_table add column age int ;

-- updating the table by calculating the age
update hr_table
set age = timestampdiff(year, birthdate, curdate());

select birthdate, age from hr_table;

select min(age)as youngest,
		max(age)as oldest
	from hr_table;

-- the result of the following query is not going to be used for analysis    
-- select count(*) from hr_table where age < 18;


        


