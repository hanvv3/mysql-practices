from emaillistapp import model


def run_list():
    results = model.findall()
    for idx, result in enumerate(results):                  # 다시보기
        print(f'{idx+1}.{result["first_name"]} {result["last_name"]}:{result["email"]}')


def run_add():
    firstname = input('first name : ')
    lastname = input('last name : ')
    email = input('email : ')

    res = model.insert(firstname, lastname, email)
    run_list()
    print(f"실행결과 : {res}")


def run_delete():                               # 만들어보기
    run_list()
    email = input('email : ')

    res = model.deletebyemail(email)
    run_list()
    print(f"실행결과 : {res}")


def main():
    while True:
        cmd = input(f'(l)ist, (a)dd, (d)elete, (q)uit > ')

        if cmd == 'q': break
        elif cmd == 'l': run_list()
        elif cmd == 'a': run_add()
        elif cmd == 'd': run_delete()
        else: print("알 수 없는 명령어입니다.")
        print(f'execute {cmd}')


__name__ == '__main__' and main()       # and연산: 처음 '__main__'이 false일땐, main()을 실행하지 않음


