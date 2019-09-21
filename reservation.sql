


 1. vo 	   - 각 테이블과 동일한 형태 
		빈즈 규격의 클래스
		equals, hashCode, toString 기본 재정의
 2. exception - 데이터 중복, 데이터 없음
 3. mybatis - 마이바티스 연결 설정 및 
	     기타 작업 클래스
 4. dao - 마이바티즈 설정으로 - 테이블 하나당 dao 한개씩
	 디비 엑세스 작업 코드 작성
 4. mapper - 매퍼 XML 파일 작성
 5. factory
 6. biz    - 순수 자바로 만드는 비즈니스 로직 클래스 
 7. controller - 서블릿 클래스 작성
 7. filter     - 서블릿 필터(인코딩, 로그인 필터)
 8. util - 날짜의 관련 된것, 스태틱 메소드가 있는 유틸 클래스, 유닐리티성 작업이 필요한 경우 작성



요구사항을 분석하고, 
교실을 예약하고 관리하기 위한 기능을 정의
기능에 맞는 화면을 설계하고 

총괄 '창원이'


총 12명
데이터 베이스 구축 2명


서블릿 6명
- 메인 (서브로 넘어갈 수 있도록)
- 회원 로그인 후 화면
- 관리자 로그인후 화면
- 강의장 등록 수정 삭제 검색
- 예약 신청, 삭제 검색
- 검색 처리



디자인 4명;
- 메인
- 회원 페이지
- 검색 디자인





-- 테이블 생성
DROP TABLE CUSTOMER;

CREATE TABLE CUSTOMER
( CUST_SEQ  NUMBER(4)    NOT NULL
, CUST_ID   VARCHAR2(30) NOT NULL
, NAME      VARCHAR2(70) NOT NULL
, PASSWORD  VARCHAR2(30) NOT NULL
, CUST_TYPE NUMBER(4)    NOT NULL
, CUST_NB   NUMBER(12)   NOT NULL
, EMAIL     VARCHAR2(50) NOT NULL
, PHONE     VARCHAR2(13) NOT NULL
, REG_ID    VARCHAR2(30) NOT NULL
, REG_DATE  DATE         DEFAULT SYSDATE NOT NULL
, MOD_ID    VARCHAR2(30) 
, MOD_DATE  DATE
, CONSTRAINT PK_CUST PRIMARY KEY (CUST_SEQ)
, CONSTRAINT U_CUST_ID UNIQUE (CUST_ID)
);

---------------------------------------------

DROP TABLE ADMIN;

CREATE TABLE ADMIN
( ADMIN_SEQ  NUMBER(4)    NOT NULL 
, ADMIN_ID   VARCHAR2(20) NOT NULL
, NAME       VARCHAR2(30) NOT NULL
, PASSWORD   VARCHAR2(30) NOT NULL
, ADMIN_TYPE NUMBER(4)    NOT NULL   
, EMAIL      VARCHAR2(50) NOT NULL
, PHONE      VARCHAR2(13) NOT NULL
, REG_ID     VARCHAR2(30) NOT NULL
, REG_DATE   DATE         DEFAULT SYSDATE NOT NULL
, MOD_ID     VARCHAR2(30)
, MOD_DATE   DATE    
, CONSTRAINT PK_ADMIN PRIMARY KEY (ADMIN_SEQ)
, CONSTRAINT U_ADMIN_ID UNIQUE (ADMIN_ID)
);

------------------------------------------------
DROP TABLE FACILITY;

CREATE TABLE FACILITY
( FAC_SEQ      NUMBER(4)    NOT NULL
, FAC_NM       VARCHAR2(30) NOT NULL
, BUILDING_CD  NUMBER(4)    NOT NULL
, FAC_TYPE     NUMBER(4)    NOT NULL
, FAC_NB       NUMBER(4)    NOT NULL
, PEOPLE_LM_CD NUMBER(4)    NOT NULL
, REG_ID       VARCHAR2(30) NOT NULL
, REG_DATE     DATE         DEFAULT SYSDATE NOT NULL
, MOD_ID       VARCHAR2(30) 
, MOD_DATE     DATE
, CONSTRAINT   PK_FACILITY  PRIMARY KEY (FAC_SEQ)
);

---------------------------------------------------
DROP TABLE RESERVATION;

