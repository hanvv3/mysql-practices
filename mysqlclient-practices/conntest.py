from MySQLdb import connect, OperationalError

# 연결

try:
    db = connect(user='webdb',
             password='webdb',
             host='localhost',
             port=3306,
             db='webdb',
             charset='utf8')

    print('ok')

except OperationalError as err:
    print(f'error: {err}')


# 밑에 명령어로 맥에서 mysqlclient no defined 문제 해결.
# cp -r /usr/local/mysql/lib/* /usr/local/lib/
# export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$PATH"

