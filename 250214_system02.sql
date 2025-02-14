-- 버전업으로 사용자 계정앞에 C##
    -- C## 을 붙이지 않고 사용자 계정 생성하기 위해 session 변경
    alter session set "_oracle_script" = true;
    --1. 사용자 생성 : test_user // 비번 : 1234
    
    create user test_user 
           identified by 1234;
    --2. test_user ==> 접속권한(create session)부여
    grant create session to test_user;
    grant unlimited tablespace to test_user;
    --3. 비밀번호 변경 : abcd
    alter user test_user identified by abcd;
    --4. test_user 삭제
    drop user test_user;
    drop user test_user cascade;
    
    -----------------------------
    --p412 롤(role)
    -- connect 롤 : create session 권한
    -- resource 롤 : 테이블, 시퀀스 등 객체 생성 권한
    
    --1. 사용자 생성
    create user test_user identified by abcd;
    --2. 권한 부여
    grant connect, resource, unlimited tablespace to test_user;
    --3. 권한 삭제 ==> test_user에 connect 구너한 제거
    revoke connect from test_user;
    -- test_user 삭제
    drop user test_user;
    
    -- p416 15장 연습문제
    --1. prev_hw 계정생선(비번 orcl) 접속 가능하도록 생성 ==> 관리자 계정에서 작업
    create user prev_hw identified by orcl;
    grant connect, resource, unlimited tablespace to prev_hw;
    
    --4. prev_hw 삭제
    drop user prev_hw cascade;

    
    
    