CREATE TABLE RESERVATION
( RES_SEQ        NUMBER(4)    NOT NULL 
, FAC_SEQ        NUMBER(4)    NOT NULL
, CUST_SEQ       NUMBER(4)    NOT NULL
, ADMIN_SEQ      NUMBER(4)    
, RES_DATE       DATE         NOT NULL
, RES_STATE      NUMBER(4)    NOT NULL
, RES_START_TIME DATE         NOT NULL
, RES_END_TIME   DATE         NOT NULL
, REG_DATE       DATE DEFAULT SYSDATE NOT NULL
, MOD_ID         VARCHAR2(30) 
, MOD_DATE       DATE 
, CONSTRAINT PK_RESERVATION PRIMARY KEY (RES_SEQ)
);

---------------------------------------------------
DROP TABLE CODE;

CREATE TABLE CODE
( CODE         NUMBER(4)     NOT NULL
, P_CODE       NUMBER(4)     NOT NULL
, CODE_NM      VARCHAR2(30)  NOT NULL
, CODE_VAL     VARCHAR2(300) NOT NULL
, USE_YN       VARCHAR2(1)   NOT NULL
, CODE_DESC    VARCHAR2(500) NOT NULL
, SORT_ORDER   NUMBER(4)     NOT NULL
, REG_DATE     DATE          DEFAULT SYSDATE NOT NULL
, MOD_ID       VARCHAR2(30) 
, MOD_DATE     DATE 
, CONSTRAINT PK_CODE PRIMARY KEY (CODE)
);
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
-- 시퀀스 생성

DROP SEQUENCE SEQ_CUST;

CREATE SEQUENCE SEQ_CUST;
INCREMENT BY 1
NOCYCLE
NOMAXVALUE
;

DROP SEQUENCE SEQ_ADMIN;

CREATE SEQUENCE SEQ_ADMIN;
INCREMENT BY 1
NOCYCLE
NOMAXVALUE
;

DROP SEQUENCE SEQ_FAC;

CREATE SEQUENCE SEQ_FAC;
INCREMENT BY 1
NOCYCLE
NOMAXVALUE
;

DROP SEQUENCE SEQ_RES;

