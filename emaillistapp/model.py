from MySQLdb import connect, OperationalError, ProgrammingError
from MySQLdb.cursors import DictCursor


def insert(firstname, lastname, email):
    try:
        # 연결
        db = conn()

        # cursor 생성
        cursor = db.cursor()

        # SQL 실행
        sql = 'insert into emaillist values(null, %s, %s, %s)'
        count = cursor.execute(sql, (firstname, lastname, email))   # 1:성공/0:실패     이게 되는구나

        # commit (transaction종료, db내부 변경 사항을 확정)
        db.commit()

        # 자원 정리
        cursor.close()
        db.close()

        # 변경 성공/실패
        return count == 1          # True/False

    except OperationalError as e:
        print(f'error: {e}')


def deletebyemail(email):
    try:
        db = conn()

        cursor = db.cursor()

        sql = f"delete from emaillist where email = '{email}'"
        count = cursor.execute(sql)

        db.commit()

        cursor.close()
        db.close()

        return count == 1

    except ProgrammingError as e:
        print(f'error: {e}')


def findall():
    try:
        # 연결
        db = conn()

        # cursor 생성
        cursor = db.cursor(DictCursor)

        # SQL 실행
        sql = 'select no, first_name, last_name, email from emaillist order by no'
        cursor.execute(sql)

        # 결과 받아오기
        results = cursor.fetchall()

        # 자원 정리
        cursor.close()
        db.close()

        # 결과 반환
        return results

    except OperationalError as e:
        print(f'error: {e}')


def conn():
    return connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')