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


















