CREATE TABLE STUDENT (
                         STUD_CODE VARCHAR(50) PRIMARY KEY,
                         STUD_LNAME VARCHAR(100) NOT NULL,
                         STUD_FNAME VARCHAR(100) NOT NULL,
                         STUD_MNAME VARCHAR(100),
                         STUD_BOD DATE NOT NULL,
                         STUD_CONTACT VARCHAR(20) NOT NULL,
                         STUD_EMAIL VARCHAR(100) UNIQUE NOT NULL,
                         STUD_ADDRESS TEXT NOT NULL,
                         STUD_PASSWORD TEXT NOT NULL
);