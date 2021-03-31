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
select a.emp_no, b.first_name
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and a.to_date = '9999-01-01'
   and a.dept_no = (select dept_no
					  from dept_emp a, employees b
					 where a.emp_no = b.emp_no
					   and a.to_date = '9999-01-01'
					   and concat(b.first_name,' ',b.last_name) = 'Fai Bale');
