from MySQLdb import connect, OperationalError

# 연결

try:
    db = connect(user='webdb',
             password='webdb',
             host='localhost',
             port=3306,
             db='webdb',
             charset='utf8')

    # cursor 생성
    cursor = db.cursor()

    # SQL 실행
    sql = 'insert into emaillist values(null, "마", "이콜", "michol@gmail.com")'
    count = cursor.excute(sql)

    # commit
    db.commit()

    # 자원 정리
    cursor.close()
    db.close()

    # 결과 보기
    print(f'실행결과: {count==1}')

except OperationalError as err:
    print(f'error: {err}')



