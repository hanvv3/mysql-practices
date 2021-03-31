
############# Join ##############

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

#########################################
-- ANSI/ISO SQL 1999 JOIN 문법

# inner join : 가장 많이 쓰임 
-- join ~ on
-- ex) 현재 근무하고 있는 여직원의 이름과 직책을 직원 이름 순으로 출력
  select a.first_name, b.title
    from employees a 
    join titles b 							-- join ~ on (표준 문법)
      on a.emp_no = b.emp_no				-- join condition -이걸 더 권장하지만 equi가 편함
   where b.to_date = '9999-01-01'			-- select condition
     and a.gender = 'F'
order by a.first_name;

-- natural join
      select a.first_name, b.title
        from employees a 
natural join titles b 							-- natural join
       where b.to_date = '9999-01-01'			-- select condition
         and a.gender = 'F'
    order by a.first_name;

-- ex) join~on vs natural join
select count(*)							-- 240124
  from titles a
  join salaries b
    on a.emp_no = b.emp_no				-- 좀 귀찮음.. 
 where a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01';

      select count(*)					-- 4
        from titles a
natural join salaries b					-- 같은 이름의 모든 변수를 대상 
       where a.to_date = '9999-01-01'
         and b.to_date = '9999-01-01';
-- join조건에서 변수의 이름이 같을 경우 자동으로 Join시켜주기 때문에 결과가 누락된다.

-- join ~ using : natural join 이랑 비슷 
select count(*)
  from titles a
  join salaries b
 using (emp_no)						-- 두개의 테이블의 같은 변수 이름을 특정
 where a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01';

# outer join : 표준 문법만 가능
-- ex) 데이터 입력 (동영상 보고 다시 해보기)
-- inserting test data: 
############# 아직 ERD를 통해 모델을 만들지 않음 #############
insert into dept values(null, '총무');
insert into dept values(null, '개발');
insert into dept values(null, '영업');

insert into emp values(null, '둘리', 2);
insert into emp values(null, '마이콜', 3);
insert into emp values(null, '또치', 2);
insert into emp values(null, '도우넛', 3);
insert into emp values(null, '길동', null);
select * from dept;
select * from emp;

-- ex) 현재 회사의 직원의 이름과 부서 이름을 출력
select a.name,b.name
  from emp a
  join dept b
    on a.dept_no = b.no;

-- left join
   select a.name, ifnull(b.name,'없음')
     from emp a
left join dept b
       on a.dept_no = b.no;

-- right join
    select ifnull(a.name,'직원없음'), b.name
      from emp a
right join dept b
        on a.dept_no = b.no;

