-- ex1) salarties 테이블에서 현재 전체 평균급여 출력

select avg(salary), max(salary)
  from salaries
 where to_date = '9999-01-01';
 
-- error: 반환값이 하나인 함수와 데이터가 여러개인 emp_no
select emp_no, max(salary)
  from salaries
 where to_date = '9999-01-01';
 
-- ex2) salaries 테이블에서 사번이 10060인 직원의 급여 평균과 총합계를 출력
select avg(salary),sum(salary)
  from salaries
 where emp_no = 10060;
 
-- ex3) 최저 임금 받은 시기와 최대 임금을 받은 시기를 각각 출력
-- select에 집계함수가 있으면 다른 column은 올 수 없음
-- 따라서 "받은 시기"는 조인이나 서브쿼리 통해서 구해야 함

-- ex4) dept_emp 테이블에서 현재 d008에 근무하는 인원수 출력
select count(*)
  from dept_emp
 where dept_no = 'd008'
   and to_date = '9999-01-01';

-- ex5) 각 사원별로 평균 연봉 출력
  select emp_no,avg(salary) as avg_salary
    from salaries
group by emp_no
order by avg(salary) desc;

-- ex6) salaries 테이블 현재 직원별로 평균급여가 35000 이상인 직원의 
-- 평균 급여를 큰순으로 출력
  select emp_no,avg(salary) as avg_salary
    from salaries
   where to_date = '9999-01-01'
group by emp_no
  having avg(salary) >= 35000
order by avg(salary) desc;

-- ex7) 사원별로 몇번의 직책 변경이 있었는지 출력
  select emp_no, count(title)
    from titles
group by emp_no;

-- ex8) 현재 직책별로 직원 수를 구하되 직원수가 100명 이상인 직책만 출력
  select title, count(*) as cnt
    from titles
   where to_date = '9999-01-01'
group by title
  having cnt > 100
order by cnt desc;

-- 현재 근무하고 있는 여직원의 이름과 직책을 직원 이름 순으로 출력
  select a.first_name, b.title
    from employees a,titles b             -- alias a, b 사용법
   where a.emp_no = b.emp_no				-- inner equi join condition
     and b.to_date = '9999-01-01'			-- 새로 만들어진 테이블에 select condition
     and a.gender = 'F'
order by a.first_name;

-- 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균 급여 출력 
  select a.dept_no,d.dept_name,avg(b.salary) as avg_salary
    from dept_emp a, salaries b, titles c, departments d
   where a.emp_no = b.emp_no				-- join condition
     and b.emp_no = c.emp_no				-- join condition
     and a.dept_no = d.dept_no				-- join condition
     and a.to_date = '9999-01-01'			-- select condition
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and c.title = 'Engineer'
group by a.dept_no
order by avg_salary desc;

-- 현재, Engineer을 제외한 직책별로 급여의 총합 출력
-- 단 총합이 2000000000 이상인 직책만 나타내며 급여의 통합에 대해서는 내림차순으로 정렬
  select a.title, count(a.emp_no) as members, sum(b.salary) as sum_salary
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
     and a.title != 'Engineer'
group by a.title
  having sum_salary >= 2000000000
order by sum_salary desc;




















