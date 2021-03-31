################ Subquery ##################

-- ex1.1)
-- 현재 Fai Bale이 근무하는 부서의 전체 직원의 이름과 사번과 이름을 출력
  select dept_no
    from dept_emp a, employees b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and concat(b.first_name,' ',b.last_name) = 'Fai Bale';

  select a.emp_no, b.first_name
    from dept_emp a, employees b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and a.dept_no = 'd004';


-- ex1.2) subquery
-- where 조건식에 subquery가 단일행인 경우: =, !=, >, <, >=, <=
select a.emp_no, b.first_name
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and a.to_date = '9999-01-01'
   and a.dept_no = (select dept_no						# 단일행 조건식
					  from dept_emp a, employees b
					 where a.emp_no = b.emp_no
					   and a.to_date = '9999-01-01'
					   and concat(b.first_name,' ',b.last_name) = 'Fai Bale');

-- ex2) 현재 전체 사원의 평균 연봉보다 적은 급여를 받는 사원들의 이름, 급여를 출력 
   select concat(b.first_name,' ',b.last_name), a.salary
     from salaries a, employees b
    where a.emp_no = b.emp_no
      and a.to_date = '9999-01-01'
	  and salary < (select avg(salary)
					  from salaries
					 where to_date = '9999-01-01')
 order by a.salary desc;


# where의 조건식에 서브쿼리를 사용하고 결과가 다중행인 경우 							# 다시 보기!
# in(not in)
# any: =any(in 동일), >any, <any, <>any(!=any), <=any, >=any
# all: =all, >all, <all, <>all(!=in, not in), <=all, >=all

-- ex3.1) join
-- 현재 급여가 50000 이상인 직원의 이름과 급여를 출력
  select a.first_name, b.salary
	from employees a, salaries b
   where a.emp_no = b.emp_no
     and b.to_date = '9999-01-01'
	 and b.salary >= 50000
order by salary;

-- ex3.2) subquery (멀티 행/열)
  select a.first_name, b.salary
	from employees a, salaries b
   where a.emp_no = b.emp_no
     and b.to_date = '9999-01-01'
	 and (a.emp_no, b.salary) =any (select emp_no, salary			# where절에 넣기 
									  from salaries
									 where to_date = '9999-01-01'
									   and salary >= 50000);

-- ex3.3) subquery (멀티 행/열)
  select a.first_name, b.salary
	from employees a, salaries b
   where a.emp_no = b.emp_no
     and b.to_date = '9999-01-01'
	 and (a.emp_no, b.salary) in (select emp_no, salary				# =any == in(...)
									  from salaries
									 where to_date = '9999-01-01'
									   and salary >= 50000)
order by b.salary;		# order by가 있으면 시간 소모가 큼

-- ex3.2) subquery (멀티 행/열)
  select a.first_name, b.salary
	from employees a,
		 (select emp_no, salary					# 하나의 테이블로 만들어서 구현하기 
			from salaries
		   where to_date = '9999-01-01'
			 and salary >= 50000) b
   where a.emp_no = b.emp_no
order by b.salary;

-- ex4.1) subquery
-- 현재 가장 적은 평균급여의 직책과 그 평균급여를 출력 

-- min wage
  select title, round(avg(salary)) as avg_salary
	from titles a, salaries b
   where a.emp_no = b.emp_no
	 and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
group by title
  having avg_salary = (select min(avg_salary)
					     from (  select title, round(avg(salary)) as avg_salary
								   from titles a, salaries b
								  where a.emp_no = b.emp_no
								    and a.to_date = '9999-01-01'
								    and b.to_date = '9999-01-01'
							   group by title) a);





# 강사님 코드
  select a.title, round(avg(salary)) as avg_salary						# 다시 고치기!
    from titles a, salaries b
   where a.emp_no = b.emp_no
	 and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by a.title
  having avg_salary = (select min(avg_salary)
						 from (  select a.title, round(avg(salary)) as avg_salary
								   from titles a, salaries b
								  where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
							   group by a.title) a);

-- ex4.2) top-k									# limit 사용: 0(처음)부터, 1(횟수)
  select b.title, round(avg(salary)) as avg_salary
    from salaries a, titles b
   where a.emp_no = b.emp_no
	 and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
group by b.title
order by avg_salary asc
   limit 0, 1;									# 한마디로 물리적으로 다음으로 진행을 안한것 

-- ex5)
-- 현재 각 부서별로 최고 급여를 받는 사원의 이름과 급여를 출력 
select dept_name as '부서', concat(a.first_name,' ',a.last_name) as '이름', max_salary as '급여'
	from employees a, 
		 salaries b, 
         dept_emp c, 
         departments d,
         (  select dept_no, max(salary) as max_salary	# 부서별 최고급여 테이블
			  from dept_emp a, salaries b
			 where a.emp_no = b.emp_no
			   and a.to_date = '9999-01-01'
			   and b.to_date = '9999-01-01'
		  group by a.dept_no) e							# alias 'e'
   where a.emp_no = b.emp_no
	 and b.emp_no = c.emp_no
	 and c.dept_no = d.dept_no
     and d.dept_no = e.dept_no			# subquery e와 Join
     and salary = max_salary			# 최고급여와 비교, join
	 and b.to_date = '9999-01-01'
	 and c.to_date = '9999-01-01'
order by max_salary desc;

-- sol5) 먼저 부서당 최고연봉(max salary)을 구한다 
select dept_no, max(salary) as max_salary
from dept_emp a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.dept_no;




# 강사님 코드
-- max_salary먼저 구함 
  select a.dept_no, max(b.salary) as max_salary
	from dept_emp a, salaries b
   where a.emp_no = b.emp_no
	 and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
group by a.dept_no;

-- answer5) 																# 다시해보기!
select a.first_name, d.dept_name, c.salary
from employees a, 
	 dept_emp b, 
     salaries c, 
     departments d,
     ( select a.dept_no, max(b.salary) as max_salary	# from에 테이블 subquery
		  from dept_emp a, salaries b					# 안에 쿼리는 이미 위에 구동 확인됨 
	     where a.emp_no = b.emp_no						# alias 중복을 걱정할 필요 없다.
		   and a.to_date = '9999-01-01'
		   and b.to_date = '9999-01-01'
	  group by a.dept_no) e								# e로 alias
where a.emp_no = b.emp_no								# equi join
and b.emp_no = c.emp_no
and b.dept_no = d.dept_no
and b.dept_no = e.dept_no
and c.salary = e.max_salary
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
order by c.salary desc;