CREATE SEQUENCE SEQ_RES;
INCREMENT BY 1
NOCYCLE
NOMAXVALUE
;
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- 예약 코드(1000) 값 입력
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (1000, 0, '예약 상태', ' ', ' ', '예약 상태 구분', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (1001, 1000, 'RESERVATION', '예약', 'Y', '예약되었습니다', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (1002, 1000, 'RESERVATION', '예약', 'N', '예약되지않았습니다', 0)
;

-----------------------------------------------------------------------------------
-- 건물 이름(2000) 구분 값 입력
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES(2000, 0, 'BUILDING', '건물', ' ', '건물명 구분', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES(2001, 2000, 'MAIN', '본관', 'Y', '본관', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (2002, 2000, 'HUMANITY ', '인문관', 'Y', '인문관', 0)
;
INSERT INTO CODE (CODE, P_CODE ,CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (2003, 2000, 'NATURE', '자연관', 'Y', '자연관', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (2004, 2000, 'COMPUTER', '원화관', 'Y', '원화관', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (2005, 2000, 'OUTDOORS', '야외', 'Y', '야외', 0)
;
----------------------------------------------------------------------------
-- 시설 종류(3000) 구분 값 입력
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (3000, 0, 'FACILITIES', '시설', ' ', '시설 종류 구분', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (3001, 3000, 'LECTURE', '강의실', 'Y', '강의실', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (3002, 3000, 'SEMINA', '세미나실', 'Y', '세미나실', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (3003, 3000, 'MEETING', '회의장', 'Y', '회의장', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (3004, 3000, 'HALL', '대강당', 'Y', '대강당', 0)
;
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER) 
VALUES (3005, 3000, 'OUTDOOR', '야외시설', 'Y', '야외시설', 0)
;
-----------------------------------------------------------------------------------
-- 인원코드(4000) 구분 값 입력
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (4000, 0, 'PEOPLE', '사람', ' ', '수용 인원 수', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (4001, 4000, 'FIVE', '5명', 'Y', '5명 이하', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (4002, 4000, 'TEN', '10명', 'Y', '10명 이하', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (4003, 4000, 'FORTY', '40명', 'Y', '40명 이하', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (4004, 4000, 'HUNDRED', '100명', 'Y', '100명 이하', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (4005, 4000, 'HUNDRED_OVER', '100명OVER', 'Y', '100명 초과', 0)
;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- 회원(5000) 구분 값 입력
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (5000, 0, 'USER', '회원', ' ', '회원 타입 구분', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (5001, 5000, 'CUSTOMER', '외부인', 'Y', '외부인', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (5002, 5000, 'STUDENT', '학생', 'Y', '학생', 0)
;

---------------------------------------------------------------------------------
-- 관리자(6000) 구분 값 입력
INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (6000, 0, 'MANAGER', '매니저', ' ', '관리자 등급 구분', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (6001, 6000, 'SUPER_ADMIN', '슈퍼 관리자', 'Y', '슈퍼 관리자', 0)
;

INSERT INTO CODE (CODE, P_CODE, CODE_NM, CODE_VAL, USE_YN, CODE_DESC, SORT_ORDER)
VALUES (6002, 6000, 'ADMIN', '관리자', 'Y', '관리자', 0)
;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- 아래는 sample 값 입력

-- 강의장 실제 7개 값 입력
INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '상하이', 2001, 3002, 0, 4001, '0')
;
INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '호치민', 2001, 3002, 0, 4001, '0')
;
INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '베니스', 2001, 3002, 0, 4002, '0')
;
INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB,PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '샌프란시스코', 2001, 3002, 0, 4002,'0')
;
INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '상파울로', 2001, 3002, 0, 4002, '0')
;
INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '시드니', 2001, 3002, 0, 4002, '0')
;
INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '카사블랑카', 2001, 3002, 0, 4002, '0')
;

INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '101', 2001, 3002, 0, 4002, '0')
;

INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '102', 2001, 3002, 0, 4002, '0')
;

INSERT INTO FACILITY (FAC_SEQ, FAC_NM, BUILDING_CD, FAC_TYPE, FAC_NB, PEOPLE_LM_CD, REG_ID)
VALUES (SEQ_FAC.NEXTVAL, '103', 2001, 3002, 0, 4002, '0')
;
-----------------------------------------------------------------------------------
-- 예약 실제 2건 값 입력
INSERT INTO RESERVATION (RES_SEQ, FAC_SEQ, CUST_SEQ, ADMIN_SEQ, RES_DATE, RES_STATE, RES_START_TIME, RES_END_TIME)
VALUES (SEQ_RES.NEXTVAL, 1, 1, 1, SYSDATE, 1001, SYSDATE, SYSDATE)
;
INSERT INTO RESERVATION (RES_SEQ, FAC_SEQ, CUST_SEQ, ADMIN_SEQ, RES_DATE, RES_STATE, RES_START_TIME, RES_END_TIME)
VALUES (SEQ_RES.NEXTVAL, 2, 2, 2, SYSDATE, 1001, SYSDATE, SYSDATE)
;

-----------------------------------------------------------------------------------
-- 회원 실제 3명 값 입력
INSERT INTO CUSTOMER (CUST_SEQ, CUST_ID, NAME, PASSWORD, CUST_TYPE, CUST_NB, EMAIL, PHONE, REG_ID)
VALUES (SEQ_CUST.NEXTVAL, 'sunny', 'sunny', 'sunny', 5001, 11111111, 'sunny0000@naver.com'
       , '010-2222-2222', 0)
;

INSERT INTO CUSTOMER (CUST_SEQ, CUST_ID, NAME, PASSWORD, CUST_TYPE, CUST_NB, EMAIL, PHONE, REG_ID)
VALUES (SEQ_CUST.NEXTVAL, 'kamo', 'kamo', 'kamo', 5002, 22222222, 'kamo1111@naver.com'
       , '010-3333-3333', 0)
;

INSERT INTO CUSTOMER (CUST_SEQ, CUST_ID, NAME, PASSWORD, CUST_TYPE, CUST_NB, EMAIL, PHONE, REG_ID)
VALUES (SEQ_CUST.NEXTVAL, 'lena', 'lena', 'lena', 5002, 33333333, 'lena2222@naver.com'
       , '010-4444-4444', 0)
;

COMMIT;

-----------------------------------------------------------------------------------
-- 관리자 실제 2명 값 입력
INSERT INTO ADMIN (ADMIN_SEQ, ADMIN_ID, NAME, PASSWORD, ADMIN_TYPE, EMAIL, PHONE, REG_ID)
VALUES (SEQ_ADMIN.NEXTVAL, 'superadmin', '슈퍼 관리자', 'superadmin', 6001
       ,'superadmin0000@naver.com', '010-0000-0000', 0)
;

INSERT INTO ADMIN (ADMIN_SEQ, ADMIN_ID, NAME, PASSWORD, ADMIN_TYPE, EMAIL, PHONE, REG_ID)
VALUES (SEQ_ADMIN.NEXTVAL, 'admin', '관리자', 'admin', 6002
       ,'admin0000@naver.com', '010-1111-1111', 0)
;

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- 조회 쿼리 문 
SELECT a.admin_seq
     , a.admin_id
     , a.name
     , a.password
     , a.admin_type
     , a.email
     , a.phone
     , a.reg_id
  FROM ADMIN a
 WHERE a.admin_seq = 1
;

UPDATE ADMIN A 
 SET  a.admin_id = 'superadmin' 
     , a.name = '슈퍼 관리자'
     , a.password = 'superadmin'
     , a.admin_type = 6001
     , a.email = 'superadmin0000@naver.com'
     , a.phone = '010-0000-0000'
     , a.reg_id = 0
 WHERE a.admin_seq = 1
; 
rollback;
SELECT c.cust_seq
     , c.cust_id
     , c.name
     , c.password
     , c.cust_type
     , c.cust_nb
     , c.email
     , c.phone
     , c.reg_id
  FROM CUSTOMER c
 WHERE c.cust_seq = 1
;
UPDATE CUSTOMER c 
   SET c.NAME = 'sunny'
     , c.PASSWORD = 'sunny'
     , c.CUST_TYPE = 5001
     , c.CUST_NB = 1111111.1
     , c.EMAIL = 'sunny0000@naver.com'
     , c.PHONE = '010-2222-2222'
     , c.REG_ID = 0
 WHERE c.CUST_SEQ = 1
;
ROLLBACK;

SELECT f.fac_seq
     , f.fac_nm
     , f.building_cd
     , f.fac_type
     , f.fac_nb
     , f.people_lm_cd
     , f.reg_id
FROM FACILITY f
WHERE f.fac_seq = 1
;
UPDATE FACILITY f
   SET f.FAC_NM = '103'
     , f.BUILDING_CD = 2001
     , f.FAC_TYPE = 3002
     , f.FAC_NB = 0
     , f.PEOPLE_LM_CD = 4002
     , f.REG_ID = 0
 WHERE f.FAC_SEQ = 1;
ROLLBACK;


SELECT f.fac_seq
     , f.fac_nm
     , f.building_cd
     , f.fac_type
     , f.fac_nb
     , f.people_lm_cd
     , f.reg_id
FROM facility f
WHERE f.fac_seq = 1
;


SELECT r.res_seq
     , r.fac_seq
     , r.cust_seq
     , r.admin_seq
     , r.reg_date
     , r.res_state
     , r.res_start_time
     , r.res_end_time
     , r.reg_date
FROM reservation r
WHERE r.res_seq = 1
;


-------------------------------------------------
-- 1건 삭제 구문
DELETE FROM ADMIN a WHERE a.admin_seq = 1;
ROLLBACK;
DELETE FROM CUSTOMER c WHERE c.cust_seq = 1;
ROLLBACK;
DELETE FROM FACILITY f WHERE f.fac_seq = 1;
ROLLBACK;
DELETE FROM RESERVATION r WHERE r.res_seq = 1;
ROLLBACK;
--------------------------------------------------------
-- factility 뷰
DROP VIEW v_facility;
CREATE OR REPLACE VIEW v_facility
AS
SELECT f.fac_seq
     , f.fac_nm
     , f.building_cd
     , c.code_val
     , f.fac_type
     , a.code_nm
     , f.fac_nb
     , f.people_lm_cd
     , b.code_desc
     , f.reg_id
  FROM facility f JOIN code c ON f.building_cd = c.code
                  JOIN code a ON f.fac_type = a.code
                  JOIN code b ON f.people_lm_cd = b.code
WITH READ ONLY
;
-----------------------------------------------------------
-- reservation 뷰

DROP VIEW v_reservation;
CREATE OR REPLACE VIEW v_reservation
AS
SELECT r.res_seq
     , f.fac_nm
     , f.code_val
     , c.name
     , r.admin_seq
     , r.res_date
     , r.res_state
     , a.use_yn
     , r.res_start_time
     , r.res_end_time
     , r.reg_date
  FROM reservation r JOIN CUSTOMER c ON r.cust_seq = c.cust_seq
                    JOIN v_facility f ON r.fac_seq = f.fac_seq
                    JOIN CODE a ON r.res_state =  a.code
WITH READ ONLY
;
--------------------------------------------------------
-- 뷰 select 컬럼
SELECT f.fac_seq
     , f.fac_nm
     , f.code_val
     , f.fac_type
     , f.code_nm
     , f.code_desc
FROM v_facility f
WHERE f.fac_seq = 1
;

SELECT r.res_seq
     , r.fac_nm
     , r.code_val
     , r.name
     , r.res_date
     , r.use_yn
     , r.res_start_time
     , r.res_end_time
     , r.reg_date
FROM v_reservation r
WHERE r.res_seq = 1
;
