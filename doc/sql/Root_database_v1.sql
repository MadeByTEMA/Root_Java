## MySQL 데이터베이스 생성
 CREATE DATABASE rootdb
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;
  
## MySQL 사용자 추가 로컬에서만 접속할 수 있는 사용자
CREATE USER 'rootserver'@'localhost' IDENTIFIED BY '1111';

## 원격에서만 접속할 수 있는 사용자를 만들기:
CREATE USER 'rootserver'@'%' IDENTIFIED BY '1111';

## MySQL 사용자에게 데이터베이스 사용 권한 부여
GRANT ALL ON rootdb.* TO 'rootserver'@'localhost';