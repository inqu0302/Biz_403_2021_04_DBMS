CREATE TABLE iolist(
        name NVARCHAR2(5),
        age number,
        addres CHAR(100));
        
        
INSERT INTO iolist(name, age, addres)
VALUES('홍길동', 20, '남구 백운동');

SELECT name, age, addres
FROM iolist;