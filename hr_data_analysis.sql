-- Data analysis Questions

-- 1. What is the gender breakdown of employees in the company?
select termdate from hr_table;
	select gender, count(*) as count from hr_table
		where age >= 18  and termdate = '0000-00-00'
		group by gender;
        
-- 2. What is the race/ethnicity breakdown of employees in the company?

	select race, count(*) as count from hr_table
		where age >= 18  and termdate = '0000-00-00'
        group by race
        order by `count` desc;
-- 3. What is the age distribution of employees in the company?
		select
			min(age) as youngest,
            max(age) as oldest
		from hr_table
        where age >= 18  and termdate = '0000-00-00';
        
        select 
			case
				when age >= 18 and age<= 28 then '18 - 28 '
                when age >= 29 and age<= 39 then '19 - 39 '
                when age >= 40 and age<= 50 then '40 - 50 '
                when age >= 51 and age<= 60 then '51 - 60 '
			else '60+'
		end as age_group,gender, count(*) as count
        from hr_table
        where age >= 18  and termdate = '0000-00-00'
        group by age_group, gender
        order by age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?
select *from hr_table; 
select location, count(*) as count
from hr_table
where age >= 18  and termdate = '0000-00-00'
group by location;


-- 5. What is the average length of employment for employees who have been terminated?
select
	round(avg(datediff(termdate, hire_date))/365) as avg_length_employment
from hr_table
where termdate <= curdate() and termdate <> '0000:00:00';



-- 6. How does the gender distribution vary across departments and job titles?
select department, gender, count(*) as count
from hr_table
where age >= 18  and termdate = '0000-00-00'
group by department, gender
order by department;

-- 7. What is the distribution of job titles across the company?
select jobtitle, count(*) as count
from hr_table
where age >= 18  and termdate = '0000-00-00'
group by jobtitle
order by jobtitle;

-- 8. Which department has the highest turnover rate?
select department,
		total_count,
        terminated_count,
        terminated_count/total_count as termination_rate
from (
		select department,
        count(*) as total_count,
        sum(case when termdate <> '0000:00:00' and termdate <= curdate() then 1 else 0 end) as terminated_count
        from hr_table
        where age >= 18
        group by department
	) as subquery
order by termination_rate desc;

-- 9. What is the distribution of employees across locations by city and state?
select location_state, count(*) as count
from hr_table
where age >= 18  and termdate = '0000-00-00'
group by location_state
order by `count` desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?
select 
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/hires * 100, 2) as net_change_percent
from (
	select
		year(hire_date) as year,
        count(*) as hires,
        sum( case when termdate <> '0000-00-00' and termdate <=curdate() then 1 else 0 end)as terminations
	from hr_table
    where age >= 18
    group by year(hire_date)
    ) as subquery
order by year asc;


-- 11. What is the tenure distribution for each department?

SELECT 
    department,
    round(avg(datediff(termdate, hire_date)/365), 0) as avg_tenure
from hr_table
where termdate <= curdate() and termdate<>'0000:00:00' and age >=18
group by department;