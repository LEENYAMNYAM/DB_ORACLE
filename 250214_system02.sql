-- ���������� ����� �����տ� C##
    -- C## �� ������ �ʰ� ����� ���� �����ϱ� ���� session ����
    alter session set "_oracle_script" = true;
    --1. ����� ���� : test_user // ��� : 1234
    
    create user test_user 
           identified by 1234;
    --2. test_user ==> ���ӱ���(create session)�ο�
    grant create session to test_user;
    grant unlimited tablespace to test_user;
    --3. ��й�ȣ ���� : abcd
    alter user test_user identified by abcd;
    --4. test_user ����
    drop user test_user;
    drop user test_user cascade;
    
    -----------------------------
    --p412 ��(role)
    -- connect �� : create session ����
    -- resource �� : ���̺�, ������ �� ��ü ���� ����
    
    --1. ����� ����
    create user test_user identified by abcd;
    --2. ���� �ο�
    grant connect, resource, unlimited tablespace to test_user;
    --3. ���� ���� ==> test_user�� connect ������ ����
    revoke connect from test_user;
    -- test_user ����
    drop user test_user;
    
    -- p416 15�� ��������
    --1. prev_hw ��������(��� orcl) ���� �����ϵ��� ���� ==> ������ �������� �۾�
    create user prev_hw identified by orcl;
    grant connect, resource, unlimited tablespace to prev_hw;
    
    --4. prev_hw ����
    drop user prev_hw cascade;

    
    
    