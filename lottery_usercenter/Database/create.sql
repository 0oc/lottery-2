----------------------------------------------------
-- Export file for user LOTTERY6677               --
-- Created by Administrator on 2013-9-8, 22:38:12 --
----------------------------------------------------

spool create.log

prompt
prompt Creating table TB_AGENT_STAFF_EXT
prompt =================================
prompt
create table TB_AGENT_STAFF_EXT
(
  PARENT_STAFF          NUMBER(10),
  REPLENISHMENT         CHAR(1) not null,
  MANAGER_STAFF_ID      NUMBER(10) not null,
  PURE_ACCOUNTED        CHAR(1),
  AGENT_RATE            NUMBER(5,2),
  TOTAL_CREDIT_LINE     NUMBER(10),
  AVAILABLE_CREDIT_LINE NUMBER(10),
  GEN_AGENT_RATE        NUMBER(5,2),
  CHIEF_STAFF           NUMBER(10),
  BRANCH_STAFF          NUMBER(10),
  STOCKHOLDER_STAFF     NUMBER(10),
  RATE_RESTRICT         CHAR(1),
  BELOW_RATE_LIMIT      NUMBER(2)
)
;
comment on table TB_AGENT_STAFF_EXT
  is '�˱��м�¼�����û���չ��Ϣ�������û�������TB_FRAME_MANAGER_STAFF���д洢�˴����û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
7������¼IP
-----------------
�����û��ڹ����û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��6 �� �����û���';
comment on column TB_AGENT_STAFF_EXT.PARENT_STAFF
  is '�ϼ��û�';
comment on column TB_AGENT_STAFF_EXT.REPLENISHMENT
  is '�߷ɣ���������ȡֵ�������£�0 �� �����߷ɣ�1 �� ��ֹ�߷�';
comment on column TB_AGENT_STAFF_EXT.MANAGER_STAFF_ID
  is '�����û�������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
comment on column TB_AGENT_STAFF_EXT.PURE_ACCOUNTED
  is '0 �� ��ռ��1 �� �Ǵ�ռ';
comment on column TB_AGENT_STAFF_EXT.AGENT_RATE
  is '����ռ��';
comment on column TB_AGENT_STAFF_EXT.CHIEF_STAFF
  is '��������Ӧ���ܼ�ID';
comment on column TB_AGENT_STAFF_EXT.BRANCH_STAFF
  is '��������Ӧ�ķֹ�˾ID';
comment on column TB_AGENT_STAFF_EXT.STOCKHOLDER_STAFF
  is '��������Ӧ�Ĺɶ�ID';
comment on column TB_AGENT_STAFF_EXT.RATE_RESTRICT
  is '�Ƿ�����ռ��';
comment on column TB_AGENT_STAFF_EXT.BELOW_RATE_LIMIT
  is '����ռ���޶�';
alter table TB_AGENT_STAFF_EXT
  add constraint PK_TB_AGENT_STAFF_EXT primary key (MANAGER_STAFF_ID);

prompt
prompt Creating table TB_BJSC
prompt ======================
prompt
create table TB_BJSC
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on table TB_BJSC
  is '����������Ӧ��Ͷע����¼��ԱͶע��Ϣ����';
comment on column TB_BJSC.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_BJSC.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_BJSC.MONEY
  is 'Ͷע����λ��';
comment on column TB_BJSC.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_BJSC.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_BJSC.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ����û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ��������������TB_BJSC_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_BJSC.PLATE
  is 'A��B��C������';
comment on column TB_BJSC.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_BJSC.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_BJSC.WIN_AMOUNT
  is '��λ��';
comment on column TB_BJSC.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_BJSC
  add constraint PK_TB_BJSC primary key (ID);

prompt
prompt Creating table TB_BJSC_HIS
prompt ==========================
prompt
create table TB_BJSC_HIS
(
  ID                     NUMBER(10) not null,
  CREATE_DATE            DATE default sysdate,
  ORIGIN_TB_NAME         VARCHAR2(100),
  ORIGIN_ID              NUMBER(10),
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on table TB_BJSC_HIS
  is 'Ͷע��ʷ���洢�������ݱ��е���ʷ���ݣ�';
comment on column TB_BJSC_HIS.ORIGIN_TB_NAME
  is '����ʷ��������Ӧ��ԭʼ�洢���ݱ�����';
comment on column TB_BJSC_HIS.ORIGIN_ID
  is '����ʷ��������Ӧ��ԭʼ�洢����ID';
comment on column TB_BJSC_HIS.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_BJSC_HIS.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_BJSC_HIS.MONEY
  is 'Ͷע����λ��';
comment on column TB_BJSC_HIS.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_BJSC_HIS.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_BJSC_HIS.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC_HIS.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC_HIS.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC_HIS.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_BJSC_HIS.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ ��Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_BJSC_HIS.PLATE
  is 'A��B��C������';
comment on column TB_BJSC_HIS.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_BJSC_HIS.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��� Ĭ��ֵ 0 �� δ����';
comment on column TB_BJSC_HIS.WIN_AMOUNT
  is '��λԪ';
comment on column TB_BJSC_HIS.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_BJSC_HIS
  add constraint PK_TB_BJSC_HIS primary key (ID);
create index INDEX_BJ_HIS_BETTING_DATE_USER on TB_BJSC_HIS (BETTING_USER_ID, BETTING_DATE);
create index INDEX_BJ_HIS_BETTING_USER on TB_BJSC_HIS (BETTING_USER_ID);

prompt
prompt Creating table TB_BJSC_PERIODS_INFO
prompt ===================================
prompt
create table TB_BJSC_PERIODS_INFO
(
  ID             NUMBER(10) not null,
  PERIODS_NUM    VARCHAR2(11) not null,
  OPEN_QUOT_TIME DATE not null,
  LOTTERY_TIME   DATE not null,
  STOP_QUOT_TIME DATE not null,
  RESULT1        INTEGER,
  RESULT2        INTEGER,
  RESULT3        INTEGER,
  RESULT4        INTEGER,
  RESULT5        INTEGER,
  RESULT6        INTEGER,
  RESULT7        INTEGER,
  RESULT8        INTEGER,
  RESULT9        INTEGER,
  RESULT10       INTEGER,
  STATE          CHAR(1) default '1' not null,
  CREATE_USER    NUMBER(10),
  CREATE_TIME    DATE default sysdate not null
)
;
comment on table TB_BJSC_PERIODS_INFO
  is '�����������ڱ�';
comment on column TB_BJSC_PERIODS_INFO.PERIODS_NUM
  is 'Ͷע���������� 20120203001������Ψһ�ԣ���Ź���Ϊ������+�淨�����������';
comment on column TB_BJSC_PERIODS_INFO.RESULT1
  is '��������Ӧ�Ŀ�������еĵ�һ����ֵ';
comment on column TB_BJSC_PERIODS_INFO.RESULT2
  is '��������Ӧ�Ŀ�������еĵڶ�����ֵ';
comment on column TB_BJSC_PERIODS_INFO.STATE
  is '����״̬��ȡֵ���£�0 �� �ѽ��ã�1 �� δ���̣�2 �� �ѿ��̣�3 �� �ѷ��̣�4 �� �ѿ�����Ĭ��ֵΪ 1 �� δ����';
comment on column TB_BJSC_PERIODS_INFO.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_BJSC_PERIODS_INFO
  add constraint PK_TB_BJSC_PERIODS_INFO primary key (ID);

prompt
prompt Creating table TB_BOSS_LOG
prompt ==========================
prompt
create table TB_BOSS_LOG
(
  ID          NUMBER(10) not null,
  LOG_MESSAGE NVARCHAR2(200),
  LOG_STATE   CHAR(1) default '0',
  LOG_LEVEL   CHAR(1) default '1',
  CREATEDATE  DATE default sysdate
)
;
comment on column TB_BOSS_LOG.LOG_STATE
  is '״̬��0����ʼ��1����ɾ��';
comment on column TB_BOSS_LOG.LOG_LEVEL
  is '��־�ļ���1��2��3������Խ������Խ��';
alter table TB_BOSS_LOG
  add constraint PK_TB_BOSS_LOG primary key (ID);

prompt
prompt Creating table TB_BRANCH_STAFF_EXT
prompt ==================================
prompt
create table TB_BRANCH_STAFF_EXT
(
  MANAGER_STAFF_ID      NUMBER(10) not null,
  PARENT_STAFF          NUMBER(10),
  REPLENISHMENT         CHAR(1) not null,
  CHIEF_RATE            NUMBER(5,2),
  COMPANY_RATE          NUMBER(5,2),
  TOTAL_CREDIT_LINE     NUMBER(10),
  AVAILABLE_CREDIT_LINE NUMBER(10),
  OPENREPORT            CHAR(1),
  LEFTOWNER             CHAR(1)
)
;
comment on table TB_BRANCH_STAFF_EXT
  is '�˱��м�¼�ֹ�˾�û���չ��Ϣ�������û�������TB_FRAME_MANAGER_STAFF���д洢�˷ֹ�˾�û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
7������¼IP
-----------------
�ֹ�˾�û��ڹ����û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��3 �� �ֹ�˾�û���';
comment on column TB_BRANCH_STAFF_EXT.MANAGER_STAFF_ID
  is '�ֹ�˾�û�������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
comment on column TB_BRANCH_STAFF_EXT.PARENT_STAFF
  is '�ϼ��û�';
comment on column TB_BRANCH_STAFF_EXT.REPLENISHMENT
  is '�߷ɣ���������ȡֵ�������£�0 �� �����߷ɣ�1 �� ��ֹ�߷�';
comment on column TB_BRANCH_STAFF_EXT.COMPANY_RATE
  is '��˾ռ��';
comment on column TB_BRANCH_STAFF_EXT.OPENREPORT
  is '�Ƿ񿪷Ź�˾����';
comment on column TB_BRANCH_STAFF_EXT.LEFTOWNER
  is 'ռ�������';
alter table TB_BRANCH_STAFF_EXT
  add constraint PK_TB_BRANCH_STAFF_EXT primary key (MANAGER_STAFF_ID);

prompt
prompt Creating table TB_CHIEF_STAFF_EXT
prompt =================================
prompt
create table TB_CHIEF_STAFF_EXT
(
  MANAGER_STAFF_ID NUMBER(10) not null,
  SHOPS_CODE       CHAR(4) not null
)
;
comment on table TB_CHIEF_STAFF_EXT
  is '�˱��м�¼�ܼ��û���չ��Ϣ�������û�������TB_FRAME_MANAGER_STAFF���д洢���ܼ��û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
7������¼IP
-----------------
�ܼ��û��ڹ����û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��2 �� �ܼ��û���';
comment on column TB_CHIEF_STAFF_EXT.MANAGER_STAFF_ID
  is '�ܼ��û�������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
comment on column TB_CHIEF_STAFF_EXT.SHOPS_CODE
  is '�ܼ������������̺��룬��Ӧ������Ϣ��TB_SHOPS_INFO�������̺��루SHOPS_CODE���ֶ�';
alter table TB_CHIEF_STAFF_EXT
  add constraint PK_TB_CHIEF_STAFF_EXT primary key (MANAGER_STAFF_ID);

prompt
prompt Creating table TB_CLASS_REPORT_PET_LIST
prompt =======================================
prompt
create table TB_CLASS_REPORT_PET_LIST
(
  ID                           NUMBER(10) not null,
  COUNT                        NUMBER(10),
  TOTAL_MONEY                  NUMBER,
  MONEY_RATE_AGENT             NUMBER,
  MONEY_RATE_GENAGENT          NUMBER,
  MONEY_RATE_STOCKHOLDER       NUMBER,
  MONEY_RATE_BRANCH            NUMBER,
  MONEY_RATE_CHIEF             NUMBER,
  RATE_MONEY                   NUMBER,
  MEMBER_AMOUNT                NUMBER,
  SUBORDINATE_AMOUNT_WIN       NUMBER,
  SUBORDINATE_AMOUNT_BACKWATER NUMBER,
  REALWIN                      NUMBER,
  REAL_BACKWATER               NUMBER,
  COMMISSION                   NUMBER,
  BETTING_DATE                 DATE,
  USER_ID                      NUMBER(10),
  USER_TYPE                    CHAR(1),
  COMMISSION_TYPE              VARCHAR2(15)
)
;
comment on column TB_CLASS_REPORT_PET_LIST.COUNT
  is '����';
comment on column TB_CLASS_REPORT_PET_LIST.TOTAL_MONEY
  is '��Ч���~';
comment on column TB_CLASS_REPORT_PET_LIST.MONEY_RATE_AGENT
  is '����ʵռ';
comment on column TB_CLASS_REPORT_PET_LIST.MONEY_RATE_GENAGENT
  is '�ܴ���ʵռ';
comment on column TB_CLASS_REPORT_PET_LIST.MONEY_RATE_STOCKHOLDER
  is '�ɶ�ʵռ';
comment on column TB_CLASS_REPORT_PET_LIST.MONEY_RATE_BRANCH
  is '�ֹ�˾ʵռ';
comment on column TB_CLASS_REPORT_PET_LIST.MONEY_RATE_CHIEF
  is '�ܼ�ʵռ';
comment on column TB_CLASS_REPORT_PET_LIST.RATE_MONEY
  is '����ʵռ';
comment on column TB_CLASS_REPORT_PET_LIST.MEMBER_AMOUNT
  is '��Աݔ�A';
comment on column TB_CLASS_REPORT_PET_LIST.SUBORDINATE_AMOUNT_WIN
  is 'Ӧ������-ݔ�A';
comment on column TB_CLASS_REPORT_PET_LIST.SUBORDINATE_AMOUNT_BACKWATER
  is 'Ӧ������-��ˮ';
comment on column TB_CLASS_REPORT_PET_LIST.REALWIN
  is 'ʵռ��Ӯ';
comment on column TB_CLASS_REPORT_PET_LIST.REAL_BACKWATER
  is 'ʵռ��ˮ';
comment on column TB_CLASS_REPORT_PET_LIST.COMMISSION
  is '��ˮ';
comment on column TB_CLASS_REPORT_PET_LIST.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CLASS_REPORT_PET_LIST.USER_ID
  is 'ͳ�ƶ�����û�ID';
comment on column TB_CLASS_REPORT_PET_LIST.USER_TYPE
  is 'ͳ�ƶ�����û�����';
comment on column TB_CLASS_REPORT_PET_LIST.COMMISSION_TYPE
  is 'ӵ������';
alter table TB_CLASS_REPORT_PET_LIST
  add constraint PK_TB_CLASS_REPORT_PET_LIST primary key (ID);

prompt
prompt Creating table TB_CLASS_REPORT_R_LIST
prompt =====================================
prompt
create table TB_CLASS_REPORT_R_LIST
(
  ID                NUMBER(10) not null,
  USER_TYPE         CHAR(1),
  COUNT             NUMBER(10),
  AMOUNT            NUMBER,
  MEMBER_AMOUNT     NUMBER,
  WIN_BACK_WATER    NUMBER,
  BACK_WATER_RESULT NUMBER,
  BETTING_DATE      DATE,
  USER_ID           NUMBER(10),
  COMMISSION_TYPE   VARCHAR2(15)
)
;
comment on column TB_CLASS_REPORT_R_LIST.USER_TYPE
  is 'ͳ�Ƶ��û�����';
comment on column TB_CLASS_REPORT_R_LIST.COUNT
  is '����';
comment on column TB_CLASS_REPORT_R_LIST.AMOUNT
  is 'Ͷע�ܶ�';
comment on column TB_CLASS_REPORT_R_LIST.MEMBER_AMOUNT
  is '��Աݔ�A';
comment on column TB_CLASS_REPORT_R_LIST.WIN_BACK_WATER
  is '׬ȡ��ˮ';
comment on column TB_CLASS_REPORT_R_LIST.BACK_WATER_RESULT
  is '��ˮ����';
comment on column TB_CLASS_REPORT_R_LIST.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CLASS_REPORT_R_LIST.USER_ID
  is 'ͳ�Ƶ��û�ID';
comment on column TB_CLASS_REPORT_R_LIST.COMMISSION_TYPE
  is 'ӵ������';
alter table TB_CLASS_REPORT_R_LIST
  add constraint PK_TB_TB_CLASS_REPORT_R_LIST primary key (ID);

prompt
prompt Creating table TB_CQSSC_BALL_FIFTH
prompt ==================================
prompt
create table TB_CQSSC_BALL_FIFTH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_CQSSC_BALL_FIFTH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_CQSSC_BALL_FIFTH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_CQSSC_BALL_FIFTH.MONEY
  is 'Ͷע����λ��';
comment on column TB_CQSSC_BALL_FIFTH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_CQSSC_BALL_FIFTH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_CQSSC_BALL_FIFTH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIFTH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIFTH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIFTH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIFTH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_CQSSC_BALL_FIFTH.PLATE
  is 'A��B��C������';
comment on column TB_CQSSC_BALL_FIFTH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CQSSC_BALL_FIFTH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_CQSSC_BALL_FIFTH.WIN_AMOUNT
  is '��λ��';
comment on column TB_CQSSC_BALL_FIFTH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_CQSSC_BALL_FIFTH
  add constraint PK_TB_CQSSC_BALL_FIFTH primary key (ID);

prompt
prompt Creating table TB_CQSSC_BALL_FIRST
prompt ==================================
prompt
create table TB_CQSSC_BALL_FIRST
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on table TB_CQSSC_BALL_FIRST
  is '����ʱʱ�ʵ�һ���Ӧ��Ͷע����¼��ԱͶע��Ϣ����';
comment on column TB_CQSSC_BALL_FIRST.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_CQSSC_BALL_FIRST.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_CQSSC_BALL_FIRST.MONEY
  is 'Ͷע����λ��';
comment on column TB_CQSSC_BALL_FIRST.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_CQSSC_BALL_FIRST.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_CQSSC_BALL_FIRST.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIRST.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ����û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIRST.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIRST.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FIRST.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_CQSSC_BALL_FIRST.PLATE
  is 'A��B��C������';
comment on column TB_CQSSC_BALL_FIRST.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CQSSC_BALL_FIRST.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_CQSSC_BALL_FIRST.WIN_AMOUNT
  is '��λ��';
comment on column TB_CQSSC_BALL_FIRST.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_CQSSC_BALL_FIRST
  add constraint PK_TB_CQSSC_BALL_FIRST primary key (ID);

prompt
prompt Creating table TB_CQSSC_BALL_FORTH
prompt ==================================
prompt
create table TB_CQSSC_BALL_FORTH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_CQSSC_BALL_FORTH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_CQSSC_BALL_FORTH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_CQSSC_BALL_FORTH.MONEY
  is 'Ͷע����λ��';
comment on column TB_CQSSC_BALL_FORTH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_CQSSC_BALL_FORTH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_CQSSC_BALL_FORTH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FORTH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FORTH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FORTH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_FORTH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_CQSSC_BALL_FORTH.PLATE
  is 'A��B��C������';
comment on column TB_CQSSC_BALL_FORTH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CQSSC_BALL_FORTH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_CQSSC_BALL_FORTH.WIN_AMOUNT
  is '��λ��';
comment on column TB_CQSSC_BALL_FORTH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_CQSSC_BALL_FORTH
  add constraint PK_TB_CQSSC_BALL_FORTH primary key (ID);

prompt
prompt Creating table TB_CQSSC_BALL_SECOND
prompt ===================================
prompt
create table TB_CQSSC_BALL_SECOND
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_CQSSC_BALL_SECOND.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_CQSSC_BALL_SECOND.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_CQSSC_BALL_SECOND.MONEY
  is 'Ͷע����λ��';
comment on column TB_CQSSC_BALL_SECOND.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_CQSSC_BALL_SECOND.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_CQSSC_BALL_SECOND.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_SECOND.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_SECOND.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_SECOND.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_SECOND.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_CQSSC_BALL_SECOND.PLATE
  is 'A��B��C������';
comment on column TB_CQSSC_BALL_SECOND.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CQSSC_BALL_SECOND.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_CQSSC_BALL_SECOND.WIN_AMOUNT
  is '��λ��';
comment on column TB_CQSSC_BALL_SECOND.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_CQSSC_BALL_SECOND
  add constraint PK_TB_CQSSC_BALL_SECOND primary key (ID);

prompt
prompt Creating table TB_CQSSC_BALL_THIRD
prompt ==================================
prompt
create table TB_CQSSC_BALL_THIRD
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_CQSSC_BALL_THIRD.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_CQSSC_BALL_THIRD.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_CQSSC_BALL_THIRD.MONEY
  is 'Ͷע����λ��';
comment on column TB_CQSSC_BALL_THIRD.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_CQSSC_BALL_THIRD.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_CQSSC_BALL_THIRD.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_THIRD.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_THIRD.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_THIRD.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_BALL_THIRD.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_CQSSC_BALL_THIRD.PLATE
  is 'A��B��C������';
comment on column TB_CQSSC_BALL_THIRD.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CQSSC_BALL_THIRD.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_CQSSC_BALL_THIRD.WIN_AMOUNT
  is '��λ��';
comment on column TB_CQSSC_BALL_THIRD.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_CQSSC_BALL_THIRD
  add constraint PK_TB_CQSSC_BALL_THIRD primary key (ID);

prompt
prompt Creating table TB_CQSSC_HIS
prompt ===========================
prompt
create table TB_CQSSC_HIS
(
  ID                     NUMBER(10) not null,
  CREATE_DATE            DATE default sysdate,
  ORIGIN_TB_NAME         VARCHAR2(100),
  ORIGIN_ID              NUMBER(10),
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on table TB_CQSSC_HIS
  is 'Ͷע��ʷ���洢�������ݱ��е���ʷ���ݣ�
1��Ͷע������ʱʱ�ʵ�һ�򣩱�TB_CQSSC_BALL_FIRST��
2��Ͷע������ʱʱ�ʵڶ��򣩱�TB_CQSSC_BALL_SECOND��
3��Ͷע������ʱʱ�ʵ����򣩱�TB_CQSSC_BALL_THIRD��
4��Ͷע������ʱʱ�ʵ����򣩱�TB_CQSSC_BALL_FORTH��
5��Ͷע������ʱʱ�ʵ����򣩱�TB_CQSSC_BALL_FIFTH��';
comment on column TB_CQSSC_HIS.ORIGIN_TB_NAME
  is '����ʷ��������Ӧ��ԭʼ�洢���ݱ�����';
comment on column TB_CQSSC_HIS.ORIGIN_ID
  is '����ʷ��������Ӧ��ԭʼ�洢����ID';
comment on column TB_CQSSC_HIS.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_CQSSC_HIS.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_CQSSC_HIS.MONEY
  is 'Ͷע����λ��';
comment on column TB_CQSSC_HIS.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_CQSSC_HIS.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_CQSSC_HIS.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_HIS.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_HIS.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_HIS.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_CQSSC_HIS.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_CQSSC_HIS.PLATE
  is 'A��B��C������';
comment on column TB_CQSSC_HIS.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_CQSSC_HIS.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_CQSSC_HIS.WIN_AMOUNT
  is '��λԪ';
comment on column TB_CQSSC_HIS.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_CQSSC_HIS
  add constraint PK_TB_CQSSC_HIS primary key (ID);
create index INDEX_CQ_HIS_BETTING_DATE_USER on TB_CQSSC_HIS (BETTING_USER_ID, BETTING_DATE);
create index INDEX_CQ_HIS_BETTING_USER on TB_CQSSC_HIS (BETTING_USER_ID);

prompt
prompt Creating table TB_CQSSC_PERIODS_INFO
prompt ====================================
prompt
create table TB_CQSSC_PERIODS_INFO
(
  ID             NUMBER(10) not null,
  PERIODS_NUM    VARCHAR2(11) not null,
  OPEN_QUOT_TIME DATE not null,
  LOTTERY_TIME   DATE not null,
  STOP_QUOT_TIME DATE not null,
  RESULT1        INTEGER,
  RESULT2        INTEGER,
  RESULT3        INTEGER,
  RESULT4        INTEGER,
  RESULT5        INTEGER,
  STATE          CHAR(1) default '1' not null,
  CREATE_USER    NUMBER(10),
  CREATE_TIME    DATE default sysdate not null
)
;
comment on column TB_CQSSC_PERIODS_INFO.PERIODS_NUM
  is 'Ͷע���������� 20120203001������Ψһ�ԣ���Ź���Ϊ������+�淨�����������';
comment on column TB_CQSSC_PERIODS_INFO.RESULT1
  is '��������Ӧ�Ŀ�������еĵ�һ����ֵ';
comment on column TB_CQSSC_PERIODS_INFO.RESULT2
  is '��������Ӧ�Ŀ�������еĵڶ�����ֵ';
comment on column TB_CQSSC_PERIODS_INFO.STATE
  is '����״̬��ȡֵ���£�0 �� �ѽ��ã�1 �� δ���̣�2 �� �ѿ��̣�3 �� �ѷ��̣�4 �� �ѿ�����Ĭ��ֵΪ 1 �� δ����';
comment on column TB_CQSSC_PERIODS_INFO.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_CQSSC_PERIODS_INFO
  add constraint PK_TB_CQSSC_PERIODS_INFO primary key (ID);
create index INDEX_CQ_LOTTERY_TIME on TB_CQSSC_PERIODS_INFO (LOTTERY_TIME);
create index INDEX_CQ_OPEN_TIME on TB_CQSSC_PERIODS_INFO (OPEN_QUOT_TIME);
create index INDEX_CQ_STOP_TIME on TB_CQSSC_PERIODS_INFO (STOP_QUOT_TIME);

prompt
prompt Creating table TB_DEFAULT_PLAY_ODDS
prompt ===================================
prompt
create table TB_DEFAULT_PLAY_ODDS
(
  ID               NUMBER(10) not null,
  PLAY_TYPE_CODE   VARCHAR2(30) not null,
  ODDS             NUMBER(12,4) not null,
  ODDS_TYPE        VARCHAR2(30),
  ODDS_TYPE_X      VARCHAR2(30),
  AUTO_ODDS_QUOTAS NUMBER,
  AUTO_ODDS        NUMBER(12,4),
  LOWEST_ODDS      NUMBER(12,4),
  BIGEST_ODDS      NUMBER(12,4),
  CUT_ODDS_B       NUMBER(12,4),
  CUT_ODDS_C       NUMBER(12,4),
  UPDATE_DATE      DATE,
  UPDATE_USER      NUMBER(10),
  REMARK           NVARCHAR2(200)
)
;
comment on table TB_DEFAULT_PLAY_ODDS
  is ' ';
comment on column TB_DEFAULT_PLAY_ODDS.PLAY_TYPE_CODE
  is '�淨���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_DEFAULT_PLAY_ODDS.ODDS
  is 'Ĭ������ֵ';
comment on column TB_DEFAULT_PLAY_ODDS.ODDS_TYPE
  is '���������ͣ���һ�� �ȣ�';
comment on column TB_DEFAULT_PLAY_ODDS.ODDS_TYPE_X
  is '���һЩ�����淨�������ͣ��磺���أ�����1����˫��С��������';
comment on column TB_DEFAULT_PLAY_ODDS.AUTO_ODDS_QUOTAS
  is '�Զ������ʶ��';
comment on column TB_DEFAULT_PLAY_ODDS.AUTO_ODDS
  is 'ÿ�ν�����';
comment on column TB_DEFAULT_PLAY_ODDS.LOWEST_ODDS
  is '�������';
comment on column TB_DEFAULT_PLAY_ODDS.BIGEST_ODDS
  is 'A����������';
comment on column TB_DEFAULT_PLAY_ODDS.CUT_ODDS_B
  is 'B�����ʽ�';
comment on column TB_DEFAULT_PLAY_ODDS.CUT_ODDS_C
  is 'C�����ʽ�';
comment on column TB_DEFAULT_PLAY_ODDS.UPDATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_DEFAULT_PLAY_ODDS
  add constraint PK_TB_DEFAULT_PLAY_ODDS primary key (ID);

prompt
prompt Creating table TB_FRAME_AREA_ROLE
prompt =================================
prompt
create table TB_FRAME_AREA_ROLE
(
  ID              NUMBER(10) not null,
  AREA_ID         NUMBER(10) not null,
  ROLE_ID         NUMBER(10) not null,
  AREA_ENTITY_ID  NUMBER(10) not null,
  AUTHORIZ_TYPE   CHAR(1) default '1',
  AREA_VALUE_TYPE CHAR(1),
  REMARK          NVARCHAR2(200)
)
;
comment on table TB_FRAME_AREA_ROLE
  is 'Ȩ����ͽ�ɫ�Ĺ�������¼��ɫ��ӵ�е�Ȩ������Ϣ';
comment on column TB_FRAME_AREA_ROLE.ID
  is '��������';
comment on column TB_FRAME_AREA_ROLE.AREA_ID
  is '��ID������Ȩ����ֵ���͵Ĳ�ͬ���˴��洢�����ݺ���Ҳ��ͬ';
comment on column TB_FRAME_AREA_ROLE.ROLE_ID
  is '��ɫID���������������ɫ�������';
comment on column TB_FRAME_AREA_ROLE.AREA_ENTITY_ID
  is 'Ȩ����ʵ��ID���������¼��Ȩ��ص�Ȩ����ID����Ӧ��Ȩ����ʵ��ID�������ֶβ�����Ϣ���ࣩ';
comment on column TB_FRAME_AREA_ROLE.AUTHORIZ_TYPE
  is '��Ȩ���ͣ�����Ȩ���������ͽṹ�����ɴ��ֶξ�����Ȩ�Ƿ񴫵ݵ��ӽڵ㡣
0-������Ȩ�����Ը��ڵ����Ȩ��Ҫ���ݵ��ӽڵ㣩��1-������Ȩ����Ȩ�����ݵ��ӽڵ㣩��Ĭ��ֵ 1
�����ֶ���ʱ��ʹ�ã�ĿǰȨ����ֵ����ϵͳ�����Ļ������û�����֧�ֲ㼶��';
comment on column TB_FRAME_AREA_ROLE.AREA_VALUE_TYPE
  is '0-��ֵͨ����ID�д洢Ȩ����ֵID�����������ظ��û�ʹ�õ�Ȩ����Ϣ��Ȩ�����ж�Ӧ��Ȩ����ֵ���룩��1-�������ݣ���ID�д洢�������еĻ���ID�����������ظ��û�ʹ�õ�Ȩ����Ϣ�Ǵ˱�����ID����Ӧ��ֵ����2-�û����ݣ���ID�д洢�û����е��û�ID�����������ظ��û�ʹ�õ�Ȩ����Ϣ�Ǵ˱�����ID����Ӧ��ֵ��';
alter table TB_FRAME_AREA_ROLE
  add constraint PK_TB_FRAME_AREA_ROLE primary key (ID);

prompt
prompt Creating table TB_FRAME_AUTHORIZ_AREA
prompt =====================================
prompt
create table TB_FRAME_AUTHORIZ_AREA
(
  ID               NUMBER(10) not null,
  AREA_CODE        VARCHAR2(20) not null,
  AREA_NAME        NVARCHAR2(40) not null,
  AREA_TYPE        CHAR(1) not null,
  DEFAULT_AUTHORIZ CHAR(1) default '1',
  LINK_DATA        CHAR(1) default '0',
  AREA_STATE       CHAR(1) default '0' not null,
  PARENT_AREA      NUMBER(10) not null,
  SORT_NUM         NUMBER(4) default 1,
  REMARK           NVARCHAR2(200)
)
;
comment on table TB_FRAME_AUTHORIZ_AREA
  is '1���˱��д��Ȩ������Ϣ
';
comment on column TB_FRAME_AUTHORIZ_AREA.ID
  is '��ID';
comment on column TB_FRAME_AUTHORIZ_AREA.AREA_CODE
  is '�����';
comment on column TB_FRAME_AUTHORIZ_AREA.AREA_NAME
  is '������';
comment on column TB_FRAME_AUTHORIZ_AREA.AREA_TYPE
  is '1-���ࣻ2-ҵ��3-Ȩ����ʵ�壻4-Ȩ����ȡֵ�������ҵ����Ҫ������֯Ȩ������Ҳ����˵����ȡȨ������Ϣ��ʱ��ֻҪ��עȡֵΪ3��4�ļ���';
comment on column TB_FRAME_AUTHORIZ_AREA.DEFAULT_AUTHORIZ
  is '0-����Ȩ�ޣ�1-����Ȩ�ޣ�Ĭ��ֵ 1�����ֶ�ֻ��������Ϊ3-Ȩ����ʵ���ǲ���Ч';
comment on column TB_FRAME_AUTHORIZ_AREA.LINK_DATA
  is '0-���ⲿ�������ݣ�1-���ӻ��������ݣ�2-�����û������ݣ�Ĭ��ֵȡ0�����ֶ�ֻ��������Ϊ3-Ȩ����ʵ��ʱ����Ч��';
comment on column TB_FRAME_AUTHORIZ_AREA.AREA_STATE
  is '��״̬��0-���ã�1-δ���ã�Ĭ��ֵΪ0';
comment on column TB_FRAME_AUTHORIZ_AREA.PARENT_AREA
  is '�ϼ��򣬶�Ӧ�������ID��AREA_ID�������ֵΪ����ID�����ʾ�Ǹ��ڵ�';
comment on column TB_FRAME_AUTHORIZ_AREA.SORT_NUM
  is '������ţ�Ĭ��ֵ 1';
alter table TB_FRAME_AUTHORIZ_AREA
  add constraint PK_TB_FRAME_AUTHORIZ_AREA primary key (ID);
create index INDEX_AUTHORIZ_AREA_CODE on TB_FRAME_AUTHORIZ_AREA (AREA_CODE);

prompt
prompt Creating table TB_FRAME_DEMO
prompt ============================
prompt
create table TB_FRAME_DEMO
(
  ID          NUMBER(10) not null,
  NAME        NVARCHAR2(40),
  CODE        VARCHAR2(20),
  STATE       CHAR(1),
  CREATE_TIME DATE,
  REMARK      NVARCHAR2(200)
)
;
comment on table TB_FRAME_DEMO
  is '���Ա�';
comment on column TB_FRAME_DEMO.STATE
  is '0-���ã�1-����';
alter table TB_FRAME_DEMO
  add constraint PK_TB_FRAME_DEMO primary key (ID);

prompt
prompt Creating table TB_FRAME_FUNCTION
prompt ================================
prompt
create table TB_FRAME_FUNCTION
(
  ID          NUMBER(10) not null,
  FUNC_CODE   VARCHAR2(40) not null,
  FUNC_NAME   NVARCHAR2(40) not null,
  FUNC_STATE  CHAR(1) default '0' not null,
  FUNC_URL    NVARCHAR2(200),
  PARENT_FUNC NUMBER(10) not null,
  ICON_PATH   NVARCHAR2(150) default '/sysmenu/images/pub_3_1.gif',
  SORT_NUM    NUMBER(4) default 1,
  FUNC_DESC   NVARCHAR2(200)
)
;
comment on table TB_FRAME_FUNCTION
  is '���ܱ���Ӧ����Ĺ�����Ϣ';
comment on column TB_FRAME_FUNCTION.ID
  is '��������';
comment on column TB_FRAME_FUNCTION.FUNC_STATE
  is '����״̬��0-���ã�1-δ���ã�Ĭ��ֵ0';
comment on column TB_FRAME_FUNCTION.FUNC_URL
  is '���ܿ��԰��������Դ���˴��洢�˹��ܵ����URL��������Servlet��';
comment on column TB_FRAME_FUNCTION.PARENT_FUNC
  is '��������Ӧ���ϼ��ڵ㣬��Ӧ�����ID,���ֵΪ�������ʾ�Ǹ��ڵ�';
comment on column TB_FRAME_FUNCTION.ICON_PATH
  is 'ͼ���ַ';
comment on column TB_FRAME_FUNCTION.SORT_NUM
  is '������ţ�Ĭ��ֵ 1';
alter table TB_FRAME_FUNCTION
  add constraint PK_TB_FRAME_FUNCTION primary key (ID);

prompt
prompt Creating table TB_FRAME_MANAGER_STAFF
prompt =====================================
prompt
create table TB_FRAME_MANAGER_STAFF
(
  ID                    NUMBER(10) not null,
  ACCOUNT               NVARCHAR2(50) not null,
  FLAG                  CHAR(1) default '0' not null,
  USER_TYPE             CHAR(1) not null,
  USER_EXT_INFO_ID      NUMBER(10),
  USER_PWD              VARCHAR2(32) not null,
  CHS_NAME              NVARCHAR2(50),
  ENG_NAME              VARCHAR2(50),
  EMAIL_ADDR            NVARCHAR2(50),
  OFFICE_PHONE          NVARCHAR2(50),
  MOBILE_PHONE          NVARCHAR2(50),
  FAX                   NVARCHAR2(50),
  CREATE_DATE           DATE,
  UPDATE_DATE           DATE,
  LOGIN_DATE            DATE,
  LOGIN_IP              VARCHAR2(15),
  COMMENTS              CHAR(1),
  PARENT_STAFF_QRY      NUMBER(10),
  PARENT_STAFF_TYPE_QRY CHAR(1),
  PRE_FLAG              CHAR(1) default '0',
  PASSWORD_UPDATE_DATE  DATE default TRUNC(SYSDATE),
  PASSWORD_RESET_FLAG   VARCHAR2(1) default 'Y'
)
;
comment on table TB_FRAME_MANAGER_STAFF
  is '�����û��������洢�����û��Ļ�����Ϣ����';
comment on column TB_FRAME_MANAGER_STAFF.FLAG
  is '�Ƿ���Ч����ʾ���û���״̬��0 �� ��Ч��1 �� ���ã�2 �������᣻3 �� ��ɾ����Ĭ��ֵΪ0';
comment on column TB_FRAME_MANAGER_STAFF.USER_TYPE
  is '0 �� ϵͳ����Ա��1 �� �ܹ��û���2 �� �ܼ��û���3 �� �ֹ�˾�û���4 �� �ɶ��û���5 �� �ܴ����û���6 �� �����û���7 �� ���˺�';
comment on column TB_FRAME_MANAGER_STAFF.USER_EXT_INFO_ID
  is '�û���չ��ϢID��ϵͳ�У���ͬ���û���������Ӧ�ĸ��Ի���չ��Ϣ��¼�ڸ��Զ�Ӧ����Ϣ���У�ϵͳ�û�����չ��Ϣ�����˴���¼��Ӧ�ļ�¼ID��

����Ŀǰ��ϵͳ�߼��ṹ��ƣ������û���������Ӧ����չ��ʹ�û������ID��Ϊ�������ʴ˴���ȡֵ�뱾���е�IDֵ��ͬ';
comment on column TB_FRAME_MANAGER_STAFF.USER_PWD
  is '���ܵ��û�����';
comment on column TB_FRAME_MANAGER_STAFF.LOGIN_DATE
  is '����¼ʱ��';
comment on column TB_FRAME_MANAGER_STAFF.LOGIN_IP
  is '����¼IP';
comment on column TB_FRAME_MANAGER_STAFF.PRE_FLAG
  is '��һ���û�״̬��������ǰ��״̬';
alter table TB_FRAME_MANAGER_STAFF
  add constraint PK_TB_FRAME_MANAGER_STAFF primary key (ID);

prompt
prompt Creating table TB_FRAME_MEMBER_STAFF
prompt ====================================
prompt
create table TB_FRAME_MEMBER_STAFF
(
  ID                    NUMBER(10) not null,
  ACCOUNT               NVARCHAR2(50) not null,
  FLAG                  CHAR(1) default '0' not null,
  USER_TYPE             CHAR(1) not null,
  USER_EXT_INFO_ID      NUMBER(10),
  USER_PWD              VARCHAR2(32) not null,
  CHS_NAME              NVARCHAR2(50),
  ENG_NAME              VARCHAR2(50),
  EMAIL_ADDR            NVARCHAR2(50),
  OFFICE_PHONE          NVARCHAR2(50),
  MOBILE_PHONE          NVARCHAR2(50),
  FAX                   NVARCHAR2(50),
  CREATE_DATE           DATE,
  UPDATE_DATE           DATE,
  LOGIN_DATE            DATE,
  LOGIN_IP              VARCHAR2(15),
  COMMENTS              NVARCHAR2(200),
  PARENT_STAFF_QRY      NUMBER(10),
  PARENT_STAFF_TYPE_QRY CHAR(1),
  PRE_FLAG              CHAR(1) default '0',
  PASSWORD_UPDATE_DATE  DATE default TRUNC(SYSDATE),
  PASSWORD_RESET_FLAG   VARCHAR2(1) default 'Y'
)
;
comment on column TB_FRAME_MEMBER_STAFF.FLAG
  is '�Ƿ���Ч����ʾ���û���״̬��0 �� ��Ч��1 �� ���ã�2 �� ���᣻3 �� ��ɾ����Ĭ��ֵΪ0';
comment on column TB_FRAME_MEMBER_STAFF.USER_TYPE
  is '9 �� ��ͨ��Ա�û���ע��ȡֵ����̳��Թ����û����������û����ͣ��Ա�ϵͳά����';
comment on column TB_FRAME_MEMBER_STAFF.USER_EXT_INFO_ID
  is '�û���չ��ϢID����¼��Ա��չ��Ϣ���ж�Ӧ�����ݼ�¼��ID';
comment on column TB_FRAME_MEMBER_STAFF.USER_PWD
  is '���ܵ��û�����';
comment on column TB_FRAME_MEMBER_STAFF.LOGIN_DATE
  is '����¼ʱ��';
comment on column TB_FRAME_MEMBER_STAFF.LOGIN_IP
  is '����¼IP';
comment on column TB_FRAME_MEMBER_STAFF.PARENT_STAFF_QRY
  is '��ID';
comment on column TB_FRAME_MEMBER_STAFF.PARENT_STAFF_TYPE_QRY
  is '��ID  TYPE';
comment on column TB_FRAME_MEMBER_STAFF.PRE_FLAG
  is '��һ���û�״̬��������ǰ��״̬';
alter table TB_FRAME_MEMBER_STAFF
  add constraint PK_TB_FRAME_MEMBER_STAFF primary key (ID);

prompt
prompt Creating table TB_FRAME_ORG
prompt ===========================
prompt
create table TB_FRAME_ORG
(
  ORGID      NUMBER(10) not null,
  UPORGID    NUMBER(10),
  ADOUNAME   NVARCHAR2(254),
  ORGNAM     NVARCHAR2(254),
  SHORTNAME  NVARCHAR2(50),
  SHOWORDER  NUMBER(10),
  ORGTYPE    NUMBER(5),
  ORGAREA    NVARCHAR2(254),
  SUBORGNUM  NUMBER(5),
  SAPID      NVARCHAR2(50),
  ISREALORG  CHAR(1),
  CREATEDATE DATE
)
;
comment on table TB_FRAME_ORG
  is '������Ϣ����EIAC����������һ��';
comment on column TB_FRAME_ORG.ORGID
  is '����ID';
comment on column TB_FRAME_ORG.ORGTYPE
  is '0 ��˾ Company ��1 �ֹ�˾ Filiale ��2 ���� Departments ��3 ���� Divisions ��4 ���� Sections ��5 ���� Center
';
alter table TB_FRAME_ORG
  add constraint PK_TB_FRAME_ORG primary key (ORGID);

prompt
prompt Creating table TB_FRAME_ORG_EXT
prompt ===============================
prompt
create table TB_FRAME_ORG_EXT
(
  ORGID         NUMBER(10) not null,
  CHANNEL_ID    NVARCHAR2(3),
  SALE_TYPE     NVARCHAR2(3),
  CMMS_ORG_ID   NUMBER(10),
  CMMS_ORG_NAME NVARCHAR2(60),
  ORG_TYPE1     NVARCHAR2(3),
  ORG_TYPE2     NVARCHAR2(3),
  ACCESS_ORG    NUMBER(10)
)
;
comment on table TB_FRAME_ORG_EXT
  is '������չ���Ա���¼�������в����ڣ���ʵ��ҵ����ʹ�õ��������Ϣ';
comment on column TB_FRAME_ORG_EXT.ORGID
  is '����ID,��tb_crm_org����һһ��Ӧ';
comment on column TB_FRAME_ORG_EXT.CHANNEL_ID
  is '����������000-ȫ����001-����002-��ͥ��003-���ˡ�004-����';
comment on column TB_FRAME_ORG_EXT.SALE_TYPE
  is '�Ƿ����۲��ţ�Ӫ����������000-�ǡ�001-����';
comment on column TB_FRAME_ORG_EXT.CMMS_ORG_ID
  is 'Ӫ������ID����ӦCMMS����tb_sm_org ��ORG_ID,��Ӫ���������ֶ�Ϊ��';
comment on column TB_FRAME_ORG_EXT.CMMS_ORG_NAME
  is 'Ӫ���������ƣ���Ӫ���������ֶ�Ϊ��';
comment on column TB_FRAME_ORG_EXT.ORG_TYPE1
  is '����������ࣺ001-�г���Ӫ�ߡ�002-������Ӫ�ߡ�003-����ܿ��ߡ�004-����ֹ�˾';
comment on column TB_FRAME_ORG_EXT.ORG_TYPE2
  is '����������ࣺ001-��Ӫ��002-��Ӫ��003-֧��';
comment on column TB_FRAME_ORG_EXT.ACCESS_ORG
  is 'Ĭ�Ϸ��ʻ������ò�����ԱĬ�ϵķ��ʻ���';
alter table TB_FRAME_ORG_EXT
  add constraint PK_TB_FRAME_ORG_EXT primary key (ORGID);

prompt
prompt Creating table TB_FRAME_PARAM
prompt =============================
prompt
create table TB_FRAME_PARAM
(
  ID           NUMBER(10) not null,
  CODE         VARCHAR2(50) not null,
  NAME         NVARCHAR2(50) not null,
  TYPE         CHAR(1) default '2' not null,
  STATE        CHAR(1) default '0' not null,
  VALUE_TYPE   CHAR(1) default '9',
  PARENT_PARAM NUMBER(10),
  SORT_NUM     NUMBER(4) default 1,
  REMARK       NVARCHAR2(200)
)
;
comment on table TB_FRAME_PARAM
  is '����������Ų�������Ϣ���硰״̬����һ���������';
comment on column TB_FRAME_PARAM.ID
  is '��������';
comment on column TB_FRAME_PARAM.CODE
  is '�������룬�����ظ���
Ϊ�˷�ֹ�������ң���ϵͳ������Լ������������code��������Ϊ��ģ����_����Ĳ���������ƣ��� Demo_State';
comment on column TB_FRAME_PARAM.NAME
  is '��������';
comment on column TB_FRAME_PARAM.TYPE
  is '�������ͣ�1-ϵͳ��ʼ��������2-��ͨ����';
comment on column TB_FRAME_PARAM.STATE
  is '״̬��0-���ã�1-δ���ã�Ĭ��ֵ0';
comment on column TB_FRAME_PARAM.VALUE_TYPE
  is '����ֵ���ͣ�1-���ͣ�2-�ַ����ͣ�9-������Ĭ��ֵ9�����ֶ���ʱ��ʹ��';
comment on column TB_FRAME_PARAM.PARENT_PARAM
  is '�ϼ������ڵ㣬��Ӧ�����ID,���ֵΪ�������ʾ�Ǹ��ڵ�';
comment on column TB_FRAME_PARAM.SORT_NUM
  is '������ţ�Ĭ��ֵ1';
comment on column TB_FRAME_PARAM.REMARK
  is '��ע';
alter table TB_FRAME_PARAM
  add constraint PK_TB_FRAME_PARAM primary key (ID);
create unique index INDEX_PARAM_CODE on TB_FRAME_PARAM (CODE);

prompt
prompt Creating table TB_FRAME_PARAM_VALUE
prompt ===================================
prompt
create table TB_FRAME_PARAM_VALUE
(
  ID       NUMBER(10) not null,
  PARAM_ID NUMBER(10) not null,
  CODE     VARCHAR2(50) not null,
  NAME     NVARCHAR2(50) not null,
  VALUE    NVARCHAR2(20) not null,
  SORT_NUM NUMBER(4) default 1,
  REMARK   NVARCHAR2(200)
)
;
comment on table TB_FRAME_PARAM_VALUE
  is '����ֵ����Ų�����ֵ����Ϣ����������Ϊ��״̬���Ĳ���������ȡֵ�����ǡ����á������á��ȣ���Щ���ݴ洢�ٴ˱���';
comment on column TB_FRAME_PARAM_VALUE.ID
  is '��������';
comment on column TB_FRAME_PARAM_VALUE.PARAM_ID
  is '����ID���������Ӧ�ڲ�������TB_CRM_PARAM����ID';
comment on column TB_FRAME_PARAM_VALUE.CODE
  is '����ֵ����';
comment on column TB_FRAME_PARAM_VALUE.NAME
  is '����ֵ������';
comment on column TB_FRAME_PARAM_VALUE.SORT_NUM
  is '������ţ�Ĭ��ֵ1';
comment on column TB_FRAME_PARAM_VALUE.REMARK
  is '��ע';
alter table TB_FRAME_PARAM_VALUE
  add constraint PK_TB_FRAME_PARAM_VALUE primary key (ID);
alter table TB_FRAME_PARAM_VALUE
  add constraint FK_FRAME_REF_FRAME4 foreign key (PARAM_ID)
  references TB_FRAME_PARAM (ID);

prompt
prompt Creating table TB_FRAME_RESOURCE
prompt ================================
prompt
create table TB_FRAME_RESOURCE
(
  ID        NUMBER(10) not null,
  FUNC_ID   NUMBER(10) not null,
  RES_CODE  VARCHAR2(60) not null,
  RES_NAME  NVARCHAR2(60) not null,
  RES_STATE CHAR(1) default '0' not null,
  RES_TYPE  CHAR(1) default '0' not null,
  SORT_NUM  NUMBER(4) default 1,
  URL       NVARCHAR2(2000) not null,
  RES_DESC  NVARCHAR2(200)
)
;
comment on table TB_FRAME_RESOURCE
  is 'ϵͳ��Դ�����ϵͳ�Ĺ���ģ�顢���ܰ�ť����Դ��Ϣ';
comment on column TB_FRAME_RESOURCE.ID
  is '��������';
comment on column TB_FRAME_RESOURCE.FUNC_ID
  is '��Դ����Ӧ�Ĺ���ID����Ӧ���ܱ�TB_FRAME_FUNCTION��ID';
comment on column TB_FRAME_RESOURCE.RES_NAME
  is '��������';
comment on column TB_FRAME_RESOURCE.RES_STATE
  is '��Դ״̬��0-���ã�1-���ã�Ĭ��ֵ0';
comment on column TB_FRAME_RESOURCE.RES_TYPE
  is '��Դ���ͣ�0-ҳ�棨url������servlet����1-ҳ����Դ�����ܰ�ť�������ӵȣ���Ĭ��ֵΪ0';
comment on column TB_FRAME_RESOURCE.SORT_NUM
  is '������ţ�Ĭ��ֵΪ1';
comment on column TB_FRAME_RESOURCE.URL
  is 'URL��ֻ�е���Դ���ͣ�RES_TYPE���ֶε�ֵΪ0ʱ���������壬��ͬURL֮��ʹ�ð�ǵ�;;�ָ�';
comment on column TB_FRAME_RESOURCE.RES_DESC
  is '��Դ����';
alter table TB_FRAME_RESOURCE
  add constraint PK_TB_FRAME_RESOURCE primary key (ID);

prompt
prompt Creating table TB_FRAME_ROLES
prompt =============================
prompt
create table TB_FRAME_ROLES
(
  ID          NUMBER(10) not null,
  ROLE_CODE   NVARCHAR2(40) not null,
  ROLE_NAME   NVARCHAR2(40) not null,
  ROLE_LEVEL  CHAR(1) not null,
  ROLE_TYPE   CHAR(1) not null,
  PARENT_ROLE NUMBER(10),
  SORT_NUM    NUMBER(4) default 1,
  REMARK      NVARCHAR2(200)
)
;
comment on table TB_FRAME_ROLES
  is '��ɫ���ݱ�';
comment on column TB_FRAME_ROLES.ID
  is '����������ǰ4000��ֵԤ������ʼ����ɫ';
comment on column TB_FRAME_ROLES.ROLE_CODE
  is '��ɫ���룬���ڽ�ɫ����Ϊ˽�����͵Ľ�ɫ���˴���Ŷ�Ӧ˽��ʵ��ID��������һ���Զ�����ַ���';
comment on column TB_FRAME_ROLES.ROLE_NAME
  is '��ɫ����';
comment on column TB_FRAME_ROLES.ROLE_LEVEL
  is '0 �� ϵͳ����Ա��1 �� �����û���2 �� ��Ա�û�';
comment on column TB_FRAME_ROLES.ROLE_TYPE
  is '��ɫ���ͣ�
0 �� ��Դ��ɫ
1 �� ��־��ɫ�������͵Ľ�ɫû�ж�Ӧ�Ĺ�����Ϣ��ֻ��������־һ��Ⱥ���û�����ĳ����ͬ�����Զ��ѣ��˽�ɫ��ҳ���ϲ��ṩά�������û���ɫ��Ȩʱ��Ҫ�г���������ϵͳ��ʼ��ʱ���ɣ��������н�ɫ����Ϊ�û�Ⱥ�Ľ�ɫ֮�䣬��ɫ�������Ψһ�ԡ�
2 �� ˽�н�ɫ����Ӧ�����û���˽�н�ɫ����ɫ�����д�Ŵ�˽�н�ɫ����Ӧ���û�ID��
3 �� ���ý�ɫ��ϵͳ��ʼ��ʱ�����ɵ����ý�ɫ����ϵͳ����ԱĬ�Ͻ�ɫ���ܹ�Ĭ�Ͻ�ɫ��

˵����˽�н�ɫָ�������ض��û������Ľ�ɫ����Щ��ɫֻ��ʹ���ڶ�Ӧ��˽���û�������������ͨ��ɫ����������������û�������˽�н�ɫ����ɫ�����д�ŵļ�Ϊӵ�д�˽��Ȩ��ʵ���ID';
comment on column TB_FRAME_ROLES.PARENT_ROLE
  is '�ϼ���ɫ�ڵ㣬��Ӧ�����ID,���ֵΪ �������ʾ�Ǹ��ڵ�';
comment on column TB_FRAME_ROLES.SORT_NUM
  is '������ţ�Ĭ��ֵ1';
alter table TB_FRAME_ROLES
  add constraint PK_TB_FRAME_ROLES primary key (ID);

prompt
prompt Creating table TB_FRAME_ROLE_FUNC
prompt =================================
prompt
create table TB_FRAME_ROLE_FUNC
(
  ID            NUMBER(10) not null,
  ROLE_ID       NUMBER(10) not null,
  FUNC_ID       NUMBER(10) not null,
  AUTHORIZ_TYPE CHAR(1) default '1' not null,
  REMARK        NVARCHAR2(200)
)
;
comment on table TB_FRAME_ROLE_FUNC
  is '��ɫ��ӵ�еĹ���';
comment on column TB_FRAME_ROLE_FUNC.ID
  is '��������';
comment on column TB_FRAME_ROLE_FUNC.ROLE_ID
  is '��ɫID���������Ӧ��ɫ���ID';
comment on column TB_FRAME_ROLE_FUNC.FUNC_ID
  is '����ID���������Ӧ���ܱ��ID';
comment on column TB_FRAME_ROLE_FUNC.AUTHORIZ_TYPE
  is '��Ȩ���ͣ����ڹ��������ͽṹ�����ɴ��ֶξ�����Ȩ�Ƿ񴫵ݵ��ӽڵ㡣
0-������Ȩ�����Ը��ڵ����Ȩ���Զ����ݵ��ӽڵ㣩��1-������Ȩ����Ȩ�����ݵ��ӽڵ㣩��Ĭ��ֵ 1';
alter table TB_FRAME_ROLE_FUNC
  add constraint PK_TB_FRAME_ROLE_FUNC primary key (ID);
alter table TB_FRAME_ROLE_FUNC
  add constraint FK_TB_CRM_R_REFEREE_TB_CRM_F foreign key (FUNC_ID)
  references TB_FRAME_FUNCTION (ID);
alter table TB_FRAME_ROLE_FUNC
  add constraint FK_TB_CRM_R_REFERE_TB_CRM_R foreign key (ROLE_ID)
  references TB_FRAME_ROLES (ID);

prompt
prompt Creating table TB_FRAME_STAFF
prompt =============================
prompt
create table TB_FRAME_STAFF
(
  ID           NUMBER(10) not null,
  ORG_ID       NUMBER(10) not null,
  ACCOUNT      NVARCHAR2(50) not null,
  FLAG         CHAR(1) default '0' not null,
  USER_PWD     VARCHAR2(32) not null,
  CHS_NAME     NVARCHAR2(50),
  ENG_NAME     VARCHAR2(50),
  EMAIL_ADDR   NVARCHAR2(50),
  OFFICE_PHONE NVARCHAR2(50),
  MOBILE_PHONE NVARCHAR2(50),
  FAX          NVARCHAR2(50),
  CREATE_DATE  DATE,
  UPDATE_DATE  DATE,
  LOGIN_DATE   DATE,
  LOGIN_IP     VARCHAR2(15),
  COMMENTS     NVARCHAR2(200)
)
;
comment on table TB_FRAME_STAFF
  is '��Ա��Ϣ��';
comment on column TB_FRAME_STAFF.ID
  is '�û�����';
comment on column TB_FRAME_STAFF.ORG_ID
  is '������������Ӧ�ڻ�����tb_crm_org���Ļ���ID��ORG_ID��';
comment on column TB_FRAME_STAFF.FLAG
  is '�Ƿ���Ч����ʾ���û���״̬��0 �� ��Ч��1 �� ���ã�2 �� ��ɾ����Ĭ��ֵΪ0';
comment on column TB_FRAME_STAFF.USER_PWD
  is '���ܵ��û�����';
comment on column TB_FRAME_STAFF.LOGIN_DATE
  is '����¼ʱ��';
comment on column TB_FRAME_STAFF.LOGIN_IP
  is '����¼IP';
alter table TB_FRAME_STAFF
  add constraint PK_TB_FRAME_STAFF primary key (ID);

prompt
prompt Creating table TB_FRAME_STAFF_ROLE
prompt ==================================
prompt
create table TB_FRAME_STAFF_ROLE
(
  ID        NUMBER(10) not null,
  ROLE_ID   NUMBER(10) not null,
  STAFF_ID  NUMBER(10) not null,
  USER_TYPE CHAR(1),
  REMARK    NVARCHAR2(200)
)
;
comment on table TB_FRAME_STAFF_ROLE
  is '�����Ա�ͽ�ɫ�Ķ�Ӧ��Ϣ';
comment on column TB_FRAME_STAFF_ROLE.ID
  is '��������';
comment on column TB_FRAME_STAFF_ROLE.ROLE_ID
  is '��ɫID���������Ӧ��ɫ���ID';
comment on column TB_FRAME_STAFF_ROLE.STAFF_ID
  is 'Ա�����ţ��������Ӧ��Ա���Ա������';
comment on column TB_FRAME_STAFF_ROLE.USER_TYPE
  is '0 �� ϵͳ����Ա��1 �� �ܹ��û���2 �� �ܼ��û���3 �� �ֹ�˾�û���4 �� �ɶ��û���5 �� �ܴ����û���6 �� �����û���7 �� ��ͨ��Ա�û�';
alter table TB_FRAME_STAFF_ROLE
  add constraint PK_TB_FRAME_STAFF_ROLE primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_EIGHTH
prompt ====================================
prompt
create table TB_GDKLSF_BALL_EIGHTH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_BALL_EIGHTH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_EIGHTH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_EIGHTH.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_EIGHTH.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_EIGHTH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_EIGHTH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_EIGHTH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_EIGHTH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_EIGHTH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_EIGHTH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_EIGHTH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_EIGHTH.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_EIGHTH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_EIGHTH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_EIGHTH.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_EIGHTH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_EIGHTH
  add constraint PK_TB_GDKLSF_BALL_EIGHTH primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_FIFTH
prompt ===================================
prompt
create table TB_GDKLSF_BALL_FIFTH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_BALL_FIFTH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_FIFTH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_FIFTH.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_FIFTH.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_FIFTH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_FIFTH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_FIFTH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIFTH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIFTH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIFTH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIFTH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_FIFTH.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_FIFTH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_FIFTH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_FIFTH.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_FIFTH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_FIFTH
  add constraint PK_TB_GDKLSF_BALL_FIFTH primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_FIRST
prompt ===================================
prompt
create table TB_GDKLSF_BALL_FIRST
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on table TB_GDKLSF_BALL_FIRST
  is '�㶫����ʮ�ֵ�һ���Ӧ��Ͷע����¼��ԱͶע��Ϣ����';
comment on column TB_GDKLSF_BALL_FIRST.ID
  is '��������';
comment on column TB_GDKLSF_BALL_FIRST.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_FIRST.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_FIRST.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_FIRST.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_FIRST.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_FIRST.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_FIRST.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIRST.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIRST.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIRST.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FIRST.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_FIRST.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_FIRST.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_FIRST.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_FIRST.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_FIRST.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_FIRST
  add constraint PK_TB_GDKLSF_BALL_FIRST primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_FORTH
prompt ===================================
prompt
create table TB_GDKLSF_BALL_FORTH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_BALL_FORTH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_FORTH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_FORTH.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_FORTH.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_FORTH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_FORTH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_FORTH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FORTH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FORTH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FORTH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_FORTH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_FORTH.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_FORTH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_FORTH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_FORTH.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_FORTH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_FORTH
  add constraint PK_TB_GDKLSF_BALL_FORTH primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_SECOND
prompt ====================================
prompt
create table TB_GDKLSF_BALL_SECOND
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_CHIEF             NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  COMMISSION_MEMBER      NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_BRANCH      NUMBER,
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_BALL_SECOND.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_SECOND.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_SECOND.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_SECOND.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_SECOND.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_SECOND.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_SECOND.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SECOND.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SECOND.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SECOND.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SECOND.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_SECOND.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_SECOND.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_SECOND.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_SECOND.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_SECOND.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_SECOND
  add constraint PK_TB_GDKLSF_BALL_SECOND primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_SEVENTH
prompt =====================================
prompt
create table TB_GDKLSF_BALL_SEVENTH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_BALL_SEVENTH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_SEVENTH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_SEVENTH.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_SEVENTH.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_SEVENTH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_SEVENTH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_SEVENTH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SEVENTH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SEVENTH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SEVENTH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SEVENTH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_SEVENTH.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_SEVENTH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_SEVENTH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_SEVENTH.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_SEVENTH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_SEVENTH
  add constraint PK_TB_GDKLSF_BALL_SEVENTH primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_SIXTH
prompt ===================================
prompt
create table TB_GDKLSF_BALL_SIXTH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_BALL_SIXTH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_SIXTH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_SIXTH.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_SIXTH.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_SIXTH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_SIXTH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_SIXTH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SIXTH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SIXTH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SIXTH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_SIXTH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_SIXTH.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_SIXTH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_SIXTH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_SIXTH.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_SIXTH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_SIXTH
  add constraint PK_TB_GDKLSF_BALL_SIXTH primary key (ID);

prompt
prompt Creating table TB_GDKLSF_BALL_THIRD
prompt ===================================
prompt
create table TB_GDKLSF_BALL_THIRD
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_BALL_THIRD.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_BALL_THIRD.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_BALL_THIRD.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_BALL_THIRD.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_BALL_THIRD.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_BALL_THIRD.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_BALL_THIRD.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_THIRD.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_THIRD.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_THIRD.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_BALL_THIRD.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_BALL_THIRD.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_BALL_THIRD.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_BALL_THIRD.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_BALL_THIRD.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_BALL_THIRD.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_BALL_THIRD
  add constraint PK_TB_GDKLSF_BALL_THIRD primary key (ID);

prompt
prompt Creating table TB_GDKLSF_DOUBLE_SIDE
prompt ====================================
prompt
create table TB_GDKLSF_DOUBLE_SIDE
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_DOUBLE_SIDE.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_DOUBLE_SIDE.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_DOUBLE_SIDE.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_DOUBLE_SIDE.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_DOUBLE_SIDE.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_DOUBLE_SIDE.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_DOUBLE_SIDE.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_DOUBLE_SIDE.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_DOUBLE_SIDE.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_DOUBLE_SIDE.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_DOUBLE_SIDE.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_DOUBLE_SIDE.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_DOUBLE_SIDE.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_DOUBLE_SIDE.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_DOUBLE_SIDE.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_DOUBLE_SIDE.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_DOUBLE_SIDE
  add constraint PK_TB_GDKLSF_DOUBLE_SIDE primary key (ID);

prompt
prompt Creating table TB_GDKLSF_HIS
prompt ============================
prompt
create table TB_GDKLSF_HIS
(
  ID                     NUMBER(10) not null,
  CREATE_DATE            DATE default sysdate,
  ORIGIN_TB_NAME         VARCHAR2(100),
  ORIGIN_ID              NUMBER(10),
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(50),
  SPLIT_ATTRIBUTE        VARCHAR2(25),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on table TB_GDKLSF_HIS
  is 'Ͷע��ʷ���洢�������ݱ��е���ʷ���ݣ�
1��Ͷע���㶫����ʮ�����룩��TB_GDKLSF_STRAIGHTTHROUGH��
2��Ͷע���㶫����ʮ�ֵ�һ�򣩱�TB_GDKLSF_BALL_FIRST��
3��Ͷע���㶫����ʮ�ֵڶ��򣩱�TB_GDKLSF_BALL_SECOND��
4��Ͷע���㶫����ʮ�ֵ����򣩱�TB_GDKLSF_BALL_THIRD��
5��Ͷע���㶫����ʮ�ֵ����򣩱�TB_GDKLSF_BALL_FORTH��
6��Ͷע���㶫����ʮ�ֵ����򣩱�TB_GDKLSF_BALL_FIFTH��
7��Ͷע���㶫����ʮ�ֵ����򣩱�TB_GDKLSF_BALL_SIXTH��
8��Ͷע���㶫����ʮ�ֵ����򣩱�TB_GDKLSF_BALL_SEVENTH��
9��Ͷע���㶫����ʮ�ֵڰ��򣩱�TB_GDKLSF_BALL_EIGHTH��
10��Ͷע���㶫����ʮ�������̼���������TB_GDKLSF_DOUBLE_SIDE��';
comment on column TB_GDKLSF_HIS.ORIGIN_TB_NAME
  is '����ʷ��������Ӧ��ԭʼ�洢���ݱ�����';
comment on column TB_GDKLSF_HIS.ORIGIN_ID
  is '����ʷ��������Ӧ��ԭʼ�洢����ID';
comment on column TB_GDKLSF_HIS.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_HIS.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_HIS.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_HIS.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_HIS.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_HIS.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_HIS.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_HIS.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_HIS.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_HIS.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_HIS.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_GDKLSF_HIS.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_HIS.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_HIS.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_HIS.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_HIS.WIN_AMOUNT
  is '��λԪ';
comment on column TB_GDKLSF_HIS.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_HIS
  add constraint PK_TB_GDKLSF_HIS primary key (ID);
create index INDEX_GD_HIS_BETTING_DATE_USER on TB_GDKLSF_HIS (BETTING_USER_ID, BETTING_DATE);
create index INDEX_GD_HIS_BETTING_USER on TB_GDKLSF_HIS (BETTING_USER_ID);

prompt
prompt Creating table TB_GDKLSF_PERIODS_INFO
prompt =====================================
prompt
create table TB_GDKLSF_PERIODS_INFO
(
  ID             NUMBER(10) not null,
  PERIODS_NUM    VARCHAR2(11) not null,
  OPEN_QUOT_TIME DATE not null,
  LOTTERY_TIME   DATE not null,
  STOP_QUOT_TIME DATE not null,
  RESULT1        INTEGER,
  RESULT2        INTEGER,
  RESULT3        INTEGER,
  RESULT4        INTEGER,
  RESULT5        INTEGER,
  RESULT6        INTEGER,
  RESULT7        INTEGER,
  RESULT8        INTEGER,
  STATE          CHAR(1) default '1' not null,
  CREATE_USER    NUMBER(10),
  CREATE_TIME    DATE default sysdate not null
)
;
comment on table TB_GDKLSF_PERIODS_INFO
  is '�㶫����ʮ��������Ϣ��';
comment on column TB_GDKLSF_PERIODS_INFO.ID
  is '��������';
comment on column TB_GDKLSF_PERIODS_INFO.PERIODS_NUM
  is 'Ͷע���������� 20120203001������Ψһ�ԣ���Ź���Ϊ������+�淨�����������';
comment on column TB_GDKLSF_PERIODS_INFO.RESULT1
  is '��������Ӧ�Ŀ�������еĵ�һ����ֵ';
comment on column TB_GDKLSF_PERIODS_INFO.RESULT2
  is '��������Ӧ�Ŀ�������еĵڶ�����ֵ';
comment on column TB_GDKLSF_PERIODS_INFO.STATE
  is '����״̬��ȡֵ���£�0 �� �ѽ��ã�1 �� δ���̣�2 �� �ѿ��̣�3 �� �ѷ��̣�4 �� �ѿ�����Ĭ��ֵΪ 1 �� δ����';
comment on column TB_GDKLSF_PERIODS_INFO.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_GDKLSF_PERIODS_INFO
  add constraint PK_TB_GDKLSF_PERIODS_INFO primary key (ID);
create index INDEX_LOTTERY_TIME on TB_GDKLSF_PERIODS_INFO (LOTTERY_TIME);
create index INDEX_OPEN_TIME on TB_GDKLSF_PERIODS_INFO (OPEN_QUOT_TIME);
create index INDEX_STOP_TIME on TB_GDKLSF_PERIODS_INFO (STOP_QUOT_TIME);

prompt
prompt Creating table TB_GDKLSF_STRAIGHTTHROUGH
prompt ========================================
prompt
create table TB_GDKLSF_STRAIGHTTHROUGH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(50),
  SPLIT_ATTRIBUTE        VARCHAR2(25),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_GDKLSF_STRAIGHTTHROUGH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.MONEY
  is 'Ͷע����λ��';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.PLATE
  is 'A��B��C������';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.WIN_AMOUNT
  is '��λ��';
comment on column TB_GDKLSF_STRAIGHTTHROUGH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_GDKLSF_STRAIGHTTHROUGH
  add constraint PK_TB_GDKLSF_STRAIGHTTHROUGH primary key (ID);

prompt
prompt Creating table TB_GEN_AGENT_STAFF_EXT
prompt =====================================
prompt
create table TB_GEN_AGENT_STAFF_EXT
(
  MANAGER_STAFF_ID      NUMBER(10) not null,
  PARENT_STAFF          NUMBER(10),
  REPLENISHMENT         CHAR(1) not null,
  GEN_AGENT_RATE        NUMBER(5,2),
  PURE_ACCOUNTED        CHAR(1),
  SHAREHOLDER_RATE      NUMBER(5,2),
  TOTAL_CREDIT_LINE     NUMBER(10),
  AVAILABLE_CREDIT_LINE NUMBER(10),
  CHIEF_STAFF           NUMBER(10),
  BRANCH_STAFF          NUMBER(10),
  RATE_RESTRICT         CHAR(1),
  BELOW_RATE_LIMIT      NUMBER(2)
)
;
comment on table TB_GEN_AGENT_STAFF_EXT
  is '�˱��м�¼�ܴ����û���չ��Ϣ�������û�������TB_FRAME_MANAGER_STAFF���д洢���ܴ����û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
7������¼IP
-----------------
�ܴ����û��ڹ����û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��5 �� �ܴ����û���';
comment on column TB_GEN_AGENT_STAFF_EXT.MANAGER_STAFF_ID
  is '�ܴ����û�������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
comment on column TB_GEN_AGENT_STAFF_EXT.PARENT_STAFF
  is '�ϼ��û�';
comment on column TB_GEN_AGENT_STAFF_EXT.REPLENISHMENT
  is '�߷ɣ���������ȡֵ�������£�0 �� �����߷ɣ�1 �� ��ֹ�߷�';
comment on column TB_GEN_AGENT_STAFF_EXT.PURE_ACCOUNTED
  is '0 �� ��ռ��1 �� �Ǵ�ռ';
comment on column TB_GEN_AGENT_STAFF_EXT.SHAREHOLDER_RATE
  is '�ɶ�ռ��';
comment on column TB_GEN_AGENT_STAFF_EXT.CHIEF_STAFF
  is '�ܴ�������Ӧ���ܼ�ID';
comment on column TB_GEN_AGENT_STAFF_EXT.BRANCH_STAFF
  is '�ܴ�������Ӧ�ķֹ�˾ID';
comment on column TB_GEN_AGENT_STAFF_EXT.RATE_RESTRICT
  is '�Ƿ�����ռ��';
comment on column TB_GEN_AGENT_STAFF_EXT.BELOW_RATE_LIMIT
  is '����ռ���޶�';
alter table TB_GEN_AGENT_STAFF_EXT
  add constraint PK_TB_GEN_AGENT_STAFF_EXT primary key (MANAGER_STAFF_ID);

prompt
prompt Creating table TB_HKLHC_BB
prompt ==========================
prompt
create table TB_HKLHC_BB
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_BB.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_BB.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_BB.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_BB.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_BB.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_BB.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_BB.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_BB.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_BB.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_BB.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_BB.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_BB.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_BB.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_BB.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_BB.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_BB.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_BB
  add constraint PK_TB_HKLHC_BB primary key (ID);

prompt
prompt Creating table TB_HKLHC_GG
prompt ==========================
prompt
create table TB_HKLHC_GG
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(60),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  ODDS2                  NUMBER(12,4),
  SELECT_ODDS            VARCHAR2(120),
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_GG.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_GG.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_GG.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_GG.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_GG.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_GG.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_GG.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_GG.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_GG.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_GG.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_GG.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_GG.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_GG.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_GG.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_GG.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_GG.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_GG.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_HKLHC_GG.ODDS2
  is '����Ͷע�ǲ��������';
comment on column TB_HKLHC_GG.SELECT_ODDS
  is '��¼�û���ע����������� ';
alter table TB_HKLHC_GG
  add constraint PK_TB_HKLHC_GG primary key (ID);

prompt
prompt Creating table TB_HKLHC_HIS
prompt ===========================
prompt
create table TB_HKLHC_HIS
(
  ID                     NUMBER(10) not null,
  CREATE_DATE            DATE default sysdate,
  ORIGIN_TB_NAME         VARCHAR2(100),
  ORIGIN_ID              NUMBER(10),
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(60),
  SPLIT_ATTRIBUTE        VARCHAR2(25),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  ODDS2                  NUMBER(12,4),
  UPDATE_DATE            DATE,
  COMMISSION_TYPE        VARCHAR2(20),
  REMARK                 NVARCHAR2(200),
  SELECT_ODDS            VARCHAR2(120)
)
;
comment on table TB_HKLHC_HIS
  is 'Ͷע��ʷ���洢�������ݱ��е���ʷ���ݣ�
1��Ͷע��������ϲ����룩��TB_HKLHC_TE_MA��
2��Ͷע��������ϲ����룩��TB_HKLHC_Z_MA��
3��Ͷע��������ϲ������룩��TB_HKLHC_Z_TE_MA��
4��Ͷע��������ϲ�����һ��������TB_HKLHC_ZM16��
5��Ͷע��������ϲ�������Ф����TB_HKLHC_TM_SX��
6��Ͷע��������ϲ���Фβ������TB_HKLHC_SX_WS��
7��Ͷע��������ϲʰ벨����TB_HKLHC_BB��
8��Ͷע��������ϲ���Ф������TB_HKLHC_SXL��
9��Ͷע��������ϲ�β��������TB_HKLHC_WSL��
10��Ͷע��������ϲ����룩��TB_HKLHC_LM��
11��Ͷע��������ϲʹ��أ���TB_HKLHC_GG��
12��Ͷע��������ϲ���Ф����TB_HKLHC_LX��
13��Ͷע��������ϲ��岻�У���TB_HKLHC_WBZ��';
comment on column TB_HKLHC_HIS.ORIGIN_TB_NAME
  is '����ʷ��������Ӧ��ԭʼ�洢���ݱ�����';
comment on column TB_HKLHC_HIS.ORIGIN_ID
  is '����ʷ��������Ӧ��ԭʼ�洢����ID';
comment on column TB_HKLHC_HIS.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_HIS.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_HIS.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_HIS.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_HIS.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_HIS.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_HIS.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_HIS.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_HIS.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_HIS.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_HIS.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_HIS.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_HIS.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_HIS.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_HIS.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_HIS.WIN_AMOUNT
  is '��λԪ';
comment on column TB_HKLHC_HIS.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_HKLHC_HIS.ODDS2
  is '����2��ֻ�е�Ͷע����Ϊ����ʱ����Ч';
comment on column TB_HKLHC_HIS.SELECT_ODDS
  is '��¼�û���ע����������� ';
alter table TB_HKLHC_HIS
  add constraint PK_TB_HKLHC_HIS primary key (ID);

prompt
prompt Creating table TB_HKLHC_LM
prompt ==========================
prompt
create table TB_HKLHC_LM
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(50),
  SPLIT_ATTRIBUTE        VARCHAR2(25),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  ODDS2                  NUMBER(12,4),
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_LM.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_LM.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_LM.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_LM.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_LM.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_LM.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_LM.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LM.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LM.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LM.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LM.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_LM.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_LM.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_LM.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_LM.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_LM.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_LM.ODDS
  is '��ǰͶע������Ӧ�����ʣ���Ҫ���������ʣ�';
comment on column TB_HKLHC_LM.ODDS2
  is '����2��ֻ�е�Ͷע����Ϊ����ʱ����Ч';
alter table TB_HKLHC_LM
  add constraint PK_TB_HKLHC_LM primary key (ID);

prompt
prompt Creating table TB_HKLHC_LX
prompt ==========================
prompt
create table TB_HKLHC_LX
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(50),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_LX.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_LX.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_LX.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_LX.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_LX.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_LX.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_LX.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LX.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LX.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LX.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_LX.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_LX.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_LX.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_LX.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_LX.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_LX.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_LX.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_LX
  add constraint PK_TB_HKLHC_LX primary key (ID);

prompt
prompt Creating table TB_HKLHC_PERIODS_INFO
prompt ====================================
prompt
create table TB_HKLHC_PERIODS_INFO
(
  ID                NUMBER(10) not null,
  PERIODS_NUM       VARCHAR2(11) not null,
  OPEN_QUOT_TIME    DATE,
  LOTTERY_TIME      DATE not null,
  STOP_QUOT_TIME    DATE not null,
  AUTO_STOP_QUOT    INTEGER,
  LOTTERY_TIME_INFO VARCHAR2(5),
  PERIODS_INFO      VARCHAR2(3),
  RESULT1           INTEGER,
  RESULT2           INTEGER,
  RESULT3           INTEGER,
  RESULT4           INTEGER,
  RESULT5           INTEGER,
  RESULT6           INTEGER,
  RESULT7           INTEGER,
  STATE             CHAR(1) default '1' not null,
  CREATE_USER       NUMBER(10),
  CREATE_TIME       DATE default sysdate not null
)
;
comment on column TB_HKLHC_PERIODS_INFO.PERIODS_NUM
  is 'Ͷע���������� 20120203001������Ψһ�ԣ���Ź���Ϊ������+�淨�����������';
comment on column TB_HKLHC_PERIODS_INFO.RESULT1
  is '��������Ӧ�Ŀ�������еĵ�һ����ֵ';
comment on column TB_HKLHC_PERIODS_INFO.RESULT2
  is '��������Ӧ�Ŀ�������еĵڶ�����ֵ';
comment on column TB_HKLHC_PERIODS_INFO.STATE
  is '����״̬��ȡֵ���£�0 �� �ѽ��ã�1 �� δ���̣�2 �� �ѿ��̣�3 �� �ѷ��̣�4 �� �ѿ�����Ĭ��ֵΪ 1 �� δ����';
comment on column TB_HKLHC_PERIODS_INFO.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_HKLHC_PERIODS_INFO
  add constraint PK_TB_HKLHC_PERIODS_INFO primary key (ID);

prompt
prompt Creating table TB_HKLHC_STRAIGHTTHROUGH
prompt =======================================
prompt
create table TB_HKLHC_STRAIGHTTHROUGH
(
  ID               NUMBER(10) not null,
  ORDER_NO         VARCHAR2(8),
  TYPE_CODE        VARCHAR2(100) not null,
  MONEY            NUMBER not null,
  BETTING_USER_ID  NUMBER(10) not null,
  CHIEFSTAFF       NUMBER(10),
  BRANCHSTAFF      NUMBER(10),
  STOCKHOLDERSTAFF NUMBER(10),
  GENAGENSTAFF     NUMBER(10),
  AGENTSTAFF       NUMBER(10),
  ATTRIBUTE        VARCHAR2(50),
  PERIODS_NUM      VARCHAR2(11) not null,
  PLATE            CHAR(1),
  BETTING_DATE     DATE default sysdate not null,
  WIN_STATE        CHAR(1) default '0' not null,
  ODDS             VARCHAR2(30) not null,
  UPDATE_DATE      DATE,
  REMARK           NVARCHAR2(200),
  COMMISSION       VARCHAR2(20),
  RATE             VARCHAR2(20)
)
;
comment on column TB_HKLHC_STRAIGHTTHROUGH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_STRAIGHTTHROUGH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_STRAIGHTTHROUGH.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_STRAIGHTTHROUGH.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_STRAIGHTTHROUGH.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_STRAIGHTTHROUGH.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_STRAIGHTTHROUGH.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_STRAIGHTTHROUGH.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_STRAIGHTTHROUGH.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_STRAIGHTTHROUGH.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_STRAIGHTTHROUGH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_STRAIGHTTHROUGH.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_STRAIGHTTHROUGH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_STRAIGHTTHROUGH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_STRAIGHTTHROUGH.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_STRAIGHTTHROUGH
  add constraint PK_TB_HKLHC_STRAIGHTTHROUGH primary key (ID);

prompt
prompt Creating table TB_HKLHC_SXL
prompt ===========================
prompt
create table TB_HKLHC_SXL
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(50),
  SPLIT_ATTRIBUTE        VARCHAR2(25),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  SELECT_ODDS            VARCHAR2(120),
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_SXL.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_SXL.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_SXL.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_SXL.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_SXL.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_SXL.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_SXL.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SXL.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SXL.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SXL.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SXL.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_SXL.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_SXL.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_SXL.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_SXL.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_SXL.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_SXL.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_HKLHC_SXL.SELECT_ODDS
  is '��¼�û���ע����������� ';
alter table TB_HKLHC_SXL
  add constraint PK_TB_HKLHC_SXL primary key (ID);

prompt
prompt Creating table TB_HKLHC_SX_WS
prompt =============================
prompt
create table TB_HKLHC_SX_WS
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_SX_WS.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_SX_WS.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_SX_WS.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_SX_WS.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_SX_WS.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_SX_WS.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_SX_WS.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SX_WS.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SX_WS.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SX_WS.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_SX_WS.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_SX_WS.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_SX_WS.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_SX_WS.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_SX_WS.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_SX_WS.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_SX_WS
  add constraint PK_TB_HKLHC_SX_WS primary key (ID);

prompt
prompt Creating table TB_HKLHC_TE_MA
prompt =============================
prompt
create table TB_HKLHC_TE_MA
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_TE_MA.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_TE_MA.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_TE_MA.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_TE_MA.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_TE_MA.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_TE_MA.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_TE_MA.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TE_MA.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TE_MA.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TE_MA.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TE_MA.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_TE_MA.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_TE_MA.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_TE_MA.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_TE_MA.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_TE_MA.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_TE_MA
  add constraint PK_TB_HKLHC_TE_MA primary key (ID);

prompt
prompt Creating table TB_HKLHC_TM_SX
prompt =============================
prompt
create table TB_HKLHC_TM_SX
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_TM_SX.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_TM_SX.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_TM_SX.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_TM_SX.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_TM_SX.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_TM_SX.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_TM_SX.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TM_SX.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TM_SX.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TM_SX.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_TM_SX.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_TM_SX.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_TM_SX.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_TM_SX.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_TM_SX.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_TM_SX.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_TM_SX
  add constraint PK_TB_HKLHC_TM_SX primary key (ID);

prompt
prompt Creating table TB_HKLHC_WBZ
prompt ===========================
prompt
create table TB_HKLHC_WBZ
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(50),
  SPLIT_ATTRIBUTE        VARCHAR2(25),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  SELECT_ODDS            VARCHAR2(120),
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_WBZ.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_WBZ.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_WBZ.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_WBZ.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_WBZ.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_WBZ.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_WBZ.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WBZ.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WBZ.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WBZ.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WBZ.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_WBZ.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_WBZ.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_WBZ.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_WBZ.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_WBZ.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_WBZ.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_HKLHC_WBZ.SELECT_ODDS
  is '��¼�û���ע����������� ';
alter table TB_HKLHC_WBZ
  add constraint PK_TB_HKLHC_WBZ primary key (ID);

prompt
prompt Creating table TB_HKLHC_WSL
prompt ===========================
prompt
create table TB_HKLHC_WSL
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ATTRIBUTE              VARCHAR2(50),
  SPLIT_ATTRIBUTE        VARCHAR2(25),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200),
  SELECT_ODDS            VARCHAR2(120)
)
;
comment on column TB_HKLHC_WSL.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_WSL.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_WSL.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_WSL.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_WSL.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_WSL.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_WSL.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WSL.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WSL.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WSL.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_WSL.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_HKLHC_WSL.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_WSL.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_WSL.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_WSL.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_WSL.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_WSL.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_HKLHC_WSL.SELECT_ODDS
  is '��¼�û���ע����������� ';
alter table TB_HKLHC_WSL
  add constraint PK_TB_HKLHC_WSL primary key (ID);

prompt
prompt Creating table TB_HKLHC_ZM16
prompt ============================
prompt
create table TB_HKLHC_ZM16
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_ZM16.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_ZM16.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_ZM16.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_ZM16.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_ZM16.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_ZM16.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_ZM16.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_ZM16.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_ZM16.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_ZM16.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_ZM16.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_ZM16.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_ZM16.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_ZM16.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_ZM16.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_ZM16.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_ZM16
  add constraint PK_TB_HKLHC_ZM16 primary key (ID);

prompt
prompt Creating table TB_HKLHC_Z_MA
prompt ============================
prompt
create table TB_HKLHC_Z_MA
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_Z_MA.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_Z_MA.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_Z_MA.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_Z_MA.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_Z_MA.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_Z_MA.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_Z_MA.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_MA.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_MA.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_MA.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_MA.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_Z_MA.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_Z_MA.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_Z_MA.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_Z_MA.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_Z_MA.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_Z_MA
  add constraint PK_TB_HKLHC_Z_MA primary key (ID);

prompt
prompt Creating table TB_HKLHC_Z_TE_MA
prompt ===============================
prompt
create table TB_HKLHC_Z_TE_MA
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  COMPOUND_NUM           NUMBER,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200)
)
;
comment on column TB_HKLHC_Z_TE_MA.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_HKLHC_Z_TE_MA.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_HKLHC_Z_TE_MA.MONEY
  is 'Ͷע����λ��';
comment on column TB_HKLHC_Z_TE_MA.COMPOUND_NUM
  is '��ʽ������ֻ���ڸ�ʽͶעʱ����Ч';
comment on column TB_HKLHC_Z_TE_MA.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_HKLHC_Z_TE_MA.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_HKLHC_Z_TE_MA.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_TE_MA.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_TE_MA.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_TE_MA.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_HKLHC_Z_TE_MA.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_HKLHC_Z_TE_MA.PLATE
  is 'A��B��C������';
comment on column TB_HKLHC_Z_TE_MA.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_HKLHC_Z_TE_MA.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_HKLHC_Z_TE_MA.WIN_AMOUNT
  is '��λ��';
comment on column TB_HKLHC_Z_TE_MA.ODDS
  is '��ǰͶע������Ӧ������';
alter table TB_HKLHC_Z_TE_MA
  add constraint PK_TB_HKLHC_Z_TE_MA primary key (ID);

prompt
prompt Creating table TB_JSSB
prompt ======================
prompt
create table TB_JSSB
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200),
  PLUS_ODDS              NUMBER(2) default 1
)
;
comment on table TB_JSSB
  is '����������Ӧ��Ͷע����¼��ԱͶע��Ϣ����';
comment on column TB_JSSB.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_JSSB.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_JSSB.MONEY
  is 'Ͷע����λ��';
comment on column TB_JSSB.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_JSSB.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_JSSB.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ����û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB.PERIODS_NUM
  is 'Ͷע���������� 201305200001����Ӧ��������Ϣ��������������TB_JSSB_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_JSSB.PLATE
  is 'A��B��C������';
comment on column TB_JSSB.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_JSSB.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_JSSB.WIN_AMOUNT
  is '��λ��';
comment on column TB_JSSB.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_JSSB.PLUS_ODDS
  is '���������������ʣ���Ҫ���������淨';
alter table TB_JSSB
  add constraint PK_TB_JSSB primary key (ID);

prompt
prompt Creating table TB_JSSB_HIS
prompt ==========================
prompt
create table TB_JSSB_HIS
(
  ID                     NUMBER(10) not null,
  CREATE_DATE            DATE default sysdate,
  ORIGIN_TB_NAME         VARCHAR2(100),
  ORIGIN_ID              NUMBER(10),
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  BETTING_USER_ID        NUMBER(10) not null,
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION_TYPE        VARCHAR2(20),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200),
  PLUS_ODDS              NUMBER(2) default 1
)
;
comment on table TB_JSSB_HIS
  is 'Ͷע��ʷ���洢�������ݱ��е���ʷ���ݣ�';
comment on column TB_JSSB_HIS.ORIGIN_TB_NAME
  is '����ʷ��������Ӧ��ԭʼ�洢���ݱ�����';
comment on column TB_JSSB_HIS.ORIGIN_ID
  is '����ʷ��������Ӧ��ԭʼ�洢����ID';
comment on column TB_JSSB_HIS.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_JSSB_HIS.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_JSSB_HIS.MONEY
  is 'Ͷע����λ��';
comment on column TB_JSSB_HIS.BETTING_USER_ID
  is 'Ͷע��ԱID����Ӧ����Ա��TB_FRAME_STAFF��������';
comment on column TB_JSSB_HIS.CHIEFSTAFF
  is '��Ա�û����������Ӧ���ܼ�';
comment on column TB_JSSB_HIS.BRANCHSTAFF
  is '��Ա�û����������Ӧ�ķֹ�˾��������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB_HIS.STOCKHOLDERSTAFF
  is '��Ա�û����������Ӧ�Ĺɶ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB_HIS.GENAGENSTAFF
  is '��Ա�û����������Ӧ���ܴ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB_HIS.AGENTSTAFF
  is '��Ա�û����������Ӧ�Ĵ���������ϼ��û�����Ӧ��ֱ����Ա����Ϊ��';
comment on column TB_JSSB_HIS.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ ��Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_JSSB_HIS.PLATE
  is 'A��B��C������';
comment on column TB_JSSB_HIS.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_JSSB_HIS.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��� Ĭ��ֵ 0 �� δ����';
comment on column TB_JSSB_HIS.WIN_AMOUNT
  is '��λԪ';
comment on column TB_JSSB_HIS.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_JSSB_HIS.PLUS_ODDS
  is '���������������ʣ���Ҫ���������淨';
alter table TB_JSSB_HIS
  add constraint PK_TB_JSSB_HIS primary key (ID);
create index INDEX_JS_HIS_BETTING_DATE_USER on TB_JSSB_HIS (BETTING_USER_ID, BETTING_DATE);
create index INDEX_JS_HIS_BETTING_USER on TB_JSSB_HIS (BETTING_USER_ID);

prompt
prompt Creating table TB_JSSB_PERIODS_INFO
prompt ===================================
prompt
create table TB_JSSB_PERIODS_INFO
(
  ID             NUMBER(10) not null,
  PERIODS_NUM    VARCHAR2(11) not null,
  OPEN_QUOT_TIME DATE not null,
  LOTTERY_TIME   DATE not null,
  STOP_QUOT_TIME DATE not null,
  RESULT1        INTEGER,
  RESULT2        INTEGER,
  RESULT3        INTEGER,
  STATE          CHAR(1) default '1' not null,
  CREATE_USER    NUMBER(10),
  CREATE_TIME    DATE default sysdate not null
)
;
comment on table TB_JSSB_PERIODS_INFO
  is '�����������ڱ�';
comment on column TB_JSSB_PERIODS_INFO.PERIODS_NUM
  is 'Ͷע���������� 201305200001������Ψһ�ԣ���Ź���Ϊ������+�淨�����������';
comment on column TB_JSSB_PERIODS_INFO.RESULT1
  is '��������Ӧ�Ŀ�������еĵ�һ����ֵ';
comment on column TB_JSSB_PERIODS_INFO.RESULT2
  is '��������Ӧ�Ŀ�������еĵڶ�����ֵ';
comment on column TB_JSSB_PERIODS_INFO.RESULT3
  is '��������Ӧ�Ŀ�������еĵ�������ֵ';
comment on column TB_JSSB_PERIODS_INFO.STATE
  is '����״̬��ȡֵ���£�0 �� �ѽ��ã�1 �� δ���̣�2 �� �ѿ��̣�3 �� �ѷ��̣�4 �� �ѿ�����Ĭ��ֵΪ 1 �� δ����';
comment on column TB_JSSB_PERIODS_INFO.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_JSSB_PERIODS_INFO
  add constraint PK_TB_JSSB_PERIODS_INFO primary key (ID);

prompt
prompt Creating table TB_LOGIN_LOG_INFO
prompt ================================
prompt
create table TB_LOGIN_LOG_INFO
(
  ID                    NUMBER(10) not null,
  USER_ID               NUMBER(10),
  ACCOUNT               NVARCHAR2(50) not null,
  USER_TYPE             CHAR(1) not null,
  SHOPS_CODE            VARCHAR2(10),
  LOGIN_DATE            DATE,
  LOGIN_IP              VARCHAR2(15),
  SESSION_ID            VARCHAR2(50),
  LOGOUT_DATE           DATE,
  LOGIN_STATE           CHAR(1),
  SUB_LOGIN_STATE       CHAR(1),
  INFO                  NVARCHAR2(500),
  CHIEF_STAFF_ID        NUMBER(10),
  BRANCH_STAFF_ID       NUMBER(10),
  STOCKHOLDER_STAFF_ID  NUMBER(10),
  GEN_AGENT_STAFF_ID    NUMBER(10),
  AGENT_STAFF_ID        NUMBER(10),
  CHIEF_STAFF_ACC       NVARCHAR2(50),
  AGENT_STAFF_ACC       NVARCHAR2(50),
  GEN_AGENT_STAFF_ACC   NVARCHAR2(50),
  STOCKHOLDER_STAFF_ACC NVARCHAR2(50),
  BRANCH_STAFF_ACC      NVARCHAR2(50),
  REMARK                NVARCHAR2(200)
)
;
comment on table TB_LOGIN_LOG_INFO
  is '��½��־��Ϣ��';
comment on column TB_LOGIN_LOG_INFO.USER_TYPE
  is '0 �� ϵͳ����Ա��1 �� �ܹ��û���2 �� �ܼ��û���3 �� �ֹ�˾�û���4 �� �ɶ��û���5 �� �ܴ����û���6 �� �����û���7 �� ���˺ţ�9 �� ��Ա�û�';
comment on column TB_LOGIN_LOG_INFO.LOGIN_DATE
  is '��¼ʱ��';
comment on column TB_LOGIN_LOG_INFO.LOGIN_IP
  is '��¼IP';
comment on column TB_LOGIN_LOG_INFO.LOGOUT_DATE
  is '�ǳ�ʱ��';
comment on column TB_LOGIN_LOG_INFO.LOGIN_STATE
  is '0 �� ��½�ɹ���1 �� ��½ʧ��';
comment on column TB_LOGIN_LOG_INFO.SUB_LOGIN_STATE
  is '��½��״̬���ݲ�ʹ��';
comment on column TB_LOGIN_LOG_INFO.CHIEF_STAFF_ID
  is '����Ӧ���ܼ�ID';
comment on column TB_LOGIN_LOG_INFO.BRANCH_STAFF_ID
  is '����Ӧ�ķֹ�˾ID';
comment on column TB_LOGIN_LOG_INFO.STOCKHOLDER_STAFF_ID
  is '����Ӧ�Ĺɶ�ID';
comment on column TB_LOGIN_LOG_INFO.GEN_AGENT_STAFF_ID
  is '����Ӧ���ܴ���ID';
comment on column TB_LOGIN_LOG_INFO.AGENT_STAFF_ID
  is '����Ӧ�Ĵ���ID';
comment on column TB_LOGIN_LOG_INFO.CHIEF_STAFF_ACC
  is '����Ӧ���ܼ��˺�';
comment on column TB_LOGIN_LOG_INFO.AGENT_STAFF_ACC
  is '����Ӧ�Ĵ����˺�';
comment on column TB_LOGIN_LOG_INFO.GEN_AGENT_STAFF_ACC
  is '����Ӧ���ܴ����˺�';
comment on column TB_LOGIN_LOG_INFO.STOCKHOLDER_STAFF_ACC
  is '����Ӧ�Ĺɶ��˺�';
comment on column TB_LOGIN_LOG_INFO.BRANCH_STAFF_ACC
  is '����Ӧ�ķֹ�˾�˺�';
alter table TB_LOGIN_LOG_INFO
  add constraint PK_TB_LOGIN_LOG_INFO primary key (ID);

prompt
prompt Creating table TB_LOTTERY_STATUS
prompt ================================
prompt
create table TB_LOTTERY_STATUS
(
  ID          NUMBER(10) not null,
  PLAY_TYPE   VARCHAR2(10) not null,
  STATE       CHAR(1) default '0' not null,
  MODIFY_DATE DATE default sysdate
)
;
comment on table TB_LOTTERY_STATUS
  is '����״̬�����Կ��Ż�ر�ĳ������';

prompt
prompt Creating table TB_MANAGER_STAFF_EXT
prompt ===================================
prompt
create table TB_MANAGER_STAFF_EXT
(
  MANAGER_STAFF_ID NUMBER(10) not null
)
;
comment on table TB_MANAGER_STAFF_EXT
  is '��¼�ܹ��û���չ��Ϣ';
comment on column TB_MANAGER_STAFF_EXT.MANAGER_STAFF_ID
  is '�ܹ��û�������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
alter table TB_MANAGER_STAFF_EXT
  add constraint PK_TB_MANAGER_STAFF_EXT primary key (MANAGER_STAFF_ID);

prompt
prompt Creating table TB_MEMBER_STAFF_EXT
prompt ==================================
prompt
create table TB_MEMBER_STAFF_EXT
(
  MEMBER_STAFF_ID       NUMBER(10) not null,
  PARENT_STAFF          NUMBER(10),
  PARENT_USER_TYPE      CHAR(1),
  PLATE                 CHAR(1),
  TOTAL_CREDIT_LINE     NUMBER(10),
  AVAILABLE_CREDIT_LINE NUMBER(10),
  RATE                  NUMBER(5,2),
  BACK_WATER            NUMBER(5,2),
  CHIEF_STAFF           NUMBER(10),
  BRANCH_STAFF          NUMBER(10),
  STOCKHOLDER_STAFF     NUMBER(10),
  GEN_AGENT_STAFF       NUMBER(10),
  AGENT_STAFF           NUMBER(10)
)
;
comment on table TB_MEMBER_STAFF_EXT
  is '�˱��м�¼��Ա�û���չ��Ϣ����Ա�û�������TB_FRAME_MEMBER_STAFF���д洢�˻�Ա�û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
-----------------
�����û��ڻ�Ա�û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��0 �� ��ͨ��Ա�û���';
comment on column TB_MEMBER_STAFF_EXT.MEMBER_STAFF_ID
  is '��ͨ��Ա�û�������Ϣ������Ӧ�ļ�¼ID����Ӧ��Ա�û�������TB_FRAME_MEMBER_STAFF����ID';
comment on column TB_MEMBER_STAFF_EXT.PARENT_STAFF
  is '�ϼ��û�';
comment on column TB_MEMBER_STAFF_EXT.CHIEF_STAFF
  is '��Ա����Ӧ���ܼ�ID';
comment on column TB_MEMBER_STAFF_EXT.BRANCH_STAFF
  is '��Ա����Ӧ�ķֹ�˾ID';
comment on column TB_MEMBER_STAFF_EXT.STOCKHOLDER_STAFF
  is '��Ա����Ӧ�Ĺɶ�ID';
comment on column TB_MEMBER_STAFF_EXT.GEN_AGENT_STAFF
  is '��Ա����Ӧ���ܴ���ID';
comment on column TB_MEMBER_STAFF_EXT.AGENT_STAFF
  is '��Ա����Ӧ�Ĵ���ID';
alter table TB_MEMBER_STAFF_EXT
  add constraint PK_TB_MEMBER_STAFF_EXT primary key (MEMBER_STAFF_ID);

prompt
prompt Creating table TB_OPEN_PLAY_ODDS
prompt ================================
prompt
create table TB_OPEN_PLAY_ODDS
(
  ID                  NUMBER(10) not null,
  SHOPS_CODE          CHAR(4) not null,
  AUTO_ODDS_QUOTAS    NUMBER not null,
  AUTO_ODDS           NUMBER(12,4),
  ODDS_TYPE           VARCHAR2(30) not null,
  LOWEST_ODDS         NUMBER(12,4),
  OPENING_ODDS        NUMBER(12,4),
  BIGEST_ODDS         NUMBER(12,4),
  CUT_ODDS_B          NUMBER(12,4),
  CUT_ODDS_C          NUMBER(12,4),
  OPENING_UPDATE_DATE DATE,
  OPENING_UPDATE_USER NUMBER(10),
  CREATE_USER         NUMBER(10) not null,
  CREATE_TIME         DATE default sysdate not null,
  REMARK              NVARCHAR2(200)
)
;
comment on table TB_OPEN_PLAY_ODDS
  is '��������������Ϣ';
comment on column TB_OPEN_PLAY_ODDS.ODDS_TYPE
  is '���������ͣ��ܺʹ󣬴�С �ȣ�';
comment on column TB_OPEN_PLAY_ODDS.OPENING_ODDS
  is '��������ֵ';
comment on column TB_OPEN_PLAY_ODDS.OPENING_UPDATE_USER
  is '�������ʸ�����ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF���е�����';
comment on column TB_OPEN_PLAY_ODDS.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_OPEN_PLAY_ODDS
  add constraint PK_TB_OPEN_PLAY_ODDS primary key (ID);

prompt
prompt Creating table TB_OUT_REPLENISH_STAFF_EXT
prompt =========================================
prompt
create table TB_OUT_REPLENISH_STAFF_EXT
(
  PARENT_STAFF     NUMBER(10),
  MANAGER_STAFF_ID NUMBER(10) not null,
  PLATE            CHAR(1)
)
;
comment on table TB_OUT_REPLENISH_STAFF_EXT
  is '�˱��м�¼������Ա��չ��Ϣ�������û�������TB_FRAME_MANAGER_STAFF���д洢�˴����û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
7������¼IP
-----------------
������Ա�ڹ����û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��8 �� ������Ա��';
comment on column TB_OUT_REPLENISH_STAFF_EXT.PARENT_STAFF
  is '�ϼ��û�';
comment on column TB_OUT_REPLENISH_STAFF_EXT.MANAGER_STAFF_ID
  is '������Ա������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
comment on column TB_OUT_REPLENISH_STAFF_EXT.PLATE
  is '�̿�';
alter table TB_OUT_REPLENISH_STAFF_EXT
  add constraint PK_TB_OUT_REPLENISH_STAFF_EXT primary key (MANAGER_STAFF_ID);

prompt
prompt Creating table TB_PERIODS_AUTO_ODDS
prompt ===================================
prompt
create table TB_PERIODS_AUTO_ODDS
(
  ID          NUMBER(10) not null,
  SHOPS_CODE  CHAR(4) not null,
  TYPE        VARCHAR2(30),
  NAME        VARCHAR2(30),
  AUTO_ODDS   NUMBER(12,4),
  CREATE_USER NUMBER(10) not null,
  CREATE_TIME DATE default sysdate not null
)
;
comment on table TB_PERIODS_AUTO_ODDS
  is '�˱�洢����δ�����������Զ�������������Ϣ';
comment on column TB_PERIODS_AUTO_ODDS.NAME
  is '�������õ�����';
comment on column TB_PERIODS_AUTO_ODDS.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_PERIODS_AUTO_ODDS
  add constraint PK_TB_PERIODS_AUTO_ODDS primary key (ID);

prompt
prompt Creating table TB_PLAYODDS_LOG
prompt ==============================
prompt
create table TB_PLAYODDS_LOG
(
  LOGID           NUMBER(10) not null,
  CREATE_USERID   NUMBER(10) not null,
  CREATE_DATE     DATE not null,
  PLAY_TYPE_CODE  VARCHAR2(50) not null,
  REALODDS_BEFORE NUMBER(12,4) not null,
  REALODDS_AFTER  NUMBER(12,4) not null,
  SHOPS_CODE      CHAR(4) not null,
  REMARK          VARCHAR2(500)
)
;
comment on table TB_PLAYODDS_LOG
  is '������־';
alter table TB_PLAYODDS_LOG
  add constraint PK_TB_PLAYODDS_LOG primary key (LOGID);

prompt
prompt Creating table TB_PLAY_AMOUNT
prompt =============================
prompt
create table TB_PLAY_AMOUNT
(
  ID              NUMBER(10) not null,
  TYPE_CODE       VARCHAR2(30) not null,
  PLAY_TYPE       VARCHAR2(10) not null,
  PERIODS_NUM     VARCHAR2(11),
  COMMISSION_TYPE VARCHAR2(15),
  SHOPS_CODE      CHAR(4),
  MONEY_AMOUNT    NUMBER not null,
  UPDATE_TIME     DATE
)
;
comment on table TB_PLAY_AMOUNT
  is '��¼��ӦͶע���͵�Ͷע�ܶ�';
comment on column TB_PLAY_AMOUNT.TYPE_CODE
  is 'Ͷע�ܶ�����Ӧ��Ͷע���ͱ��룬��Ӧ��Ͷע���ͱ�TB_PLAY_TYPE���е����ͱ���';
comment on column TB_PLAY_AMOUNT.PLAY_TYPE
  is '�淨��ʱʱ�ʣ�ʮ���ӣ����ϲʣ�';
comment on column TB_PLAY_AMOUNT.PERIODS_NUM
  is '��Ӧ���ڱ�������ֶΣ�PERIODS_NUM��';
comment on column TB_PLAY_AMOUNT.MONEY_AMOUNT
  is 'Ͷע����λ��';
alter table TB_PLAY_AMOUNT
  add constraint PK_TB_PLAY_AMOUNT primary key (ID);

prompt
prompt Creating table TB_PLAY_TYPE
prompt ===========================
prompt
create table TB_PLAY_TYPE
(
  ID                            NUMBER(10) not null,
  TYPE_CODE                     VARCHAR2(30) not null,
  TYPE_NAME                     VARCHAR2(100) not null,
  PLAY_TYPE                     VARCHAR2(10) not null,
  PLAY_SUB_TYPE                 VARCHAR2(15),
  PLAY_FINAL_TYPE               VARCHAR2(10) not null,
  ODDS_TYPE                     VARCHAR2(30),
  STATE                         CHAR(1) default '0' not null,
  SUB_TYPE_NAME                 VARCHAR2(20),
  FINAL_TYPE_NAME               VARCHAR2(20),
  COMMISSION_TYPE               VARCHAR2(15),
  REMARK                        NVARCHAR2(200),
  AUTO_REPLENISH_TYPE           VARCHAR2(30),
  DISPLAY_ORDER                 NUMBER,
  COMMISSION_TYPE_DISPLAY_ORDER NUMBER
)
;
comment on table TB_PLAY_TYPE
  is 'Ͷע���ͱ���¼ϵͳ֧�ֵ�Ͷע���ͣ�Ͷע��������ʹ�ó�ʼ���ķ�ʽ����';
comment on column TB_PLAY_TYPE.ID
  is '��������';
comment on column TB_PLAY_TYPE.TYPE_CODE
  is 'Ͷע���͵����ƣ�����Ψһ�ԣ������������磺CQSSC_BALL_FIRST_XXX';
comment on column TB_PLAY_TYPE.TYPE_NAME
  is '���͵�����';
comment on column TB_PLAY_TYPE.PLAY_TYPE
  is '�淨��ʱʱ�ʣ�ʮ���ӣ����ϲʣ�';
comment on column TB_PLAY_TYPE.PLAY_SUB_TYPE
  is '���淨����һ�������̣����� ��';
comment on column TB_PLAY_TYPE.PLAY_FINAL_TYPE
  is '��ע���ͣ��ܺʹ󣬴�С �ȣ�';
comment on column TB_PLAY_TYPE.ODDS_TYPE
  is '���������ͣ���һ�� �ȣ�';
comment on column TB_PLAY_TYPE.STATE
  is '��Ͷע���͵�ǰ�Ƿ���Ч��0 �� ��Ч��1 �� ��Ч��2 �� ɾ����Ĭ��ֵ 0';
comment on column TB_PLAY_TYPE.FINAL_TYPE_NAME
  is '��ע��������';
comment on column TB_PLAY_TYPE.AUTO_REPLENISH_TYPE
  is '�Զ���������';
comment on column TB_PLAY_TYPE.DISPLAY_ORDER
  is 'ҳ����ʾ˳����';
alter table TB_PLAY_TYPE
  add constraint PK_TB_PLAY_TYPE primary key (ID);

prompt
prompt Creating table TB_PLAY_WIN_INFO
prompt ===============================
prompt
create table TB_PLAY_WIN_INFO
(
  ID          NUMBER(10) not null,
  TYPE_CODE   VARCHAR2(30) not null,
  PLAY_TYPE   VARCHAR2(10) not null,
  PERIODS_NUM VARCHAR2(11) not null,
  WIN         CHAR(1) not null,
  UPDATE_TIME DATE
)
;
comment on table TB_PLAY_WIN_INFO
  is '��¼Ͷע��������Ӧ���н�������ҽ�ʱ ������ʱ��¼Ͷע�������룬û�и�ʽ���н�״̬��ͨ���ñ��Ͷע������������ɨ�裩 �ӿ�ҽ��ٶ�';
comment on column TB_PLAY_WIN_INFO.TYPE_CODE
  is 'Ͷע�ܶ�����Ӧ��Ͷע���ͱ��룬��Ӧ��Ͷע���ͱ�TB_PLAY_TYPE���е����ͱ���';
comment on column TB_PLAY_WIN_INFO.PLAY_TYPE
  is '�淨��ʱʱ�ʣ�ʮ���ӣ����ϲʣ�';
comment on column TB_PLAY_WIN_INFO.PERIODS_NUM
  is '��Ӧ���ڱ�������ֶΣ�PERIODS_NUM��';
comment on column TB_PLAY_WIN_INFO.WIN
  is '�Ƿ��н���0 �� �н���1 �� δ�н�';
alter table TB_PLAY_WIN_INFO
  add constraint PK_TB_PLAY_WIN_INFO primary key (ID);

prompt
prompt Creating table TB_REPLENISH
prompt ===========================
prompt
create table TB_REPLENISH
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  ATTRIBUTE              VARCHAR2(50),
  REPLENISH_USER_ID      NUMBER(10) not null,
  REPLENISH_ACC_USER_ID  NUMBER(10),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION             NUMBER,
  RATE                   NUMBER(5,2),
  UPDATE_USER            NUMBER(10),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200),
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ODDS2                  NUMBER(12,4),
  COMMISSION_CHIEF       NUMBER,
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  COMMISSION_TYPE        VARCHAR2(20),
  SELECT_ODDS            VARCHAR2(120)
)
;
comment on column TB_REPLENISH.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_REPLENISH.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_REPLENISH.MONEY
  is 'Ͷע����λ��';
comment on column TB_REPLENISH.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_REPLENISH.REPLENISH_USER_ID
  is '������ID';
comment on column TB_REPLENISH.REPLENISH_ACC_USER_ID
  is '���ܲ����Ķ���һ���ǲ����˵���һ��';
comment on column TB_REPLENISH.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_REPLENISH.PLATE
  is 'A��B��C������';
comment on column TB_REPLENISH.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_REPLENISH.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_REPLENISH.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_REPLENISH.ODDS2
  is '����2��ֻ�е�Ͷע����Ϊ����ʱ����Ч';
comment on column TB_REPLENISH.SELECT_ODDS
  is '��¼ѡ����������(�����岻�к͹���)';
alter table TB_REPLENISH
  add constraint PK_TB_REPLENISH primary key (ID);

prompt
prompt Creating table TB_REPLENISH_AUTO
prompt ================================
prompt
create table TB_REPLENISH_AUTO
(
  ID               NUMBER(10) not null,
  SHOPS_ID         VARCHAR2(30) not null,
  TYPE             VARCHAR2(10) not null,
  MONEY_LIMIT      NUMBER(10) not null,
  CREATE_USER      NUMBER(10) not null,
  CREATE_TIME      DATE not null,
  TYPE_CODE        VARCHAR2(30) not null,
  MONEY_REP        NUMBER(10),
  STATE            CHAR(1),
  CREATE_USER_TYPE CHAR(1)
)
;
comment on column TB_REPLENISH_AUTO.TYPE
  is 'ȡֵΪ GDKLSF��HKLHC��CQSSC';
comment on column TB_REPLENISH_AUTO.STATE
  is 'ȡֵ��0 �� ���á�1 �� ����';
alter table TB_REPLENISH_AUTO
  add constraint PK_TB_REPLENISH_AUTO primary key (ID);

prompt
prompt Creating table TB_REPLENISH_AUTO_LOG
prompt ====================================
prompt
create table TB_REPLENISH_AUTO_LOG
(
  ID            NUMBER(10) not null,
  SHOP_ID       VARCHAR2(10) not null,
  PLAY_TYPE     VARCHAR2(10) not null,
  TYPE_CODE     VARCHAR2(30) not null,
  MONEY         NUMBER not null,
  CREATE_USERID VARCHAR2(10) not null,
  CREATE_DATE   DATE not null,
  PERIODS_NUM   VARCHAR2(11),
  TYPE          CHAR(1)
)
;
comment on column TB_REPLENISH_AUTO_LOG.PLAY_TYPE
  is 'ȡֵΪ��HKLHC��CQSSC��GDKLSF';
comment on column TB_REPLENISH_AUTO_LOG.TYPE
  is '1:�Զ�������־��2�ֶ�������־';
alter table TB_REPLENISH_AUTO_LOG
  add constraint PK_TB_REPLENISH_AUTO_LOG primary key (ID);

prompt
prompt Creating table TB_REPLENISH_AUTO_SET_LOG
prompt ========================================
prompt
create table TB_REPLENISH_AUTO_SET_LOG
(
  ID              NUMBER(10) not null,
  SHOP_ID         VARCHAR2(10) not null,
  TYPE            VARCHAR2(10) not null,
  TYPE_CODE       VARCHAR2(30) not null,
  MONEY_ORGIN     NUMBER not null,
  MONEY_NEW       NUMBER not null,
  CREATE_USERID   VARCHAR2(10) not null,
  CREATE_USERTYPE VARCHAR2(10) not null,
  CREATE_TIME     DATE not null,
  STATE_ORGIN     CHAR(1),
  STATE_NEW       CHAR(1),
  IP              VARCHAR2(20),
  CHANGE_TYPE     VARCHAR2(300),
  CHANGE_SUB_TYPE VARCHAR2(300),
  ORGINAL_VALUE   VARCHAR2(300),
  NEW_VALUE       VARCHAR2(300),
  UPDATE_USERTYPE VARCHAR2(10),
  UPDATE_USERID   VARCHAR2(10)
)
;
comment on column TB_REPLENISH_AUTO_SET_LOG.SHOP_ID
  is ' ����Id';
comment on column TB_REPLENISH_AUTO_SET_LOG.TYPE
  is '���� ��GDKLSF��BJ��CQSSC';
comment on column TB_REPLENISH_AUTO_SET_LOG.MONEY_ORGIN
  is '�޸�֮ǰ��money';
comment on column TB_REPLENISH_AUTO_SET_LOG.MONEY_NEW
  is '�޸�֮���money';
comment on column TB_REPLENISH_AUTO_SET_LOG.CREATE_TIME
  is '����ʱ��';
comment on column TB_REPLENISH_AUTO_SET_LOG.STATE_ORGIN
  is '�޸�֮ǰ�� ״̬����ѡ���Ƿ�ѡ��';
comment on column TB_REPLENISH_AUTO_SET_LOG.STATE_NEW
  is '�޸�֮��� ״̬����ѡ���Ƿ�ѡ��';

prompt
prompt Creating table TB_REPLENISH_HIS
prompt ===============================
prompt
create table TB_REPLENISH_HIS
(
  ID                     NUMBER(10) not null,
  ORDER_NO               VARCHAR2(8),
  TYPE_CODE              VARCHAR2(30) not null,
  MONEY                  NUMBER not null,
  ATTRIBUTE              VARCHAR2(50),
  REPLENISH_USER_ID      NUMBER(10) not null,
  REPLENISH_ACC_USER_ID  NUMBER(10),
  PERIODS_NUM            VARCHAR2(11) not null,
  PLATE                  CHAR(1),
  BETTING_DATE           DATE default sysdate not null,
  WIN_STATE              CHAR(1) default '0' not null,
  WIN_AMOUNT             NUMBER,
  ODDS                   NUMBER(12,4) not null,
  COMMISSION             NUMBER,
  RATE                   NUMBER(5,2),
  UPDATE_USER            NUMBER(10),
  UPDATE_DATE            DATE,
  REMARK                 NVARCHAR2(200),
  CHIEFSTAFF             NUMBER(10),
  BRANCHSTAFF            NUMBER(10),
  STOCKHOLDERSTAFF       NUMBER(10),
  GENAGENSTAFF           NUMBER(10),
  AGENTSTAFF             NUMBER(10),
  RATE_CHIEF             NUMBER(5,2),
  RATE_BRANCH            NUMBER(5,2),
  RATE_STOCKHOLDER       NUMBER(5,2),
  RATE_GEN_AGENT         NUMBER(5,2),
  RATE_AGENT             NUMBER(5,2),
  ODDS2                  NUMBER(12,4),
  COMMISSION_CHIEF       NUMBER,
  COMMISSION_BRANCH      NUMBER,
  COMMISSION_GEN_AGENT   NUMBER,
  COMMISSION_STOCKHOLDER NUMBER,
  COMMISSION_AGENT       NUMBER,
  COMMISSION_MEMBER      NUMBER,
  COMMISSION_TYPE        VARCHAR2(20),
  SELECT_ODDS            VARCHAR2(120)
)
;
comment on column TB_REPLENISH_HIS.ORDER_NO
  is '��ͬ�����������ظ�';
comment on column TB_REPLENISH_HIS.TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ���淨���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_REPLENISH_HIS.MONEY
  is 'Ͷע����λ��';
comment on column TB_REPLENISH_HIS.ATTRIBUTE
  is '��¼����Ͷעʱ��ѡ�������֮��ʹ�ð�ǵ�|�ָ�磬����Ͷעѡ����5���7����˴���¼������Ϊ 5|7';
comment on column TB_REPLENISH_HIS.REPLENISH_USER_ID
  is '������ID';
comment on column TB_REPLENISH_HIS.REPLENISH_ACC_USER_ID
  is '���ܲ����Ķ���һ���ǲ����˵���һ��';
comment on column TB_REPLENISH_HIS.PERIODS_NUM
  is 'Ͷע���������� 20120203001����Ӧ��������Ϣ���㶫����ʮ�֣���TB_GDKLSF_PERIODS_INFO���ġ�Ͷע������PERIODS_NUM�����ֶ�';
comment on column TB_REPLENISH_HIS.PLATE
  is 'A��B��C������';
comment on column TB_REPLENISH_HIS.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_REPLENISH_HIS.WIN_STATE
  is '�н�״̬��0 �� δ������1 �� �н���2 �� δ�н���3 �� �Ѷҽ���4 �� ע������ע������ʱ���ɣ���5 �� ���ϣ�������ͣ�����ɣ���9 �� ��ͣ�����ʱʱ�������͵ĺͼ�������ϲʵ�����;֣�Ĭ��ֵ 0 �� δ����';
comment on column TB_REPLENISH_HIS.ODDS
  is '��ǰͶע������Ӧ������';
comment on column TB_REPLENISH_HIS.ODDS2
  is '����2��ֻ�е�Ͷע����Ϊ����ʱ����Ч';
comment on column TB_REPLENISH_HIS.SELECT_ODDS
  is '��¼ѡ����������(�����岻�к͹���)';
alter table TB_REPLENISH_HIS
  add constraint PK_TB_REPLENISH_HIS primary key (ID);
create index INDEX_BH_HIS_BETTING_DATE on TB_REPLENISH_HIS (BETTING_DATE);
create index INDEX_BH_HIS_BETTING_DATE_USER on TB_REPLENISH_HIS (REPLENISH_USER_ID, BETTING_DATE);
create index INDEX_BH_HIS_BETTING_USER on TB_REPLENISH_HIS (REPLENISH_USER_ID);

prompt
prompt Creating table TB_REPORT_STATUS
prompt ===============================
prompt
create table TB_REPORT_STATUS
(
  ID     NUMBER(10) not null,
  OPT    CHAR(1) default 0 not null,
  STATUS CHAR(1) default 0 not null
)
;
comment on table TB_REPORT_STATUS
  is '����״̬��';
comment on column TB_REPORT_STATUS.ID
  is '����';
comment on column TB_REPORT_STATUS.OPT
  is '�����Ƿ�ʹ���·������㣬���ܹ������ã�0���ر� 1��������Ĭ��Ϊ�ر�';
comment on column TB_REPORT_STATUS.STATUS
  is '��������״̬��0��δ�ɹ� 1���ɹ���Ĭ��Ϊδ�ɹ�';
alter table TB_REPORT_STATUS
  add constraint PK_TB_REPORT_STATUS primary key (ID);

prompt
prompt Creating table TB_SETTLED_REPORT_PET_LIST
prompt =========================================
prompt
create table TB_SETTLED_REPORT_PET_LIST
(
  ID                           NUMBER(10) not null,
  BETTING_USER_ID              NUMBER(10),
  BETTING_USER_TYPE            CHAR(1),
  PARENT_USER_TYPE             CHAR(1),
  ACCOUNT                      NVARCHAR2(50),
  CHNAME                       NVARCHAR2(50),
  COUNT                        NUMBER(10),
  TOTAL_MONEY                  NUMBER,
  MONEY_RATE_AGENT             NUMBER,
  MONEY_RATE_GENAGENT          NUMBER,
  MONEY_RATE_STOCKHOLDER       NUMBER,
  MONEY_RATE_BRANCH            NUMBER,
  MONEY_RATE_CHIEF             NUMBER,
  RATE_MONEY                   NUMBER,
  MEMBER_AMOUNT                NUMBER,
  SUBORDINATE_AMOUNT_WIN       NUMBER,
  SUBORDINATE_AMOUNT_BACKWATER NUMBER,
  REALWIN                      NUMBER,
  REAL_BACKWATER               NUMBER,
  COMMISSION                   NUMBER,
  BETTING_DATE                 DATE,
  USER_ID                      NUMBER(10),
  USER_TYPE                    CHAR(1),
  REAL_RESULT_PER              NUMBER
)
;
comment on column TB_SETTLED_REPORT_PET_LIST.BETTING_USER_TYPE
  is '�û�����';
comment on column TB_SETTLED_REPORT_PET_LIST.PARENT_USER_TYPE
  is '�ϼ��û�����';
comment on column TB_SETTLED_REPORT_PET_LIST.ACCOUNT
  is '��½�˺�';
comment on column TB_SETTLED_REPORT_PET_LIST.CHNAME
  is '����';
comment on column TB_SETTLED_REPORT_PET_LIST.COUNT
  is '����';
comment on column TB_SETTLED_REPORT_PET_LIST.TOTAL_MONEY
  is '��Ч���~';
comment on column TB_SETTLED_REPORT_PET_LIST.MONEY_RATE_AGENT
  is '����ʵռ';
comment on column TB_SETTLED_REPORT_PET_LIST.MONEY_RATE_GENAGENT
  is '�ܴ���ʵռ';
comment on column TB_SETTLED_REPORT_PET_LIST.MONEY_RATE_STOCKHOLDER
  is '�ɶ�ʵռ';
comment on column TB_SETTLED_REPORT_PET_LIST.MONEY_RATE_BRANCH
  is '�ֹ�˾ʵռ';
comment on column TB_SETTLED_REPORT_PET_LIST.MONEY_RATE_CHIEF
  is '�ܼ�ʵռ';
comment on column TB_SETTLED_REPORT_PET_LIST.RATE_MONEY
  is '����ʵռ';
comment on column TB_SETTLED_REPORT_PET_LIST.MEMBER_AMOUNT
  is '��Աݔ�A';
comment on column TB_SETTLED_REPORT_PET_LIST.SUBORDINATE_AMOUNT_WIN
  is 'Ӧ������-ݔ�A';
comment on column TB_SETTLED_REPORT_PET_LIST.SUBORDINATE_AMOUNT_BACKWATER
  is 'Ӧ������-��ˮ';
comment on column TB_SETTLED_REPORT_PET_LIST.REALWIN
  is 'ʵռ��Ӯ';
comment on column TB_SETTLED_REPORT_PET_LIST.REAL_BACKWATER
  is 'ʵռ��ˮ';
comment on column TB_SETTLED_REPORT_PET_LIST.COMMISSION
  is '��ˮ';
comment on column TB_SETTLED_REPORT_PET_LIST.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_SETTLED_REPORT_PET_LIST.USER_ID
  is 'ͳ�ƶ�����û�ID';
comment on column TB_SETTLED_REPORT_PET_LIST.USER_TYPE
  is 'ͳ�ƶ�����û�����';
comment on column TB_SETTLED_REPORT_PET_LIST.REAL_RESULT_PER
  is 'ռ����';
alter table TB_SETTLED_REPORT_PET_LIST
  add constraint PK_TB_REPORT_HIS primary key (ID);

prompt
prompt Creating table TB_SETTLED_REPORT_R_LIST
prompt =======================================
prompt
create table TB_SETTLED_REPORT_R_LIST
(
  ID                NUMBER(10) not null,
  USER_TYPE         CHAR(1),
  COUNT             NUMBER(10),
  AMOUNT            NUMBER,
  MEMBER_AMOUNT     NUMBER,
  WIN_BACK_WATER    NUMBER,
  BACK_WATER_RESULT NUMBER,
  BETTING_DATE      DATE,
  USER_ID           NUMBER(10)
)
;
comment on column TB_SETTLED_REPORT_R_LIST.USER_TYPE
  is 'ͳ�Ƶ��û�����';
comment on column TB_SETTLED_REPORT_R_LIST.COUNT
  is '����';
comment on column TB_SETTLED_REPORT_R_LIST.AMOUNT
  is 'Ͷע�ܶ�';
comment on column TB_SETTLED_REPORT_R_LIST.MEMBER_AMOUNT
  is '��Աݔ�A';
comment on column TB_SETTLED_REPORT_R_LIST.WIN_BACK_WATER
  is '׬ȡ��ˮ';
comment on column TB_SETTLED_REPORT_R_LIST.BACK_WATER_RESULT
  is '��ˮ����';
comment on column TB_SETTLED_REPORT_R_LIST.BETTING_DATE
  is 'Ͷעʱ��';
comment on column TB_SETTLED_REPORT_R_LIST.USER_ID
  is 'ͳ�Ƶ��û�ID';
alter table TB_SETTLED_REPORT_R_LIST
  add constraint PK_TB_TB_SETTLED_REPORT_R_LIST primary key (ID);

prompt
prompt Creating table TB_SHOPS_DECLARATION
prompt ===================================
prompt
create table TB_SHOPS_DECLARATION
(
  ID                     NUMBER(10) not null,
  SHOPS_CODE             CHAR(4),
  MANAGER_MESSAGE_STATUS CHAR(1),
  POPUP_MENUS            CHAR(1),
  MEMBER_MESSAGE_STATUS  CHAR(1),
  CONTENT_INFO           NVARCHAR2(2000),
  START_DATE             DATE,
  END_DATE               DATE,
  TYPE                   CHAR(1) default '1',
  FONT_COLOR             CHAR(7),
  REMARK                 NVARCHAR2(200),
  CREATE_USER            NUMBER(10),
  CREATE_TIME            DATE
)
;
comment on table TB_SHOPS_DECLARATION
  is '���̹�����Ϣ';
comment on column TB_SHOPS_DECLARATION.START_DATE
  is '���濪ʼ��Чʱ��';
comment on column TB_SHOPS_DECLARATION.END_DATE
  is '�������ʱ��';
comment on column TB_SHOPS_DECLARATION.TYPE
  is '0 �� Ĭ�Ϲ��棨��������������Ч��Ϣʱʹ�ã���1 �� ��ͨ���棻Ĭ��ֵ 1';
comment on column TB_SHOPS_DECLARATION.FONT_COLOR
  is '�������ɫ���磺#FFFF00';
comment on column TB_SHOPS_DECLARATION.CREATE_USER
  is '������ԱID';
alter table TB_SHOPS_DECLARATION
  add constraint PK_TB_SHOPS_DECLARATION primary key (ID);

prompt
prompt Creating table TB_SHOPS_HKLHC_PERIODS
prompt =====================================
prompt
create table TB_SHOPS_HKLHC_PERIODS
(
  ID              NUMBER(10) not null,
  PERIODS_INFO_ID NUMBER(10) not null,
  SHOPS_CODE      CHAR(4) not null,
  PERIODS_STATE   CHAR(1) not null,
  MODIFY_USER     NUMBER(10),
  MODIFY_TIME     DATE default sysdate not null,
  STOP_QUOT_TIME  DATE,
  OPEN_QUOT_TIME  DATE,
  AUTO_STOP_QUOT  INTEGER
)
;
comment on table TB_SHOPS_HKLHC_PERIODS
  is '��¼�������̸�������Ӧ��������Ϣ��������ϲʣ�����';
comment on column TB_SHOPS_HKLHC_PERIODS.PERIODS_INFO_ID
  is '����ID����Ӧ������Ϣ��������ϲʣ���TB_HKLHC_PERIODS_INFO���е�ID';
comment on column TB_SHOPS_HKLHC_PERIODS.PERIODS_STATE
  is '0 �� ���̣�1 �� ����';
comment on column TB_SHOPS_HKLHC_PERIODS.MODIFY_USER
  is '�༭��ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
alter table TB_SHOPS_HKLHC_PERIODS
  add constraint PK_TB_SHOPS_HKLHC_PERIODS primary key (ID);

prompt
prompt Creating table TB_SHOPS_INFO
prompt ============================
prompt
create table TB_SHOPS_INFO
(
  ID                NUMBER(10) not null,
  SHOPS_CODE        VARCHAR2(10) not null,
  SHOPS_NAME        NVARCHAR2(10) not null,
  STATE             CHAR(1) default '0' not null,
  CREATE_USER       NUMBER(10) not null,
  CREATE_TIME       DATE default sysdate not null,
  CSS               CHAR(1) default '0' not null,
  REMARK            NVARCHAR2(200),
  ENABLE_BET_DELETE VARCHAR2(1) default 'N',
  ENABLE_BET_CANCEL VARCHAR2(1) default 'N'
)
;
comment on table TB_SHOPS_INFO
  is '������Ϣ�����������Ϣ';
comment on column TB_SHOPS_INFO.ID
  is '��������';
comment on column TB_SHOPS_INFO.STATE
  is '����״̬��0 �� ���ţ�1 �� ���᣻2 �� �رգ�Ĭ��Ϊ 0 �� ����';
comment on column TB_SHOPS_INFO.CREATE_USER
  is '������ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
comment on column TB_SHOPS_INFO.CSS
  is 'ѡ�����̵���ʽ��ϵͳ������ʽƥ�����̷��Ĭ��ֵΪ 0';
alter table TB_SHOPS_INFO
  add constraint PK_TB_SHOPS_INFO primary key (ID);
alter table TB_SHOPS_INFO
  add constraint AK_UQ_SHOPS_CODE_TB_SHOPS unique (SHOPS_CODE);

prompt
prompt Creating table TB_SHOPS_PLAY_ODDS
prompt =================================
prompt
create table TB_SHOPS_PLAY_ODDS
(
  ID               NUMBER(10) not null,
  SHOPS_CODE       CHAR(4),
  PLAY_TYPE_CODE   VARCHAR2(30) not null,
  ODDS_TYPE_X      VARCHAR2(30),
  ODDS_TYPE        VARCHAR2(30),
  REAL_ODDS        NUMBER(12,4) not null,
  REAL_UPDATE_DATE DATE,
  REAL_UPDATE_USER NUMBER(10) not null,
  STATE            CHAR(1) default '0',
  REMARK           NVARCHAR2(200)
)
;
comment on column TB_SHOPS_PLAY_ODDS.SHOPS_CODE
  is '���̱�ţ���Ӧ������Ϣ��TB_SHOPS_INFO�������̺��루SHOPS_CODE���ֶ�';
comment on column TB_SHOPS_PLAY_ODDS.PLAY_TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ��Ͷע���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_SHOPS_PLAY_ODDS.ODDS_TYPE_X
  is '���һЩ�����淨�������ͣ��磺���أ�����1����˫��С��������';
comment on column TB_SHOPS_PLAY_ODDS.ODDS_TYPE
  is '���������ͣ���һ�� �ȣ�';
comment on column TB_SHOPS_PLAY_ODDS.REAL_ODDS
  is 'ʵʱ����ֵ';
comment on column TB_SHOPS_PLAY_ODDS.REAL_UPDATE_USER
  is 'ʵʱ���ʸ�����ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
comment on column TB_SHOPS_PLAY_ODDS.STATE
  is '��Ͷע���͵�ǰ�Ƿ���Ч��0 �� ��Ч��1 �� ��Ч��2 �� ɾ����Ĭ��ֵ 0
';
alter table TB_SHOPS_PLAY_ODDS
  add constraint PK_TB_SHOPS_PLAY_ODDS primary key (ID);

prompt
prompt Creating table TB_SHOPS_PLAY_ODDS_LOG
prompt =====================================
prompt
create table TB_SHOPS_PLAY_ODDS_LOG
(
  ID                      NUMBER(10) not null,
  SHOPS_CODE              CHAR(4),
  PLAY_TYPE_CODE          VARCHAR2(30) not null,
  ODDS_TYPE_X             VARCHAR2(30),
  ODDS_TYPE               VARCHAR2(30),
  REAL_ODDS_ORIGIN        NUMBER(12,4) not null,
  REAL_UPDATE_DATE_ORIGIN DATE,
  REAL_UPDATE_USER_ORIGIN NUMBER(10) not null,
  REAL_ODDS_NEW           NUMBER(12,4) not null,
  REAL_UPDATE_DATE_NEW    DATE,
  REAL_UPDATE_USER_NEW    NUMBER(10) not null,
  PERIODS_NUM             VARCHAR2(11),
  IP                      VARCHAR2(20),
  REMARK                  NVARCHAR2(200),
  TYPE                    CHAR(1)
)
;
comment on table TB_SHOPS_PLAY_ODDS_LOG
  is '����������ʷ����¼�������ʱ�TB_SHOPS_PLAY_ODDS�������ݵı䶯���';
comment on column TB_SHOPS_PLAY_ODDS_LOG.SHOPS_CODE
  is '���̱�ţ���Ӧ������Ϣ��TB_SHOPS_INFO�������̺��루SHOPS_CODE���ֶ�';
comment on column TB_SHOPS_PLAY_ODDS_LOG.PLAY_TYPE_CODE
  is 'Ͷע���ͱ��룬��Ӧ��Ͷע���ͱ�TB_PLAY_TYPE�����е����ͱ���';
comment on column TB_SHOPS_PLAY_ODDS_LOG.ODDS_TYPE_X
  is '���һЩ�����淨�������ͣ��磺���أ�����1����˫��С��������';
comment on column TB_SHOPS_PLAY_ODDS_LOG.ODDS_TYPE
  is '���������ͣ���һ�� �ȣ�';
comment on column TB_SHOPS_PLAY_ODDS_LOG.REAL_ODDS_ORIGIN
  is 'ԭ����ʵʱ����ֵ';
comment on column TB_SHOPS_PLAY_ODDS_LOG.REAL_UPDATE_DATE_ORIGIN
  is 'ԭ�����ʸ���ʱ��';
comment on column TB_SHOPS_PLAY_ODDS_LOG.REAL_UPDATE_USER_ORIGIN
  is 'ԭʵʱ���ʸ�����ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
comment on column TB_SHOPS_PLAY_ODDS_LOG.REAL_ODDS_NEW
  is '�µ�ʵʱ����ֵ';
comment on column TB_SHOPS_PLAY_ODDS_LOG.REAL_UPDATE_DATE_NEW
  is '�����ʸ���ʱ��';
comment on column TB_SHOPS_PLAY_ODDS_LOG.REAL_UPDATE_USER_NEW
  is '��ʵʱ���ʸ�����ID����Ӧ��Ա��TB_FRAME_STAFF���е�����';
comment on column TB_SHOPS_PLAY_ODDS_LOG.PERIODS_NUM
  is 'Ͷע����';
comment on column TB_SHOPS_PLAY_ODDS_LOG.TYPE
  is '1:�Զ�������־��2�ֶ��޸���־';
alter table TB_SHOPS_PLAY_ODDS_LOG
  add constraint PK_TB_SHOPS_PLAY_ODDS_LOG primary key (ID);

prompt
prompt Creating table TB_SHOPS_RENT
prompt ============================
prompt
create table TB_SHOPS_RENT
(
  ID                  NUMBER(10) not null,
  SHOPS_CODE          CHAR(4) not null,
  EXPITY_TIME         DATE not null,
  EXPITY_WARNING_TIME DATE not null,
  WARNING_TYPE        CHAR(1),
  WARNING_EMAIL       NVARCHAR2(50),
  WARNING_MOBILE      VARCHAR2(15),
  LAST_MODIFY_USER    NUMBER(10) not null,
  LAST_MODIFY_DATE    DATE not null,
  REMARK              NVARCHAR2(200)
)
;
comment on table TB_SHOPS_RENT
  is '����������Ϣ��';
comment on column TB_SHOPS_RENT.SHOPS_CODE
  is '���̱�ţ���Ӧ������Ϣ��TB_SHOPS_INFO�������̺��루SHOPS_CODE��';
comment on column TB_SHOPS_RENT.EXPITY_TIME
  is '���̵���ʱ��';
comment on column TB_SHOPS_RENT.EXPITY_WARNING_TIME
  is '��������ʱ��';
comment on column TB_SHOPS_RENT.WARNING_TYPE
  is '0 �� ϵͳ����1 �� �ֻ����ţ�2 �� �ʼ���Ĭ��ֵ0
���ֶ���ʱ��ʹ��';
comment on column TB_SHOPS_RENT.WARNING_EMAIL
  is '����������Ϣ���ʼ���ַ��ֻ�е����ѷ�ʽΪ 2 �� �ʼ� ʱ��Ч���ݲ�ʹ��';
comment on column TB_SHOPS_RENT.WARNING_MOBILE
  is '����������Ϣ���ֻ����룬ֻ�е����ѷ�ʽ��ȡֵΪ 1���ֻ����� ʱ��Ч';
comment on column TB_SHOPS_RENT.LAST_MODIFY_USER
  is '���༭��ԱID����Ӧ��Ա��TB_FRAME_STAFF��ID��-1 ��ʾϵͳά��';
alter table TB_SHOPS_RENT
  add constraint PK_TB_SHOPS_RENT primary key (ID);

prompt
prompt Creating table TB_STOCKHOLDER_STAFF_EXT
prompt =======================================
prompt
create table TB_STOCKHOLDER_STAFF_EXT
(
  MANAGER_STAFF_ID      NUMBER(10) not null,
  PARENT_STAFF          NUMBER(10),
  REPLENISHMENT         CHAR(1) not null,
  BRANCH_RATE           NUMBER(5,2),
  PURE_ACCOUNTED        CHAR(1),
  SHAREHOLDER_RATE      NUMBER(5,2),
  TOTAL_CREDIT_LINE     NUMBER(10),
  AVAILABLE_CREDIT_LINE NUMBER(10),
  CHIEF_STAFF           NUMBER(10),
  RATE_RESTRICT         CHAR(1),
  BELOW_RATE_LIMIT      NUMBER(2)
)
;
comment on table TB_STOCKHOLDER_STAFF_EXT
  is '�˱��м�¼�ɶ��û���չ��Ϣ�������û�������TB_FRAME_MANAGER_STAFF���д洢�˹ɶ��û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
-----------------
�ɶ��û��ڹ����û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��4 �� �ɶ��û���';
comment on column TB_STOCKHOLDER_STAFF_EXT.MANAGER_STAFF_ID
  is '�ɶ��û��û�������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
comment on column TB_STOCKHOLDER_STAFF_EXT.PARENT_STAFF
  is '�ϼ��û�';
comment on column TB_STOCKHOLDER_STAFF_EXT.REPLENISHMENT
  is '�߷ɣ���������ȡֵ�������£�0 �� �����߷ɣ�1 �� ��ֹ�߷�';
comment on column TB_STOCKHOLDER_STAFF_EXT.PURE_ACCOUNTED
  is '0 �� ��ռ��1 �� �Ǵ�ռ';
comment on column TB_STOCKHOLDER_STAFF_EXT.SHAREHOLDER_RATE
  is '�ɶ�ռ��';
comment on column TB_STOCKHOLDER_STAFF_EXT.CHIEF_STAFF
  is '�ɶ�����Ӧ���ܼ�ID';
comment on column TB_STOCKHOLDER_STAFF_EXT.RATE_RESTRICT
  is '�Ƿ�����ռ��';
comment on column TB_STOCKHOLDER_STAFF_EXT.BELOW_RATE_LIMIT
  is '����ռ���޶�';
alter table TB_STOCKHOLDER_STAFF_EXT
  add constraint PK_TB_STOCKHOLDER_STAFF_EXT primary key (MANAGER_STAFF_ID);

prompt
prompt Creating table TB_SUB_STAFF_EXT
prompt ===============================
prompt
create table TB_SUB_STAFF_EXT
(
  PARENT_STAFF      NUMBER(10),
  MANAGER_STAFF_ID  NUMBER(10) not null,
  CHIEF_STAFF       NUMBER(10),
  BRANCH_STAFF      NUMBER(10),
  STOCKHOLDER_STAFF NUMBER(10),
  GEN_AGENT_STAFF   NUMBER(10),
  PARENT_USER_TYPE  CHAR(1)
)
;
comment on table TB_SUB_STAFF_EXT
  is '�˱��м�¼�����û���չ��Ϣ�������û�������TB_FRAME_MANAGER_STAFF���д洢�˴����û��Ļ�����Ϣ������ֶζ�Ӧ��ϵ���£�
1����½�˺�
2���û�����
3������¼ʱ��
4������ʱ��
5����������
6��״̬��������/��ֹ��
7������¼IP
-----------------
�����û��ڹ����û�������������Ӧ���û����ͣ�USER_TYPE����ȡֵΪ ��7 �� ���˺š�';
comment on column TB_SUB_STAFF_EXT.PARENT_STAFF
  is '�ϼ��û�';
comment on column TB_SUB_STAFF_EXT.MANAGER_STAFF_ID
  is '�����û�������Ϣ������Ӧ�ļ�¼ID����Ӧ�����û�������TB_FRAME_MANAGER_STAFF����ID';
comment on column TB_SUB_STAFF_EXT.CHIEF_STAFF
  is '���˺�����Ӧ���ܼ�ID';
comment on column TB_SUB_STAFF_EXT.BRANCH_STAFF
  is '���˺�����Ӧ�ķֹ�˾ID';
comment on column TB_SUB_STAFF_EXT.STOCKHOLDER_STAFF
  is '���˺�����Ӧ�Ĺɶ�ID';
comment on column TB_SUB_STAFF_EXT.GEN_AGENT_STAFF
  is '���˺�����Ӧ���ܴ���ID';

prompt
prompt Creating table TB_USER_COMMISSION
prompt =================================
prompt
create table TB_USER_COMMISSION
(
  ID              NUMBER(10) not null,
  USER_ID         NUMBER(10) not null,
  USER_TYPE       CHAR(1) not null,
  PLAY_TYPE       VARCHAR2(30),
  PLAY_FINAL_TYPE VARCHAR2(100) not null,
  COMMISSION_A    NUMBER,
  COMMISSION_B    NUMBER,
  COMMISSION_C    NUMBER,
  BETTING_QUOTAS  NUMBER,
  ITEM_QUOTAS     NUMBER,
  CREATE_USER     NUMBER(10),
  CREATE_TIME     DATE,
  MODIFY_USER     NUMBER(10),
  MODIFY_TIME     DATE,
  CHIEF_ID        NUMBER(10)
)
;
comment on table TB_USER_COMMISSION
  is '�����û�Ӷ��������Ϣ';
comment on column TB_USER_COMMISSION.USER_ID
  is '�û�ID����Ӧ�û����е�ID����Ҫ�����û������ж�����ͨ��Ա���ǹ����Ա�������û������ֶΣ�USER_TYPE����ȡֵΪ1~6ʱ���˴���Ӧ�ڹ����û�������TB_FRAME_MANAGER_STAFF���е�ID�����û������ֶε�ȡֵΪ7ʱ���˴���Ӧ�ڻ�Ա�û�������TB_FRAME_MEMBER_STAFF���е�ID';
comment on column TB_USER_COMMISSION.USER_TYPE
  is '0 �� ϵͳ����Ա��1 �� �ܹ��û���2 �� �ܼ��û���3 �� �ֹ�˾�û���4 �� �ɶ��û���5 �� �ܴ����û���6 �� �����û���7 ����Ա�û�
';
comment on column TB_USER_COMMISSION.PLAY_TYPE
  is '�㶫ʱʱ�ʡ��������ʮ�֡�������ϲʵ�';
comment on column TB_USER_COMMISSION.PLAY_FINAL_TYPE
  is '��ע���ͣ��ܺʹ󣬴�С �ȣ�';
comment on column TB_USER_COMMISSION.CREATE_USER
  is '������ԱID';
alter table TB_USER_COMMISSION
  add constraint PK_TB_USER_COMMISSION primary key (ID);

prompt
prompt Creating table TB_USER_COMMISSION_DEFAULT
prompt =========================================
prompt
create table TB_USER_COMMISSION_DEFAULT
(
  ID              NUMBER(10) not null,
  USER_ID         NUMBER(10),
  USER_TYPE       CHAR(1),
  PLAY_TYPE       VARCHAR2(30),
  PLAY_FINAL_TYPE VARCHAR2(100) not null,
  COMMISSION_A    NUMBER,
  COMMISSION_B    NUMBER,
  COMMISSION_C    NUMBER,
  BETTING_QUOTAS  NUMBER,
  ITEM_QUOTAS     NUMBER,
  TOTAL_QUOTAS    NUMBER,
  LOWEST_QUOTAS   NUMBER,
  WIN_QUOTAS      NUMBER,
  LOSE_QUOTAS     NUMBER,
  CREATE_USER     NUMBER(10),
  CREATE_TIME     DATE,
  MODIFY_USER     NUMBER(10),
  MODIFY_TIME     DATE
)
;
comment on column TB_USER_COMMISSION_DEFAULT.USER_ID
  is '�û�ID����Ӧ�û����е�ID����Ҫ�����û������ж�����ͨ��Ա���ǹ����Ա�������û������ֶΣ�USER_TYPE����ȡֵΪ1~6ʱ���˴���Ӧ�ڹ����û�������TB_FRAME_MANAGER_STAFF���е�ID�����û������ֶε�ȡֵΪ7ʱ���˴���Ӧ�ڻ�Ա�û�������TB_FRAME_MEMBER_STAFF���е�ID';
comment on column TB_USER_COMMISSION_DEFAULT.USER_TYPE
  is '0 �� ϵͳ����Ա��1 �� �ܹ��û���2 �� �ܼ��û���3 �� �ֹ�˾�û���4 �� �ɶ��û���5 �� �ܴ����û���6 �� �����û���7 ����Ա�û�
';
comment on column TB_USER_COMMISSION_DEFAULT.PLAY_TYPE
  is '�㶫ʱʱ�ʡ��������ʮ�֡�������ϲʵ�';
comment on column TB_USER_COMMISSION_DEFAULT.PLAY_FINAL_TYPE
  is '��ע���ͣ��ܺʹ󣬴�С �ȣ�';
comment on column TB_USER_COMMISSION_DEFAULT.CREATE_USER
  is '������ԱID';
alter table TB_USER_COMMISSION_DEFAULT
  add constraint PK_TB_USER_COMMISSION_DEFAULT primary key (ID);

prompt
prompt Creating table TEMP_DELIVERYREPORT
prompt ==================================
prompt
create global temporary table TEMP_DELIVERYREPORT
(
  PARENT_ID                  NUMBER(10),
  USER_ID                    NUMBER(10),
  USER_TYPE                  CHAR(1),
  RECORD_TYPE                CHAR(1),
  SUBORDINATE                NVARCHAR2(50),
  USER_NAME                  NVARCHAR2(50),
  TURNOVER                   NUMBER,
  AMOUNT                     NUMBER,
  VALID_AMOUNT               NUMBER,
  MEMBER_AMOUNT              NUMBER,
  MEMBER_BACK_WATER          NUMBER,
  SUBORDINATE_AMOUNT         NUMBER,
  WIN_BACK_WATER             NUMBER,
  REAL_RESULT                NUMBER,
  WIN_BACK_WATER_RESULT      NUMBER,
  PAY_SUPERIOR               NUMBER,
  COMMISSION_BRANCH          NUMBER,
  COMMISSION_GEN_AGENT       NUMBER,
  COMMISSION_STOCKHOLDER     NUMBER,
  COMMISSION_AGENT           NUMBER,
  COMMISSION_MEMBER          NUMBER,
  WIN_COMMISSION_BRANCH      NUMBER,
  WIN_COMMISSION_GEN_AGENT   NUMBER,
  WIN_COMMISSION_STOCKHOLDER NUMBER,
  WIN_COMMISSION_AGENT       NUMBER,
  WIN_COMMISSION_MEMBER      NUMBER,
  RATE_CHIEF                 NUMBER,
  RATE_BRANCH                NUMBER,
  RATE_GEN_AGENT             NUMBER,
  RATE_STOCKHOLDER           NUMBER,
  RATE_AGENT                 NUMBER,
  MONEY_RATE_CHIEF           NUMBER,
  MONEY_RATE_BRANCH          NUMBER,
  MONEY_RATE_GEN_AGENT       NUMBER,
  MONEY_RATE_STOCKHOLDER     NUMBER,
  MONEY_RATE_AGENT           NUMBER,
  SUBORDINATE_CHIEF          NUMBER,
  SUBORDINATE_BRANCH         NUMBER,
  SUBORDINATE_STOCKHOLDER    NUMBER,
  SUBORDINATE_GEN_AGENT      NUMBER,
  SUBORDINATE_AGENT          NUMBER,
  RATE                       NUMBER,
  RATE_CHIEF_SET             NUMBER,
  RATE_BRANCH_SET            NUMBER,
  RATE_STOCKHOLDER_SET       NUMBER,
  RATE_GEN_AGENT_SET         NUMBER,
  RATE_AGENT_SET             NUMBER,
  COMMISSION_BRANCH_SET      NUMBER,
  COMMISSION_STOCKHOLDER_SET NUMBER,
  COMMISSION_GEN_AGENT_SET   NUMBER,
  COMMISSION_AGENT_SET       NUMBER
)
on commit delete rows;

prompt
prompt Creating sequence SEQ_ORDER_NO
prompt ==============================
prompt
create sequence SEQ_ORDER_NO
minvalue 50000
maxvalue 99999999999
start with 55000
increment by 1
cache 5000;

prompt
prompt Creating sequence SEQ_TB_BJSC
prompt =============================
prompt
create sequence SEQ_TB_BJSC
minvalue 1
maxvalue 999999999999999999999999999
start with 228461
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_BJSC_HIS
prompt =================================
prompt
create sequence SEQ_TB_BJSC_HIS
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_BJSC_PERIODS_INFO
prompt ==========================================
prompt
create sequence SEQ_TB_BJSC_PERIODS_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 79199
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_BOSS_LOG
prompt =================================
prompt
create sequence SEQ_TB_BOSS_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CLASS_REPORT_PET_LIST
prompt ==============================================
prompt
create sequence SEQ_TB_CLASS_REPORT_PET_LIST
minvalue 1
maxvalue 999999999999999999999999999
start with 20241
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CLASS_REPORT_R_LIST
prompt ============================================
prompt
create sequence SEQ_TB_CLASS_REPORT_R_LIST
minvalue 1
maxvalue 999999999999999999999999999
start with 5201
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CQSSC_BALL_FIFTH
prompt =========================================
prompt
create sequence SEQ_TB_CQSSC_BALL_FIFTH
minvalue 1
maxvalue 999999999999999999999999999
start with 23909
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CQSSC_BALL_FIRST
prompt =========================================
prompt
create sequence SEQ_TB_CQSSC_BALL_FIRST
minvalue 1
maxvalue 999999999999999999999999999
start with 40235
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CQSSC_BALL_FORTH
prompt =========================================
prompt
create sequence SEQ_TB_CQSSC_BALL_FORTH
minvalue 1
maxvalue 999999999999999999999999999
start with 21512
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CQSSC_BALL_SECOND
prompt ==========================================
prompt
create sequence SEQ_TB_CQSSC_BALL_SECOND
minvalue 1
maxvalue 999999999999999999999999999
start with 22451
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CQSSC_BALL_THIRD
prompt =========================================
prompt
create sequence SEQ_TB_CQSSC_BALL_THIRD
minvalue 1
maxvalue 999999999999999999999999999
start with 22224
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CQSSC_HIS
prompt ==================================
prompt
create sequence SEQ_TB_CQSSC_HIS
minvalue 1
maxvalue 999999999999999999999999999
start with 343564
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_CQSSC_PERIODS_INFO
prompt ===========================================
prompt
create sequence SEQ_TB_CQSSC_PERIODS_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 38521
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_DEFAULT_PLAY_ODDS
prompt ==========================================
prompt
create sequence SEQ_TB_DEFAULT_PLAY_ODDS
minvalue 1
maxvalue 999999999999999999999999999
start with 5870
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_AREA_ROLE
prompt ========================================
prompt
create sequence SEQ_TB_FRAME_AREA_ROLE
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_AUTHORIZ_AREA
prompt ============================================
prompt
create sequence SEQ_TB_FRAME_AUTHORIZ_AREA
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_DEMO
prompt ===================================
prompt
create sequence SEQ_TB_FRAME_DEMO
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_FUNCTION
prompt =======================================
prompt
create sequence SEQ_TB_FRAME_FUNCTION
minvalue 1
maxvalue 999999999999999999999999999
start with 5410
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_MANAGER_STAFF
prompt ============================================
prompt
create sequence SEQ_TB_FRAME_MANAGER_STAFF
minvalue 1
maxvalue 999999999999999999999999999
start with 800002180
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_MEMBER_STAFF
prompt ===========================================
prompt
create sequence SEQ_TB_FRAME_MEMBER_STAFF
minvalue 1
maxvalue 999999999999999999999999999
start with 100002840
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_MENU
prompt ===================================
prompt
create sequence SEQ_TB_FRAME_MENU
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_ORG
prompt ==================================
prompt
create sequence SEQ_TB_FRAME_ORG
minvalue 1
maxvalue 999999999999999999999999999
start with 360000200
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_PARAM
prompt ====================================
prompt
create sequence SEQ_TB_FRAME_PARAM
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_PARAM_VALUE
prompt ==========================================
prompt
create sequence SEQ_TB_FRAME_PARAM_VALUE
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_RESOURCE
prompt =======================================
prompt
create sequence SEQ_TB_FRAME_RESOURCE
minvalue 1
maxvalue 999999999999999999999999999
start with 6291
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_RES_FUNC
prompt =======================================
prompt
create sequence SEQ_TB_FRAME_RES_FUNC
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_ROLES
prompt ====================================
prompt
create sequence SEQ_TB_FRAME_ROLES
minvalue 1
maxvalue 999999999999999999999999999
start with 930
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_ROLE_FUNC
prompt ========================================
prompt
create sequence SEQ_TB_FRAME_ROLE_FUNC
minvalue 1
maxvalue 999999999999999999999999999
start with 6190
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_STAFF
prompt ====================================
prompt
create sequence SEQ_TB_FRAME_STAFF
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_FRAME_STAFF_ROLE
prompt =========================================
prompt
create sequence SEQ_TB_FRAME_STAFF_ROLE
minvalue 1
maxvalue 999999999999999999999999999
start with 1481
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_EIGHTH
prompt ===========================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_EIGHTH
minvalue 1
maxvalue 999999999999999999999999999
start with 12001
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_FIFTH
prompt ==========================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_FIFTH
minvalue 1
maxvalue 999999999999999999999999999
start with 10081
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_FIRST
prompt ==========================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_FIRST
minvalue 1
maxvalue 999999999999999999999999999
start with 453046
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_FORTH
prompt ==========================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_FORTH
minvalue 1
maxvalue 999999999999999999999999999
start with 10001
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_SECOND
prompt ===========================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_SECOND
minvalue 1
maxvalue 999999999999999999999999999
start with 10441
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_SEVENTH
prompt ============================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_SEVENTH
minvalue 1
maxvalue 999999999999999999999999999
start with 10781
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_SIXTH
prompt ==========================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_SIXTH
minvalue 1
maxvalue 999999999999999999999999999
start with 11241
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_BALL_THIRD
prompt ==========================================
prompt
create sequence SEQ_TB_GDKLSF_BALL_THIRD
minvalue 1
maxvalue 999999999999999999999999999
start with 10061
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_DOUBLE_SIDE
prompt ===========================================
prompt
create sequence SEQ_TB_GDKLSF_DOUBLE_SIDE
minvalue 1
maxvalue 999999999999999999999999999
start with 15061
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_HIS
prompt ===================================
prompt
create sequence SEQ_TB_GDKLSF_HIS
minvalue 1
maxvalue 999999999999999999999999999
start with 100861
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_PERIODS_INFO
prompt ============================================
prompt
create sequence SEQ_TB_GDKLSF_PERIODS_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 31825
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_GDKLSF_STRAIGHTTHROUGH
prompt ===============================================
prompt
create sequence SEQ_TB_GDKLSF_STRAIGHTTHROUGH
minvalue 1
maxvalue 999999999999999999999999999
start with 11801
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_BB
prompt =================================
prompt
create sequence SEQ_TB_HKLHC_BB
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_GG
prompt =================================
prompt
create sequence SEQ_TB_HKLHC_GG
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_HIS
prompt ==================================
prompt
create sequence SEQ_TB_HKLHC_HIS
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_LM
prompt =================================
prompt
create sequence SEQ_TB_HKLHC_LM
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_LX
prompt =================================
prompt
create sequence SEQ_TB_HKLHC_LX
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_PERIODS_INFO
prompt ===========================================
prompt
create sequence SEQ_TB_HKLHC_PERIODS_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_STRAIGHTTHROUGH
prompt ==============================================
prompt
create sequence SEQ_TB_HKLHC_STRAIGHTTHROUGH
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_SXL
prompt ==================================
prompt
create sequence SEQ_TB_HKLHC_SXL
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_SX_WS
prompt ====================================
prompt
create sequence SEQ_TB_HKLHC_SX_WS
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_TE_MA
prompt ====================================
prompt
create sequence SEQ_TB_HKLHC_TE_MA
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_TM_SX
prompt ====================================
prompt
create sequence SEQ_TB_HKLHC_TM_SX
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_WBZ
prompt ==================================
prompt
create sequence SEQ_TB_HKLHC_WBZ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_WSL
prompt ==================================
prompt
create sequence SEQ_TB_HKLHC_WSL
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_ZM16
prompt ===================================
prompt
create sequence SEQ_TB_HKLHC_ZM16
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_Z_MA
prompt ===================================
prompt
create sequence SEQ_TB_HKLHC_Z_MA
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_HKLHC_Z_TE_MA
prompt ======================================
prompt
create sequence SEQ_TB_HKLHC_Z_TE_MA
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_JSSB
prompt =============================
prompt
create sequence SEQ_TB_JSSB
minvalue 1
maxvalue 999999999999999999999999999
start with 20221
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_JSSB_HIS
prompt =================================
prompt
create sequence SEQ_TB_JSSB_HIS
minvalue 1
maxvalue 999999999999999999999999999
start with 3761
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_JSSB_PERIODS_INFO
prompt ==========================================
prompt
create sequence SEQ_TB_JSSB_PERIODS_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 68785
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_LOGIN_LOG_INFO
prompt =======================================
prompt
create sequence SEQ_TB_LOGIN_LOG_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 46182
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_LOTTERY_STATUS
prompt =======================================
prompt
create sequence SEQ_TB_LOTTERY_STATUS
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_OPEN_PLAY_ODDS
prompt =======================================
prompt
create sequence SEQ_TB_OPEN_PLAY_ODDS
minvalue 1
maxvalue 999999999999999999999999999
start with 7941
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_PERIODS_AUTO_ODDS
prompt ==========================================
prompt
create sequence SEQ_TB_PERIODS_AUTO_ODDS
minvalue 1
maxvalue 999999999999999999999999999
start with 2541
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_PLAYODDS_LOG
prompt =====================================
prompt
create sequence SEQ_TB_PLAYODDS_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_PLAY_AMOUNT
prompt ====================================
prompt
create sequence SEQ_TB_PLAY_AMOUNT
minvalue 1
maxvalue 999999999999999999999999999
start with 63501
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_PLAY_TYPE
prompt ==================================
prompt
create sequence SEQ_TB_PLAY_TYPE
minvalue 1
maxvalue 999999999999999999999999999
start with 3730
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_PLAY_WIN_INFO
prompt ======================================
prompt
create sequence SEQ_TB_PLAY_WIN_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 5870
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_REPLENISH
prompt ==================================
prompt
create sequence SEQ_TB_REPLENISH
minvalue 1
maxvalue 999999999999999999999999999
start with 98861
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_REPLENISH_AUTO
prompt =======================================
prompt
create sequence SEQ_TB_REPLENISH_AUTO
minvalue 1
maxvalue 999999999999999999999999999
start with 6321
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_REPLENISH_AUTO_LOG
prompt ===========================================
prompt
create sequence SEQ_TB_REPLENISH_AUTO_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 49461
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_REPLENISH_AUTO_SET_LOG
prompt ===============================================
prompt
create sequence SEQ_TB_REPLENISH_AUTO_SET_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 30251
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_REPLENISH_HIS
prompt ======================================
prompt
create sequence SEQ_TB_REPLENISH_HIS
minvalue 1
maxvalue 999999999999999999999999999
start with 68641
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_REPORT_STATUS
prompt ======================================
prompt
create sequence SEQ_TB_REPORT_STATUS
minvalue 1
maxvalue 999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SETTLED_REPORT_PET_LIST
prompt ================================================
prompt
create sequence SEQ_TB_SETTLED_REPORT_PET_LIST
minvalue 1
maxvalue 999999999999999999999999999
start with 5441
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SETTLED_REPORT_R_LIST
prompt ==============================================
prompt
create sequence SEQ_TB_SETTLED_REPORT_R_LIST
minvalue 1
maxvalue 999999999999999999999999999
start with 821
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SHOPS_DECLARATION
prompt ==========================================
prompt
create sequence SEQ_TB_SHOPS_DECLARATION
minvalue 1
maxvalue 999999999999999999999999999
start with 641
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SHOPS_HKLHC_PERIODS
prompt ============================================
prompt
create sequence SEQ_TB_SHOPS_HKLHC_PERIODS
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SHOPS_INFO
prompt ===================================
prompt
create sequence SEQ_TB_SHOPS_INFO
minvalue 1
maxvalue 999999999999999999999999999
start with 821
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SHOPS_PLAY_ODDS
prompt ========================================
prompt
create sequence SEQ_TB_SHOPS_PLAY_ODDS
minvalue 1
maxvalue 999999999999999999999999999
start with 71981
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SHOPS_PLAY_ODDS_LOG
prompt ============================================
prompt
create sequence SEQ_TB_SHOPS_PLAY_ODDS_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 8653
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SHOPS_RENT
prompt ===================================
prompt
create sequence SEQ_TB_SHOPS_RENT
minvalue 1
maxvalue 999999999999999999999999999
start with 821
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_SUB_STAFF_EXT
prompt ======================================
prompt
create sequence SEQ_TB_SUB_STAFF_EXT
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_USER_COMMISSION
prompt ========================================
prompt
create sequence SEQ_TB_USER_COMMISSION
minvalue 1
maxvalue 999999999999999999999999999
start with 93141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_USER_COMMISSION_DEFAULT
prompt ================================================
prompt
create sequence SEQ_TB_USER_COMMISSION_DEFAULT
minvalue 1
maxvalue 999999999999999999999999999
start with 4081
increment by 1
cache 20;

prompt
prompt Creating view VIEW_BJSC_HIS_TODAY
prompt =================================
prompt
create or replace view view_bjsc_his_today as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK"
    from TB_BJSC_HIS
 where trunc(betting_date- interval '6' hour)=trunc(sysdate- interval '6' hour);

prompt
prompt Creating view VIEW_BJSC_HIS_YESTERDAY
prompt =====================================
prompt
create or replace view view_bjsc_his_yesterday as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK"
    from TB_BJSC_HIS
 where betting_date between to_date(to_char(sysdate-1,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00')
and to_date(to_char(sysdate,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00');

prompt
prompt Creating view VIEW_CQSSC_HIS_TODAY
prompt ==================================
prompt
create or replace view view_cqssc_his_today as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK"
    from TB_CQSSC_HIS
 where trunc(betting_date- interval '6' hour)=trunc(sysdate- interval '6' hour);

prompt
prompt Creating view VIEW_CQSSC_HIS_YESTERDAY
prompt ======================================
prompt
create or replace view view_cqssc_his_yesterday as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK"
    from TB_CQSSC_HIS
 where betting_date between to_date(to_char(sysdate-1,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00')
and to_date(to_char(sysdate,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00');

prompt
prompt Creating view VIEW_GDKLSF_HIS_TODAY
prompt ===================================
prompt
create or replace view view_gdklsf_his_today as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","COMPOUND_NUM","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","ATTRIBUTE","SPLIT_ATTRIBUTE","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK" from tb_gdklsf_his t
where trunc(betting_date- interval '6' hour)=trunc(sysdate- interval '6' hour);

prompt
prompt Creating view VIEW_GDKLSF_HIS_YESTERDAY
prompt =======================================
prompt
create or replace view view_gdklsf_his_yesterday as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","COMPOUND_NUM","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","ATTRIBUTE","SPLIT_ATTRIBUTE","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK" from tb_gdklsf_his t
where betting_date between to_date(to_char(sysdate-1,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00')
and to_date(to_char(sysdate,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00');

prompt
prompt Creating view VIEW_JSSB_HIS_TODAY
prompt =================================
prompt
create or replace view view_jssb_his_today as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK","PLUS_ODDS"
    from TB_JSSB_HIS
 where trunc(betting_date- interval '6' hour)=trunc(sysdate- interval '6' hour);

prompt
prompt Creating view VIEW_JSSB_HIS_YESTERDAY
prompt =====================================
prompt
create or replace view view_jssb_his_yesterday as
select "ID","CREATE_DATE","ORIGIN_TB_NAME","ORIGIN_ID","ORDER_NO","TYPE_CODE","MONEY","BETTING_USER_ID","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","RATE_CHIEF","RATE_BRANCH","RATE_GEN_AGENT","RATE_STOCKHOLDER","RATE_AGENT","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION_TYPE","UPDATE_DATE","REMARK","PLUS_ODDS"
    from TB_JSSB_HIS
 where betting_date between to_date(to_char(sysdate-1,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00')
and to_date(to_char(sysdate,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00');

prompt
prompt Creating view VIEW_REPLENISH_HIS_TODAY
prompt ======================================
prompt
CREATE OR REPLACE VIEW VIEW_REPLENISH_HIS_TODAY AS
select "ID","ORDER_NO","TYPE_CODE","MONEY","ATTRIBUTE","REPLENISH_USER_ID","REPLENISH_ACC_USER_ID","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION","RATE","UPDATE_USER","UPDATE_DATE","REMARK","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","RATE_CHIEF","RATE_BRANCH","RATE_STOCKHOLDER","RATE_GEN_AGENT","RATE_AGENT","ODDS2","COMMISSION_CHIEF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","COMMISSION_TYPE","SELECT_ODDS"
    from TB_REPLENISH_HIS
 where trunc(betting_date- interval '6' hour)=trunc(sysdate- interval '6' hour);

prompt
prompt Creating view VIEW_REPLENISH_HIS_YESTERDAY
prompt ==========================================
prompt
CREATE OR REPLACE VIEW VIEW_REPLENISH_HIS_YESTERDAY AS
select "ID","ORDER_NO","TYPE_CODE","MONEY","ATTRIBUTE","REPLENISH_USER_ID","REPLENISH_ACC_USER_ID","PERIODS_NUM","PLATE","BETTING_DATE","WIN_STATE","WIN_AMOUNT","ODDS","COMMISSION","RATE","UPDATE_USER","UPDATE_DATE","REMARK","CHIEFSTAFF","BRANCHSTAFF","STOCKHOLDERSTAFF","GENAGENSTAFF","AGENTSTAFF","RATE_CHIEF","RATE_BRANCH","RATE_STOCKHOLDER","RATE_GEN_AGENT","RATE_AGENT","ODDS2","COMMISSION_CHIEF","COMMISSION_BRANCH","COMMISSION_GEN_AGENT","COMMISSION_STOCKHOLDER","COMMISSION_AGENT","COMMISSION_MEMBER","COMMISSION_TYPE","SELECT_ODDS"
    from TB_REPLENISH_HIS
 where betting_date between to_date(to_char(sysdate-1,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00')
and to_date(to_char(sysdate,'yyyy-MM-dd'),'yyyy-MM-dd')+to_dsinterval('0 2:00:00');

prompt
prompt Creating package STATREPORTRESULT
prompt =================================
prompt
CREATE OR REPLACE PACKAGE statReportResult IS
  type resultRef is ref cursor;

END statReportResult;
/

prompt
prompt Creating procedure DELIVERY_REPORT_AGENT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Agent(
/*==============================================================*/
/*                  �����ձ���洢����                        */
/*==============================================================*/
     userID IN varchar2,                -- ����ID
     LOTTERY1688Type IN varchar2,           -- ��Ʊ����
     playType IN varchar2,              -- ��ע����
     periodsNum IN varchar2,            -- ����
     startDate IN varchar2,             -- ��ʼʱ��
     endDate IN varchar2,               -- ����ʱ��
     resultFlag OUT varchar2,           -- �洢ִ�н��ֵ��0-�ɹ���1-userIDΪ�գ�2-����Ϊ��; 9-δ֪����
     statReportAgent OUT statReportResult.resultRef         -- ���ؽ����
) AS
     subordinate varchar2(50);          -- �¼���½�˺�
     userName varchar2(50);             -- �û�����
     turnover_gdklsf NUMBER;            -- �ɽ��������㶫����ʮ�֣�
     turnover_cqssc NUMBER;             -- �ɽ�����������ʱʱ�ʣ�
     turnover_hklhc NUMBER;             -- �ɽ�������������ϲʣ�
     turnover_bjsc NUMBER;              -- �ɽ�����������������
     amount NUMBER;                     -- Ͷע�ܶ�
     validAmount NUMBER;                -- ��Ч���
     memberAmount NUMBER;               -- ��Ա��Ӯ
     memberBackWater NUMBER;            -- ��Ա��ˮ
     subordinateAmount NUMBER;          -- Ӧ������
     winBackWater NUMBER;               -- ׬ȡ��ˮ
     realResult NUMBER;                 -- ʵռ���
     winBackWaterResult NUMBER;         -- ׬ˮ����
     paySuperior NUMBER;                -- Ӧ���ϼ�
     subID NUMBER;                      -- ��¼ID
     memberAmount_temp NUMBER;          -- ��ʱ�������洢��Ա��Ӯ����
     memberBackWater_temp NUMBER;       -- ��ʱ��������Ա��ˮ
     recNum NUMBER;                     -- ��ʱ��������¼��

     -- �����α�
     type   mycursor   is   ref   cursor;

     sql_str varchar2(2000);                    -- ��ʱSQL���

     sql_gdklsf varchar2(2000);                 -- �㶫����ʮ�ֲ�ѯ sql
     cursor_his_gdklsf  mycursor;               -- �㶫����ʮ���α�
     member_pos_gdklsf TB_GDKLSF_HIS%rowtype;   -- �㶫����ʮ�����ݶ���

     sql_cqssc varchar2(2000);                  -- ����ʱʱ�ʲ�ѯ sql
     cursor_his_cqssc  mycursor;                -- ����ʱʱ���α�
     member_pos_cqssc TB_CQSSC_HIS%rowtype;     -- ����ʱʱ�����ݶ���

     sql_hklhc varchar2(2000);                  -- ������ϲʲ�ѯ sql
     cursor_his_hklhc  mycursor;                -- ������ϲ��α�
     member_pos_hklhc TB_HKLHC_HIS%rowtype;     -- ������ϲ����ݶ���

     sql_bjsc varchar2(2000);                   -- ����������ѯ sql
     cursor_his_bjsc  mycursor;                 -- ���������α�
     member_pos_bjsc TB_BJSC_HIS%rowtype;       -- �����������ݶ���

     sql_replenish varchar2(2000);              -- ������ѯ sql
     cursor_replenish mycursor;                 -- �����α�
     member_pos_replenish TB_REPLENISH%rowtype; -- �������ݶ���
     turnover_replenish NUMBER;                 -- ��������
     amount_replenish NUMBER;                   -- ����Ͷע�ܶ�
     validAmount_replenish NUMBER;              -- ������Ч���
     amount_win_replenish NUMBER;               -- ������Ӯ
     backWater_replenish NUMBER;                -- ������ˮ
     backWaterResult_replenish NUMBER;          -- ��ˮ����
     backWater_replenish_temp NUMBER;           -- ������ˮ����ʱ��
     amount_win_replenish_temp NUMBER;          -- ������Ӯ����ʱ��

     -- �ܶ�ͳ��ֵ
     turnover_total NUMBER;             -- �ɽ��������ܶ
     amount_total NUMBER;               -- Ͷע�ܶ�ܶ
     validAmount_total NUMBER;          -- ��Ч���ܶ
     memberAmount_total NUMBER;         -- ��Ա��Ӯ���ܶ
     memberBackWater_total NUMBER;      -- ��Ա��ˮ���ܶ
     subordinateAmount_total NUMBER;    -- Ӧ�����ߣ��ܶ
     winBackWater_total NUMBER;         -- ׬ȡ��ˮ���ܶ
     realResult_total NUMBER;           -- ʵռ������ܶ
     winBackWaterResult_total NUMBER;   -- ׬ˮ�������ܶ
     paySuperior_total NUMBER;          -- Ӧ���ϼ����ܶ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ��
     commissionBranch NUMBER;           -- �ֹ�˾Ӷ��
     commissionGenAgent NUMBER;         -- �ܴ���Ӷ��
     commissionStockholder NUMBER;      -- �ɶ�Ӷ��
     commissionAgent NUMBER;            -- ����Ӷ��
     commissionMember NUMBER;           -- ��ԱӶ��

     winCommissionBranch NUMBER;           -- �ֹ�˾׬ȡӶ��
     winCommissionGenAgent NUMBER;         -- �ܴ���׬ȡӶ��
     winCommissionStockholder NUMBER;      -- �ɶ�׬ȡӶ��
     winCommissionAgent NUMBER;            -- ����׬ȡӶ��
     winCommissionMember NUMBER;           -- ��Ա׬ȡӶ��

     rateChief NUMBER;                  -- �ܼ�ռ��
     rateBranch NUMBER;                 -- �ֹ�˾ռ��
     rateGenAgent NUMBER;               -- �ܴ���ռ��
     rateStockholder NUMBER;            -- �ɶ�ռ��
     rateAgent NUMBER;                  -- ����ռ��

     moneyRateChief NUMBER;             -- �ܼ�ʵռע��
     moneyRateBranch NUMBER;            -- �ֹ�˾ʵռע��
     moneyRateGenAgent NUMBER;          -- �ܴ���ʵռע��
     moneyRateStockholder NUMBER;       -- �ɶ�ʵռע��
     moneyRateAgent NUMBER;             -- ����ʵռע��

     subordinateChief NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent NUMBER;           -- ����Ӧ�գ�����
     rate NUMBER;                       -- ռ������ֵ
     rateChiefSet NUMBER;               -- �ܼ�ռ������ֵ
     rateBranchSet NUMBER;              -- �ֹ�˾ռ������ֵ
     rateStockholderSet NUMBER;         -- �ɶ�ռ������ֵ
     rateGenAgentSet NUMBER;            -- �ܴ���ռ������ֵ
     rateAgentSet NUMBER;               -- ����ռ������ֵ
     commissionBranchSet NUMBER;        -- �ֹ�˾��ˮ����ֵ
     commissionStockholderSet NUMBER;   -- �ɶ���ˮ����ֵ
     commissionGenAgentSet NUMBER;      -- �ܴ�����ˮ����ֵ
     commissionAgentSet NUMBER;         -- ������ˮ����ֵ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ�գ��ܶ
     commissionBranch_total NUMBER;           -- �ֹ�˾Ӷ���ܶ
     commissionGenAgent_total NUMBER;         -- �ܴ���Ӷ���ܶ
     commissionStockholder_total NUMBER;      -- �ɶ�Ӷ���ܶ
     commissionAgent_total NUMBER;            -- ����Ӷ���ܶ
     commissionMember_total NUMBER;           -- ��ԱӶ���ܶ

     winCommissionBranch_total NUMBER;           -- �ֹ�˾׬ȡӶ���ܶ
     winCommissionGenAgent_total NUMBER;         -- �ܴ���׬ȡӶ���ܶ
     winCommissionStockholder_total NUMBER;      -- �ɶ�׬ȡӶ���ܶ
     winCommissionAgent_total NUMBER;            -- ����׬ȡӶ���ܶ
     winCommissionMember_total NUMBER;           -- ��Ա׬ȡӶ���ܶ

     rateChief_total NUMBER;                  -- �ܼ�ռ�ɣ��ܶ
     rateBranch_total NUMBER;                 -- �ֹ�˾ռ�ɣ��ܶ
     rateGenAgent_total NUMBER;               -- �ܴ���ռ�ɣ��ܶ
     rateStockholder_total NUMBER;            -- �ɶ�ռ�ɣ��ܶ
     rateAgent_total NUMBER;                  -- ����ռ�ɣ��ܶ

     moneyRateChief_total NUMBER;                  -- �ܼ�ʵռע��ܶ
     moneyRateBranch_total NUMBER;                 -- �ֹ�˾ʵռע��ܶ
     moneyRateGenAgent_total NUMBER;               -- �ܴ���ʵռע��ܶ
     moneyRateStockholder_total NUMBER;            -- �ɶ�ʵռע��ܶ
     moneyRateAgent_total NUMBER;                  -- ����ʵռע��ܶ

     subordinateChief_total NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch_total NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder_total NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent_total NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent_total NUMBER;           -- ����Ӧ�գ�����

     -- ռ������ֵֻȡ���һ��ֵ�����ܺ�ֵ��Ч
     recNum_total NUMBER;                     -- ��ʱ��������Ч��Ա��
     --rate_total NUMBER;                       -- ռ������ֵ���ܺͣ�
     --rateChiefSet_total NUMBER;               -- �ܼ�ռ������ֵ���ܺͣ�
     --rateBranchSet_total NUMBER;              -- �ֹ�˾ռ������ֵ���ܺͣ�
     --rateStockholderSet_total NUMBER;         -- �ɶ�ռ������ֵ���ܺͣ�
     --rateGenAgentSet_total NUMBER;            -- �ܴ���ռ������ֵ���ܺͣ�
     --rateAgentSet_total NUMBER;               -- ����ռ������ֵ���ܺͣ�

BEGIN
     -- ��ʼ�����ؽ��ֵ
     resultFlag := 0;

     -- 1.1 У���������
     dbms_output.put_line('userID��'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 ��ʼ���ܶ�
     turnover_total := 0;
     amount_total := 0;
     validAmount_total := 0;
     memberAmount_total := 0;
     memberBackWater_total := 0;
     subordinateAmount_total := 0;
     winBackWater_total := 0;
     realResult_total := 0;
     winBackWaterResult_total := 0;
     paySuperior_total := 0;

     commissionBranch_total := 0;
     commissionGenAgent_total := 0;
     commissionStockholder_total := 0;
     commissionAgent_total := 0;
     commissionMember_total := 0;

     -- ׬ȡ��ˮ
     winCommissionBranch_total := 0;
     winCommissionGenAgent_total := 0;
     winCommissionStockholder_total := 0;
     winCommissionAgent_total := 0;
     winCommissionMember_total := 0;

     rateChief_total := 0;
     rateBranch_total := 0;
     rateGenAgent_total := 0;
     rateStockholder_total := 0;
     rateAgent_total := 0;

     moneyRateChief_total := 0;
     moneyRateBranch_total := 0;
     moneyRateGenAgent_total := 0;
     moneyRateStockholder_total := 0;
     moneyRateAgent_total := 0;

     subordinateChief_total := 0;
     subordinateBranch_total := 0;
     subordinateStockholder_total := 0;
     subordinateGenAgent_total := 0;
     subordinateAgent_total := 0;

     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 2. ��ѯ�����Ӧ�Ļ�Ա��Ϣ
     declare
     cursor agent_cursor
     IS
     SELECT * FROM
         (TB_MEMBER_STAFF_EXT ext INNER JOIN TB_FRAME_MEMBER_STAFF member ON ext.MEMBER_STAFF_ID = member.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1 ɾ����ʱ���еı���ͳ������
          DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

          -- 2.2 ѭ���������еĻ�Ա��Ϣ
          FOR agent_member_pos IN agent_cursor LOOP
              -- 3.1 ������ݼ�¼
              subordinate := agent_member_pos.ACCOUNT;             -- �¼���½�˺�
              userName := agent_member_pos.CHS_NAME;               -- �û�����
              subID := agent_member_pos.ID;                        -- ��¼ID

              -- 3.2 ��ʼ������
              turnover_gdklsf := 0;           -- �ɽ��������㶫����ʮ�֣�
              turnover_cqssc := 0;            -- �ɽ�����������ʱʱ�ʣ�
              turnover_hklhc := 0;            -- �ɽ�������������ϲʣ�
              turnover_bjsc := 0;             -- �ɽ�����������������
              amount := 0;                    -- Ͷע�ܶ�
              validAmount := 0;               -- ��Ч���
              memberAmount := 0;              -- ��Ա��Ӯ
              subordinateAmount := 0;         -- Ӧ������
              memberBackWater := 0;           -- ��Ա��ˮ
              winBackWater := 0;              -- ׬ȡ��ˮ
              realResult := 0;                -- ʵռ���
              winBackWaterResult := 0;        -- ׬ˮ����
              paySuperior := 0;               -- Ӧ���ϼ�
              recNum := 0;

              -- 3.3 ��ʼ���洢��������Ӧ�ļ�����Ӷ��ռ�ɡ��¼�Ӧ��
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              winCommissionBranch := 0;
              winCommissionGenAgent := 0;
              winCommissionStockholder := 0;
              winCommissionAgent := 0;
              winCommissionMember := 0;

              rateChief := 0;
              rateBranch := 0;
              rateGenAgent := 0;
              rateStockholder := 0;
              rateAgent := 0;

              moneyRateChief := 0;
              moneyRateBranch := 0;
              moneyRateGenAgent := 0;
              moneyRateStockholder := 0;
              moneyRateAgent := 0;

              subordinateChief := 0;
              subordinateBranch := 0;
              subordinateStockholder := 0;
              subordinateGenAgent := 0;
              subordinateAgent := 0;
              rate := 0;
              rateChiefSet := 0;
              rateBranchSet := 0;
              rateStockholderSet := 0;
              rateGenAgentSet := 0;
              rateAgentSet := 0;
              commissionBranchSet := 0;
              commissionStockholderSet := 0;
              commissionGenAgentSet := 0;
              commissionAgentSet := 0;

              /******** �㶫����ʮ�� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'GDKLSF' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_gdklsf := 'SELECT * FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_gdklsf := sql_gdklsf || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_gdklsf
              FOR
              sql_gdklsf;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_gdklsf;
              turnover_total := turnover_total + turnover_gdklsf;

              BEGIN
                   LOOP
                   FETCH cursor_his_gdklsf INTO member_pos_gdklsf;
                       -- ���������˳�
                       IF (cursor_his_gdklsf%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_gdklsf.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_gdklsf.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_AGENT / 100);

                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_gdklsf.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_gdklsf.WIN_AMOUNT;
                          memberAmount_temp := member_pos_gdklsf.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_gdklsf.MONEY;
                          memberAmount_temp := - member_pos_gdklsf.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_gdklsf.RATE_CHIEF + member_pos_gdklsf.RATE_BRANCH + member_pos_gdklsf.RATE_GEN_AGENT + member_pos_gdklsf.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_gdklsf.RATE_STOCKHOLDER/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);
                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * member_pos_gdklsf.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * member_pos_gdklsf.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * member_pos_gdklsf.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 - member_pos_gdklsf.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_gdklsf.RATE_AGENT ;-- ����ռ�ɣ�ֻ��Ҫ�����һ����¼��ռ�ɼ��ɣ�
                       rateChiefSet := rateChiefSet + member_pos_gdklsf.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_gdklsf.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_gdklsf.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_gdklsf.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_gdklsf.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_gdklsf.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_gdklsf.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_gdklsf.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_gdklsf.COMMISSION_AGENT;

                   END LOOP;
                   CLOSE cursor_his_gdklsf;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ��������ʵռ���ֵ
              realResult := rateAgent;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** �㶫����ʮ�� ���� ********/

              /******** ����ʱʱ�� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'CQSSC' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_cqssc := 'SELECT * FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_cqssc := sql_cqssc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_cqssc
              FOR
              sql_cqssc;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_cqssc;
              turnover_total := turnover_total + turnover_cqssc;

              BEGIN
                   LOOP
                   FETCH cursor_his_cqssc INTO member_pos_cqssc;
                       -- ���������˳�
                       IF (cursor_his_cqssc%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_cqssc.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_cqssc.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100) * (1 - member_pos_cqssc.RATE_AGENT / 100);

                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_cqssc.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_cqssc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_cqssc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_cqssc.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_cqssc.MONEY;
                          memberAmount_temp := - member_pos_cqssc.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_cqssc.RATE_CHIEF + member_pos_cqssc.RATE_BRANCH + member_pos_cqssc.RATE_GEN_AGENT + member_pos_cqssc.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_cqssc.RATE_STOCKHOLDER/100 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * member_pos_cqssc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * member_pos_cqssc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * member_pos_cqssc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * member_pos_cqssc.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100 - member_pos_cqssc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_cqssc.RATE_AGENT ;-- ����ռ�ɣ�ֻ��Ҫ�����һ����¼��ռ�ɼ��ɣ�
                       rateChiefSet := rateChiefSet + member_pos_cqssc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_cqssc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_cqssc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_cqssc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_cqssc.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_cqssc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_cqssc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_cqssc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_cqssc.COMMISSION_AGENT;
                   END LOOP;
                   CLOSE cursor_his_cqssc;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ��������ʵռ���ֵ
              realResult := rateAgent;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** ����ʱʱ�� ���� ********/

              /******** ������ϲ� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'HKLHC' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_hklhc := 'SELECT * FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_hklhc := sql_hklhc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_hklhc
              FOR
              sql_hklhc;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_hklhc;
              turnover_total := turnover_total + turnover_hklhc;

              BEGIN
                   LOOP
                   FETCH cursor_his_hklhc INTO member_pos_hklhc;

                       -- ���������˳�
                       IF (cursor_his_hklhc%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_hklhc.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_hklhc.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100) * (1 - member_pos_hklhc.RATE_AGENT / 100);

                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_hklhc.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_hklhc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_hklhc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_hklhc.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_hklhc.MONEY;
                          memberAmount_temp := - member_pos_hklhc.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                       -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_hklhc.RATE_CHIEF + member_pos_hklhc.RATE_BRANCH + member_pos_hklhc.RATE_GEN_AGENT + member_pos_hklhc.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_hklhc.RATE_STOCKHOLDER/100 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * member_pos_hklhc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * member_pos_hklhc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * member_pos_hklhc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * member_pos_hklhc.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100 - member_pos_hklhc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_hklhc.RATE_AGENT ;-- ����ռ�ɣ�ֻ��Ҫ�����һ����¼��ռ�ɼ��ɣ�
                       rateChiefSet := rateChiefSet + member_pos_hklhc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_hklhc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_hklhc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_hklhc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_hklhc.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_hklhc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_hklhc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_hklhc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_hklhc.COMMISSION_AGENT;
                   END LOOP;
                   CLOSE cursor_his_hklhc;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ��������ʵռ���ֵ
              realResult := rateAgent;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** ������ϲ� ���� ********/

              /******** �������� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'BJSC' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_bjsc := 'SELECT * FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_bjsc := sql_bjsc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_bjsc
              FOR
              sql_bjsc;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_bjsc;
              turnover_total := turnover_total + turnover_bjsc;

              BEGIN
                   LOOP
                   FETCH cursor_his_bjsc INTO member_pos_bjsc;
                       -- ���������˳�
                       IF (cursor_his_bjsc%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_bjsc.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_bjsc.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_AGENT / 100);

                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_bjsc.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_bjsc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_bjsc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_bjsc.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_bjsc.MONEY;
                          memberAmount_temp := - member_pos_bjsc.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_bjsc.RATE_CHIEF + member_pos_bjsc.RATE_BRANCH + member_pos_bjsc.RATE_GEN_AGENT + member_pos_bjsc.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_bjsc.RATE_STOCKHOLDER/100 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * member_pos_bjsc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * member_pos_bjsc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * member_pos_bjsc.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * member_pos_bjsc.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100 - member_pos_bjsc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_bjsc.RATE_AGENT ;-- ����ռ�ɣ�ֻ��Ҫ�����һ����¼��ռ�ɼ��ɣ�
                       rateChiefSet := rateChiefSet + member_pos_bjsc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_bjsc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_bjsc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_bjsc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_bjsc.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_bjsc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_bjsc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_bjsc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_bjsc.COMMISSION_AGENT;

                   END LOOP;
                   CLOSE cursor_his_bjsc;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ��������ʵռ���ֵ
              realResult := rateAgent;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** �������� ���� ********/

              -- ����ռ������ֵ��ƽ��ֵ
              IF (recNum > 0) THEN
                 rateChiefSet := rateChiefSet / recNum;
                 rateBranchSet := rateBranchSet / recNum;
                 rateStockholderSet := rateStockholderSet / recNum;
                 rateGenAgentSet := rateGenAgentSet / recNum;
                 rateAgentSet := rateAgentSet / recNum;

                 -- rate��ֵ����Ϊ�����ֵ
                 rate := rateAgentSet;
                 -- �ۼ���ЧͶע��Ա��
                 recNum_total := recNum_total + 1;
                 -- �ۼ�ռ������ֵ����ֵ
                 --rate_total := rate_total + rate;
                 --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                 --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                 --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                 --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                 --rateAgentSet_total := rateAgentSet_total + rateAgentSet;
              END IF;

              -- 5. �ۼ��ܶ�
              amount_total := amount_total + amount;
              validAmount_total := validAmount_total + validAmount;
              memberAmount_total := memberAmount_total + memberAmount;
              memberBackWater_total := memberBackWater_total + memberBackWater;
              subordinateAmount_total := subordinateAmount_total + subordinateAmount;
              winBackWater_total := winBackWater_total + winBackWater;
              realResult_total := realResult_total + realResult;
              winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
              paySuperior_total := paySuperior_total + paySuperior;

              -- 6. �ۻ���������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
              commissionBranch_total := commissionBranch_total + commissionBranch;
              commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
              commissionStockholder_total := commissionStockholder_total + commissionStockholder;
              commissionAgent_total := commissionAgent_total + commissionAgent;
              commissionMember_total := commissionMember_total + commissionMember;

              -- ׬ȡ��ˮ
              winCommissionBranch_total := winCommissionBranch_total + winCommissionBranch;
              winCommissionGenAgent_total := winCommissionGenAgent_total + winCommissionGenAgent;
              winCommissionStockholder_total := winCommissionStockholder_total + winCommissionStockholder;
              winCommissionAgent_total := winCommissionAgent_total + winCommissionAgent;
              winCommissionMember_total := winCommissionMember_total + winCommissionMember;

              rateChief_total := rateChief_total + rateChief;
              rateBranch_total := rateBranch_total + rateBranch;
              rateGenAgent_total := rateGenAgent_total + rateGenAgent;
              rateStockholder_total := rateStockholder_total + rateStockholder;
              rateAgent_total := rateAgent_total + rateAgent;

              moneyRateChief_total := moneyRateChief_total + moneyRateChief;
              moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
              moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
              moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
              moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

              subordinateChief_total := subordinateChief_total + subordinateChief;
              subordinateBranch_total := subordinateBranch_total + subordinateBranch;
              subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
              subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
              subordinateAgent_total := subordinateAgent_total + subordinateAgent;

              -- ����ɽ���������0���򱣴�����
              IF ((turnover_gdklsf + turnover_cqssc + turnover_hklhc + turnover_bjsc) > 0) THEN

                 -- 7. ���ݲ�����ʱ��
                 INSERT INTO TEMP_DELIVERYREPORT
                        (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
                        COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT, RATE, RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET, COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
                        MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
                 VALUES
                        (userID, subID, '9', '0', subordinate, userName, (turnover_gdklsf + turnover_cqssc + turnover_hklhc + turnover_bjsc), amount, validAmount, memberAmount, memberBackWater, subordinateAmount, winBackWater, realResult, winBackWaterResult, paySuperior,
                        commissionBranch, commissionGenAgent, commissionStockholder, commissionAgent, commissionMember, winCommissionBranch, winCommissionGenAgent, winCommissionStockholder, winCommissionAgent, winCommissionMember, rateChief, rateBranch, rateGenAgent, rateStockholder, rateAgent, subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent, rate, rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet, commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
                        moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent
                        );
              END IF;

          END LOOP;
      END;

      -- 6.1 ���ݲ����ڣ��ɽ�����Ϊ0���򷵻�
      IF (turnover_total < 1) THEN
         resultFlag := 2; -- ���ý��
         return;
      END IF;
      -- dbms_output.put_line('rateAgent_total��'||rateAgent_total);

      -- ����ռ������ֵ��ƽ��ֵ
      --IF (recNum_total > 0) THEN
      --   rate_total := rate_total / recNum_total;
      --   rateChiefSet_total := rateChiefSet_total / recNum_total;
      --   rateBranchSet_total := rateBranchSet_total / recNum_total;
      --   rateStockholderSet_total := rateStockholderSet_total / recNum_total;
      --   rateGenAgentSet_total := rateGenAgentSet_total / recNum_total;
      --   rateAgentSet_total := rateAgentSet_total / recNum_total;
      --END IF;

      /******** �������� ��ʼ ********/
      -- 6.2 ��ѯ�������ݣ�����������Ҫ�����淨���Ͳ�ѯ��
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- ֻ��ѯ�����˵Ĳ�������
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- �жϲ�Ʊ����
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- �㶫����ʮ��
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- ������ϲ�
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- ����ʱʱ��
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;
      IF LOTTERY1688Type = 'BJSC' THEN
         -- ��������
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''BJSC_%'' ';
      END IF;

      -- ��ʼ��
      turnover_replenish := 0;                         -- ��������
      amount_replenish := 0;                           -- ����Ͷע�ܶ�
      validAmount_replenish :=0;                       -- ������Ч���
      amount_win_replenish := 0;                       -- ������Ӯ
      backWater_replenish := 0;                        -- ������ˮ
      backWaterResult_replenish := 0;                  -- ��ˮ����
      backWater_replenish_temp := 0;                   -- ������Ӯ����ʱ��
      amount_win_replenish_temp := 0;                  -- ������Ӯ����ʱ��

      -- ��ˮ�������
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      -- ׬ȡӶ����ˮ��
      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- ʵռ���
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- ʵռע��
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- Ӧ������
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- ִ�в�ѯ�����α�
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- ���������˳�
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- �ۼӲ����ܶ�
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- �ۼӲ�������
               turnover_replenish := turnover_replenish + 1;

               -- ������Ӯ����Ӧ�ô������в������ܺ�(������ˮ)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- �ۼӡ��н�����Ͷע��
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- ��ȥ��δ�н�����Ͷע��
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- ������Ч����������
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO ��ˮ��Ҫ��ȫ���м������ˮ��Ϣ
               -- ������ˮ������Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- ����򲻼���Ӷ����ˮ��������ֱ����Ա����
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER) / 100);
                  commissionStockholder := commissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100);
                  commissionGenAgent := commissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - member_pos_replenish.COMMISSION_AGENT) / 100);
                  commissionAgent := commissionAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_AGENT - 0) / 100);

                  -- ׬ȡӶ����ˮ��
                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionStockholder := winCommissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionGenAgent := winCommissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - member_pos_replenish.COMMISSION_AGENT) / 100) * (1 - member_pos_replenish.RATE_AGENT/100);
                  winCommissionAgent := winCommissionAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_AGENT - member_pos_replenish.COMMISSION_MEMBER) / 100);
                  winCommissionMember := winCommissionMember + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_MEMBER - 0) / 100);

                  -- ʵռ�������ˮ������Ҳ���� ��ˮ + ��Ӯ��*ռ��%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  rateBranch := rateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * member_pos_replenish.RATE_BRANCH/100;
                  rateStockholder := rateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * member_pos_replenish.RATE_STOCKHOLDER/100;
                  rateGenAgent := rateGenAgent + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100)) * member_pos_replenish.RATE_GEN_AGENT/100;

                  -- ʵռע���Ч��Ͷע��� * ռ��%��
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- ����Ӧ������
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  subordinateBranch := subordinateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 - member_pos_replenish.RATE_STOCKHOLDER/100);
                  subordinateStockholder := subordinateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_replenish.RATE_GEN_AGENT/100);
                  subordinateGenAgent := subordinateGenAgent + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- ������ˮ��������ˮ + ��Ӯ��
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. �������ݲ�����ʱ�������������ͣ������ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + a�������ʵ��ֵΪ1�������ֵ b��ʵ��ֵΪ0�������a��
      -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
      IF (turnover_replenish > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT,
               COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
               MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
              (userID, userID, 'g', '1', '����', '����', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish,
              commissionBranch, commissionGenAgent, commissionStockholder, commissionAgent, commissionMember, winCommissionBranch, winCommissionGenAgent, winCommissionStockholder, winCommissionAgent, winCommissionMember, rateChief, rateBranch, rateGenAgent, rateStockholder, rateAgent, subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent,
              moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent);
      END IF;

      -- 5. �ۼ��ܶ���Ӳ������ݣ�
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;
      -- commissionAgent_total := commissionAgent_total + backWater_replenish; -- ���Ӵ�������ˮ

      -- 6. �ۻ�������������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
      commissionBranch_total := commissionBranch_total + commissionBranch;
      commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
      commissionStockholder_total := commissionStockholder_total + commissionStockholder;
      commissionAgent_total := commissionAgent_total + commissionAgent;

      winCommissionBranch_total := winCommissionBranch_total + winCommissionBranch;
      winCommissionGenAgent_total := winCommissionGenAgent_total + winCommissionGenAgent;
      winCommissionStockholder_total := winCommissionStockholder_total + winCommissionStockholder;
      winCommissionAgent_total := winCommissionAgent_total + winCommissionAgent;

      rateChief_total := rateChief_total + rateChief;
      rateBranch_total := rateBranch_total + rateBranch;
      rateGenAgent_total := rateGenAgent_total + rateGenAgent;
      rateStockholder_total := rateStockholder_total + rateStockholder;
      rateAgent_total := rateAgent_total + rateAgent;

      moneyRateChief_total := moneyRateChief_total + moneyRateChief;
      moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
      moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
      moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
      moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

      subordinateChief_total := subordinateChief_total + subordinateChief;
      subordinateBranch_total := subordinateBranch_total + subordinateBranch;
      subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
      subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
      subordinateAgent_total := subordinateAgent_total + subordinateAgent;
      /******** �������� ���� ********/

      -- 6.3 �ܶ����ݲ�����ʱ��Ϊ���������ܶ����ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + A�������ʵ��ֵΪ1�������ֵ B��ʵ��ֵΪ0�������A��
      -- C��2�ܼࣩ��D��3�ֹ�˾����E��4�ɶ�����F��5�ܴ�����G��6������H��7���˺ţ�
      IF (turnover_total > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT, RATE, RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET, COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
        VALUES
            (userID, userID, 'G', '0', '', '�ϼƣ�', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total, rate, rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet, commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;

      -- 7. ����ʱ���в�ѯ����
      OPEN statReportAgent
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 8. ���ý�����ɹ�������������
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_DIR_MEMBER
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Dir_Member(
/*==============================================================*/
/*   ֱ����Ա���ձ���洢���̣��˴洢�����ṩ���������û����ã� */
/*==============================================================*/
     userID IN varchar2,                -- �����û�ID
     userType IN varchar2,              -- �����û�����
     LOTTERY1688Type IN varchar2,           -- ��Ʊ����
     playType IN varchar2,              -- ��ע����
     periodsNum IN varchar2,            -- ����
     startDate IN varchar2,             -- ��ʼʱ��
     endDate IN varchar2,               -- ����ʱ��
     resultFlag OUT varchar2            -- �洢ִ�н��ֵ��0-�ɹ���1-userIDΪ�գ�2-����Ϊ��; 9-δ֪����
) AS
     subordinate varchar2(50);          -- �¼���½�˺�
     userName varchar2(50);             -- �û�����
     turnover_gdklsf NUMBER;            -- �ɽ��������㶫����ʮ�֣�
     turnover_cqssc NUMBER;             -- �ɽ�����������ʱʱ�ʣ�
     turnover_hklhc NUMBER;             -- �ɽ�������������ϲʣ�
     turnover_bjsc NUMBER;              -- �ɽ�����������������
     amount NUMBER;                     -- Ͷע�ܶ�
     validAmount NUMBER;                -- ��Ч���
     memberAmount NUMBER;               -- ��Ա��Ӯ
     memberBackWater NUMBER;            -- ��Ա��ˮ
     subordinateAmount NUMBER;          -- Ӧ������
     winBackWater NUMBER;               -- ׬ȡ��ˮ
     realResult NUMBER;                 -- ʵռ���
     winBackWaterResult NUMBER;         -- ׬ˮ����
     paySuperior NUMBER;                -- Ӧ���ϼ�
     subID NUMBER;                      -- ��¼ID
     memberAmount_temp NUMBER;          -- ��ʱ�������洢��Ա��Ӯ����
     memberBackWater_temp NUMBER;       -- ��ʱ��������Ա��ˮ
     recNum NUMBER;                     -- ��ʱ��������¼��

     -- �����α�
     type   mycursor   is   ref   cursor;

     sql_str varchar2(2000);                    -- ��ʱSQL���

     sql_gdklsf varchar2(2000);                 -- �㶫����ʮ�ֲ�ѯ sql
     cursor_his_gdklsf  mycursor;               -- �㶫����ʮ���α�
     member_pos_gdklsf TB_GDKLSF_HIS%rowtype;   -- �㶫����ʮ�����ݶ���

     sql_cqssc varchar2(2000);                  -- ����ʱʱ�ʲ�ѯ sql
     cursor_his_cqssc  mycursor;                -- ����ʱʱ���α�
     member_pos_cqssc TB_CQSSC_HIS%rowtype;     -- ����ʱʱ�����ݶ���

     sql_hklhc varchar2(2000);                  -- ������ϲʲ�ѯ sql
     cursor_his_hklhc  mycursor;                -- ������ϲ��α�
     member_pos_hklhc TB_HKLHC_HIS%rowtype;     -- ������ϲ����ݶ���

     sql_bjsc varchar2(2000);                   -- ��������ʮ�ֲ�ѯ sql
     cursor_his_bjsc  mycursor;                 -- ��������ʮ���α�
     member_pos_bjsc TB_BJSC_HIS%rowtype;       -- ��������ʮ�����ݶ���

     sql_replenish varchar2(2000);              -- ������ѯ sql
     cursor_replenish mycursor;                 -- �����α�
     member_pos_replenish TB_REPLENISH%rowtype; -- �������ݶ���
     turnover_replenish NUMBER;                 -- ��������
     amount_replenish NUMBER;                   -- ����Ͷע�ܶ�
     validAmount_replenish NUMBER;              -- ������Ч���
     amount_win_replenish NUMBER;               -- ������Ӯ
     backWater_replenish NUMBER;                -- ������ˮ
     backWaterResult_replenish NUMBER;          -- ��ˮ����
     backWater_replenish_temp NUMBER;           -- ������ˮ����ʱ��
     amount_win_replenish_temp NUMBER;          -- ������Ӯ����ʱ��

     -- �ܶ�ͳ��ֵ
     turnover_total NUMBER;             -- �ɽ��������ܶ
     amount_total NUMBER;               -- Ͷע�ܶ�ܶ
     validAmount_total NUMBER;          -- ��Ч���ܶ
     memberAmount_total NUMBER;         -- ��Ա��Ӯ���ܶ
     memberBackWater_total NUMBER;      -- ��Ա��ˮ���ܶ
     subordinateAmount_total NUMBER;    -- Ӧ�����ߣ��ܶ
     winBackWater_total NUMBER;         -- ׬ȡ��ˮ���ܶ
     realResult_total NUMBER;           -- ʵռ������ܶ
     winBackWaterResult_total NUMBER;   -- ׬ˮ�������ܶ
     paySuperior_total NUMBER;          -- Ӧ���ϼ����ܶ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ��
     commissionBranch NUMBER;           -- �ֹ�˾Ӷ��
     commissionGenAgent NUMBER;         -- �ܴ���Ӷ��
     commissionStockholder NUMBER;      -- �ɶ�Ӷ��
     commissionAgent NUMBER;            -- ����Ӷ��
     commissionMember NUMBER;           -- ��ԱӶ��

     winCommissionBranch NUMBER;           -- �ֹ�˾׬ȡӶ��
     winCommissionGenAgent NUMBER;         -- �ܴ���׬ȡӶ��
     winCommissionStockholder NUMBER;      -- �ɶ�׬ȡӶ��
     winCommissionAgent NUMBER;            -- ����׬ȡӶ��
     winCommissionMember NUMBER;           -- ��Ա׬ȡӶ��

     rateChief NUMBER;                  -- �ܼ�ռ��
     rateBranch NUMBER;                 -- �ֹ�˾ռ��
     rateGenAgent NUMBER;               -- �ܴ���ռ��
     rateStockholder NUMBER;            -- �ɶ�ռ��
     rateAgent NUMBER;                  -- ����ռ��

     moneyRateChief NUMBER;             -- �ܼ�ʵռע��
     moneyRateBranch NUMBER;            -- �ֹ�˾ʵռע��
     moneyRateGenAgent NUMBER;          -- �ܴ���ʵռע��
     moneyRateStockholder NUMBER;       -- �ɶ�ʵռע��
     moneyRateAgent NUMBER;             -- ����ʵռע��

     subordinateChief NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent NUMBER;           -- ����Ӧ�գ�����
     rate NUMBER;                       -- ռ������ֵ
     rateChiefSet NUMBER;               -- �ܼ�ռ������ֵ
     rateBranchSet NUMBER;              -- �ֹ�˾ռ������ֵ
     rateStockholderSet NUMBER;         -- �ɶ�ռ������ֵ
     rateGenAgentSet NUMBER;            -- �ܴ���ռ������ֵ
     rateAgentSet NUMBER;               -- ����ռ������ֵ

     commissionBranchSet NUMBER;        -- �ֹ�˾��ˮ����ֵ
     commissionStockholderSet NUMBER;   -- �ɶ���ˮ����ֵ
     commissionGenAgentSet NUMBER;      -- �ܴ�����ˮ����ֵ
     commissionAgentSet NUMBER;         -- ������ˮ����ֵ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ�գ��ܶ
     commissionBranch_total NUMBER;           -- �ֹ�˾Ӷ���ܶ
     commissionGenAgent_total NUMBER;         -- �ܴ���Ӷ���ܶ
     commissionStockholder_total NUMBER;      -- �ɶ�Ӷ���ܶ
     commissionAgent_total NUMBER;            -- ����Ӷ���ܶ
     commissionMember_total NUMBER;           -- ��ԱӶ���ܶ

     winCommissionBranch_total NUMBER;           -- �ֹ�˾׬ȡӶ���ܶ
     winCommissionGenAgent_total NUMBER;         -- �ܴ���׬ȡӶ���ܶ
     winCommissionStockholder_total NUMBER;      -- �ɶ�׬ȡӶ���ܶ
     winCommissionAgent_total NUMBER;            -- ����׬ȡӶ���ܶ
     winCommissionMember_total NUMBER;           -- ��Ա׬ȡӶ���ܶ

     rateChief_total NUMBER;                  -- �ܼ�ռ�ɣ��ܶ
     rateBranch_total NUMBER;                 -- �ֹ�˾ռ�ɣ��ܶ
     rateGenAgent_total NUMBER;               -- �ܴ���ռ�ɣ��ܶ
     rateStockholder_total NUMBER;            -- �ɶ�ռ�ɣ��ܶ
     rateAgent_total NUMBER;                  -- ����ռ�ɣ��ܶ

     moneyRateChief_total NUMBER;                  -- �ܼ�ʵռע��ܶ
     moneyRateBranch_total NUMBER;                 -- �ֹ�˾ʵռע��ܶ
     moneyRateGenAgent_total NUMBER;               -- �ܴ���ʵռע��ܶ
     moneyRateStockholder_total NUMBER;            -- �ɶ�ʵռע��ܶ
     moneyRateAgent_total NUMBER;                  -- ����ʵռע��ܶ

     subordinateChief_total NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch_total NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder_total NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent_total NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent_total NUMBER;           -- ����Ӧ�գ�����

     -- ռ������ֵֻȡ���һ��ֵ�����ܺ�ֵ��Ч
     recNum_total NUMBER;                     -- ��ʱ��������Ч��Ա��
     --rate_total NUMBER;                       -- ռ������ֵ���ܺͣ�
     --rateChiefSet_total NUMBER;               -- �ܼ�ռ������ֵ���ܺͣ�
     --rateBranchSet_total NUMBER;              -- �ֹ�˾ռ������ֵ���ܺͣ�
     --rateStockholderSet_total NUMBER;         -- �ɶ�ռ������ֵ���ܺͣ�
     --rateGenAgentSet_total NUMBER;            -- �ܴ���ռ������ֵ���ܺͣ�
     --rateAgentSet_total NUMBER;               -- ����ռ������ֵ���ܺͣ�

BEGIN
     -- ��ʼ�����ؽ��ֵ
     resultFlag := 0;

     -- 1.1 У���������
     dbms_output.put_line('userID��'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 ��ʼ���ܶ�
     turnover_total := 0;
     amount_total := 0;
     validAmount_total := 0;
     memberAmount_total := 0;
     memberBackWater_total := 0;
     subordinateAmount_total := 0;
     winBackWater_total := 0;
     realResult_total := 0;
     winBackWaterResult_total := 0;
     paySuperior_total := 0;

     commissionBranch_total := 0;
     commissionGenAgent_total := 0;
     commissionStockholder_total := 0;
     commissionAgent_total := 0;
     commissionMember_total := 0;

     -- ׬ȡ��ˮ
     winCommissionBranch_total := 0;
     winCommissionGenAgent_total := 0;
     winCommissionStockholder_total := 0;
     winCommissionAgent_total := 0;
     winCommissionMember_total := 0;

     rateChief_total := 0;
     rateBranch_total := 0;
     rateGenAgent_total := 0;
     rateStockholder_total := 0;
     rateAgent_total := 0;

     moneyRateChief_total := 0;
     moneyRateBranch_total := 0;
     moneyRateGenAgent_total := 0;
     moneyRateStockholder_total := 0;
     moneyRateAgent_total := 0;

     subordinateChief_total := 0;
     subordinateBranch_total := 0;
     subordinateStockholder_total := 0;
     subordinateGenAgent_total := 0;
     subordinateAgent_total := 0;

     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 2 ��ѯ�����Ӧ��ֱ����Ա��Ϣ
      declare
      cursor directly_cursor
      IS
      SELECT * FROM
         (TB_MEMBER_STAFF_EXT ext INNER JOIN TB_FRAME_MEMBER_STAFF member ON ext.MEMBER_STAFF_ID = member.ID)
      WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.2 ѭ���������еĻ�Ա��Ϣ
          FOR dir_member_pos IN directly_cursor LOOP
              -- 3.1 ������ݼ�¼
              subordinate := dir_member_pos.ACCOUNT;             -- �¼���½�˺�
              userName := dir_member_pos.CHS_NAME;               -- �û�����
              subID := dir_member_pos.ID;                        -- ��¼ID

              -- 3.2 ��ʼ������
              turnover_gdklsf := 0;           -- �ɽ��������㶫����ʮ�֣�
              turnover_cqssc := 0;            -- �ɽ�����������ʱʱ�ʣ�
              turnover_hklhc := 0;            -- �ɽ�������������ϲʣ�
              turnover_bjsc := 0;             -- �ɽ�����������������
              amount := 0;                    -- Ͷע�ܶ�
              validAmount := 0;               -- ��Ч���
              memberAmount := 0;              -- ��Ա��Ӯ
              subordinateAmount := 0;         -- Ӧ������
              memberBackWater := 0;           -- ��Ա��ˮ
              winBackWater := 0;              -- ׬ȡ��ˮ
              realResult := 0;                -- ʵռ���
              winBackWaterResult := 0;        -- ׬ˮ����
              paySuperior := 0;               -- Ӧ���ϼ�
              recNum := 0;

              -- 3.3 ��ʼ���洢��������Ӧ�ļ�����Ӷ��ռ�ɡ��¼�Ӧ��
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              winCommissionBranch := 0;
              winCommissionGenAgent := 0;
              winCommissionStockholder := 0;
              winCommissionAgent := 0;
              winCommissionMember := 0;

              rateChief := 0;
              rateBranch := 0;
              rateGenAgent := 0;
              rateStockholder := 0;
              rateAgent := 0;

              moneyRateChief := 0;
              moneyRateBranch := 0;
              moneyRateGenAgent := 0;
              moneyRateStockholder := 0;
              moneyRateAgent := 0;

              subordinateChief := 0;
              subordinateBranch := 0;
              subordinateStockholder := 0;
              subordinateGenAgent := 0;
              subordinateAgent := 0;
              rate := 0;
              rateChiefSet := 0;
              rateBranchSet := 0;
              rateStockholderSet := 0;
              rateGenAgentSet := 0;
              rateAgentSet := 0;

              commissionBranchSet := 0;
              commissionStockholderSet := 0;
              commissionGenAgentSet := 0;
              commissionAgentSet := 0;

              /******** �㶫����ʮ�� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'GDKLSF' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_gdklsf := 'SELECT * FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_gdklsf := sql_gdklsf || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_gdklsf
              FOR
              sql_gdklsf;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_gdklsf;
              turnover_total := turnover_total + turnover_gdklsf;

              BEGIN
                   LOOP
                   FETCH cursor_his_gdklsf INTO member_pos_gdklsf;
                       -- ���������˳�
                       IF (cursor_his_gdklsf%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_gdklsf.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_gdklsf.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100;
                          -- ���ݲ�ͬ�Ĺ����û����ͣ������Ӧ��Ӷ��
                          IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (1 - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_BRANCH / 100);
                          ELSIF(userType = 4) THEN
                            -- �ɶ�
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_STOCKHOLDER / 100);
                          ELSIF(userType = 5) THEN
                            -- �ܴ���
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_GEN_AGENT / 100);
                          END IF;

                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_gdklsf.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_gdklsf.WIN_AMOUNT;
                          memberAmount_temp := member_pos_gdklsf.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_gdklsf.MONEY;
                          memberAmount_temp := - member_pos_gdklsf.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_gdklsf.RATE_CHIEF + member_pos_gdklsf.RATE_BRANCH + member_pos_gdklsf.RATE_GEN_AGENT + member_pos_gdklsf.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_gdklsf.RATE_STOCKHOLDER/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);

                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * member_pos_gdklsf.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * member_pos_gdklsf.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * member_pos_gdklsf.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 - member_pos_gdklsf.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_gdklsf.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_gdklsf.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_gdklsf.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_gdklsf.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_gdklsf.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_gdklsf.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_gdklsf.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_gdklsf.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_gdklsf.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- �ܼ�
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- �ֹ�˾
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- �ɶ�
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- �ܴ���
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_gdklsf;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ������ֱ����Ա��Ӧ���ϼ�ʵռ���ֵ
              IF (userType = 2) THEN
                -- �ܼ�
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- �ֹ�˾
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- �ɶ�
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- �ܴ���
                realResult := rateGenAgent;
              END IF;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** �㶫����ʮ�� ���� ********/

              /******** ����ʱʱ�� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'CQSSC' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_cqssc := 'SELECT * FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_cqssc := sql_cqssc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_cqssc
              FOR
              sql_cqssc;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_cqssc;
              turnover_total := turnover_total + turnover_cqssc;

              BEGIN
                   LOOP
                   FETCH cursor_his_cqssc INTO member_pos_cqssc;
                       -- ���������˳�
                       IF (cursor_his_cqssc%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_cqssc.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_cqssc.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100;
                          IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWater := winBackWater + (member_pos_cqssc.MONEY * (0 - member_pos_cqssc.COMMISSION_MEMBER) / 100) * (1 - member_pos_cqssc.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWater := winBackWater + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100) * (1 - member_pos_cqssc.RATE_AGENT / 100);
                          END IF;
                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_cqssc.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_cqssc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_cqssc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_cqssc.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_cqssc.MONEY;
                          memberAmount_temp := - member_pos_cqssc.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_cqssc.RATE_CHIEF + member_pos_cqssc.RATE_BRANCH + member_pos_cqssc.RATE_GEN_AGENT + member_pos_cqssc.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_cqssc.RATE_STOCKHOLDER/100 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * member_pos_cqssc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * member_pos_cqssc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * member_pos_cqssc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * member_pos_cqssc.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100 - member_pos_cqssc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_cqssc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_cqssc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_cqssc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_cqssc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_cqssc.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_cqssc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_cqssc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_cqssc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_cqssc.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- �ܼ�
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- �ֹ�˾
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- �ɶ�
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- �ܴ���
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_cqssc;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ������ֱ����Ա��Ӧ���ϼ�ʵռ���ֵ
              IF (userType = 2) THEN
                -- �ܼ�
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- �ֹ�˾
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- �ɶ�
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- �ܴ���
                realResult := rateGenAgent;
              END IF;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** ����ʱʱ�� ���� ********/

              /******** ������ϲ� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'HKLHC' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_hklhc := 'SELECT * FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_hklhc := sql_hklhc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_hklhc
              FOR
              sql_hklhc;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_hklhc;
              turnover_total := turnover_total + turnover_hklhc;

              BEGIN
                   LOOP
                   FETCH cursor_his_hklhc INTO member_pos_hklhc;

                       -- ���������˳�
                       IF (cursor_his_hklhc%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_hklhc.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_hklhc.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100;

                          IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWater := winBackWater + (member_pos_hklhc.MONEY * (0 - member_pos_hklhc.COMMISSION_MEMBER) / 100) * (1 - member_pos_hklhc.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWater := winBackWater + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100) * (1 - member_pos_hklhc.RATE_AGENT / 100);
                          END IF;

                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_hklhc.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_hklhc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_hklhc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_hklhc.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_hklhc.MONEY;
                          memberAmount_temp := - member_pos_hklhc.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                       -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_hklhc.RATE_CHIEF + member_pos_hklhc.RATE_BRANCH + member_pos_hklhc.RATE_GEN_AGENT + member_pos_hklhc.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_hklhc.RATE_STOCKHOLDER/100 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * member_pos_hklhc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * member_pos_hklhc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * member_pos_hklhc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * member_pos_hklhc.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100 - member_pos_hklhc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_hklhc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_hklhc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_hklhc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_hklhc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_hklhc.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_hklhc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_hklhc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_hklhc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_hklhc.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- �ܼ�
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- �ֹ�˾
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- �ɶ�
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- �ܴ���
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_hklhc;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ������ֱ����Ա��Ӧ���ϼ�ʵռ���ֵ
              IF (userType = 2) THEN
                -- �ܼ�
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- �ֹ�˾
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- �ɶ�
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- �ܴ���
                realResult := rateGenAgent;
              END IF;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** ������ϲ� ���� ********/


              /******** �������� ��ʼ ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'BJSC' THEN

              -- 3.3 ��Ͷע��ʷ���в�ѯ��Ӧ��Ա��Ͷע��Ϣ����
              -- �����ѯ���
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_bjsc := 'SELECT * FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_bjsc := sql_bjsc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- ִ�в�ѯ�����α�
              OPEN cursor_his_bjsc
              FOR
              sql_bjsc;

              -- ͳ��Ͷע����
              execute immediate sql_str into turnover_bjsc;
              turnover_total := turnover_total + turnover_bjsc;

              BEGIN
                   LOOP
                   FETCH cursor_his_bjsc INTO member_pos_bjsc;
                       -- ���������˳�
                       IF (cursor_his_bjsc%found = false) THEN
                           EXIT;
                       END IF;
                       -- �ۼ�Ͷע�ܶ�
                       amount := amount + member_pos_bjsc.MONEY;

                       -- �ۼ�Ͷע�������������룬�ʲ����ڴ˴��ۼ�Ͷע������
                       -- turnover := turnover + 1;

                       -- �ۼӼ�¼��Ŀ
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- ��Ч��׬ȡ��ˮ
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          -- ͳ��״̬Ϊ���н�������δ�н�����Ͷע��
                          -- ��Ч���
                          validAmount := validAmount + member_pos_bjsc.MONEY;
                          -- ׬ȡ��ˮ��Ӷ��(��������)*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater_temp := member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100;
                          -- ���ݲ�ͬ�Ĺ����û����ͣ������Ӧ��Ӷ��
                          IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (1 - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_BRANCH / 100);
                          ELSIF(userType = 4) THEN
                            -- �ɶ�
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_STOCKHOLDER / 100);
                          ELSIF(userType = 5) THEN
                            -- �ܴ���
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_GEN_AGENT / 100);
                          END IF;

                          -- ��Ա��ˮ����Ա�����Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- ��Ա��Ӯ����Ӧ�û�Ա������Ӯ���ܺ�(������ˮ)
                       IF (member_pos_bjsc.WIN_STATE = 1) THEN
                          -- �ۼӡ��н�����Ͷע��
                          memberAmount := memberAmount + member_pos_bjsc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_bjsc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_bjsc.WIN_STATE = 2) THEN
                          -- ��ȥ��δ�н�����Ͷע��
                          memberAmount := memberAmount - member_pos_bjsc.MONEY;
                          memberAmount_temp := - member_pos_bjsc.MONEY;
                       END IF;

                       -- Ӧ���ϼ�����ָ��Ա��Ӯ+��Ա��ˮ+׬ȡ��ˮ(ʵ�ʾ���ˮ��)��*�ϼ�ռ�ĳ���*��-1����
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- �ۻ��ϼ���ռ��
                       --            * ((member_pos_bjsc.RATE_CHIEF + member_pos_bjsc.RATE_BRANCH + member_pos_bjsc.RATE_GEN_AGENT + member_pos_bjsc.RATE_STOCKHOLDER)/100));

                       -- ������������Ӧ�ļ�����Ӷ��ռ��
                       -- ����򲻼���Ӷ����ˮ��
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- ׬ȡӶ��
                          winCommissionBranch := winCommissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_bjsc.RATE_STOCKHOLDER/100 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- ʵռ�����ָ��Ա��Ӯ + ��Ա��ˮ��*ռ��%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * member_pos_bjsc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * member_pos_bjsc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * member_pos_bjsc.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * member_pos_bjsc.RATE_AGENT/100;

                          -- ʵռע���Ч��Ͷע��� * ռ��%��
                          moneyRateChief := moneyRateChief + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_AGENT / 100);

                          -- ����Ӧ������
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100 - member_pos_bjsc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief��'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- ׬ˮ������ʵռ���������ʵռ����׬ȡ��ˮ��
                       IF (userType = 2) THEN
                            -- �ܼ�
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- �ֹ�˾
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_bjsc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_bjsc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_bjsc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_bjsc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_bjsc.RATE_AGENT;

                       -- ��ˮ����ֵ
                       commissionBranchSet := member_pos_bjsc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_bjsc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_bjsc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_bjsc.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- �ܼ�
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- �ֹ�˾
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- �ɶ�
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- �ܴ���
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_bjsc;
              END;

              -- Ӧ�����ߣ�ָ��Ӧ�û�Ա������Ӯ���ܺ�+��ˮ�ܺ�(�;ֲ�����ˮ)
              subordinateAmount := memberAmount + memberBackWater;

              -- ʵռ�������Ա��ˮ����*ռ��%���˴�����ֱ������ֱ����Ա��Ӧ���ϼ�ʵռ���ֵ
              IF (userType = 2) THEN
                -- �ܼ�
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- �ֹ�˾
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- �ɶ�
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- �ܴ���
                realResult := rateGenAgent;
              END IF;

              -- Ӧ���ϼ���Ӧ�����ߣ�׬ˮ������
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** �������� ���� ********/

              -- ����ռ������ֵ��ƽ��ֵ
              IF (recNum > 0) THEN
                 rateChiefSet := rateChiefSet / recNum;
                 rateBranchSet := rateBranchSet / recNum;
                 rateStockholderSet := rateStockholderSet / recNum;
                 rateGenAgentSet := rateGenAgentSet / recNum;
                 rateAgentSet := rateAgentSet / recNum;

                 IF (userType = 2) THEN
                    -- �ܼ�
                    rate := rateChiefSet;
                 ELSIF(userType = 3) THEN
                    -- �ֹ�˾
                    rate := rateBranchSet;
                 ELSIF(userType = 4) THEN
                    -- �ɶ�
                    rate := rateStockholderSet;
                 ELSIF(userType = 5) THEN
                    -- �ܴ���
                    rate := rateGenAgentSet;
                 END IF;
                 -- �ۼ���ЧͶע��Ա��
                 recNum_total := recNum_total + 1;
                 -- �ۼ�ռ������ֵ����ֵ
                 --rate_total := rate_total + rate;
                 --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                 --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                 --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                 --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                 --rateAgentSet_total := rateAgentSet_total + rateAgentSet;
              END IF;

              -- 5. �ۼ��ܶ�
              amount_total := amount_total + amount;
              validAmount_total := validAmount_total + validAmount;
              memberAmount_total := memberAmount_total + memberAmount;
              memberBackWater_total := memberBackWater_total + memberBackWater;
              subordinateAmount_total := subordinateAmount_total + subordinateAmount;
              winBackWater_total := winBackWater_total + winBackWater;
              realResult_total := realResult_total + realResult;
              winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
              paySuperior_total := paySuperior_total + paySuperior;

              -- 6. �ۻ���������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
              commissionBranch_total := commissionBranch_total + commissionBranch;
              commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
              commissionStockholder_total := commissionStockholder_total + commissionStockholder;
              commissionAgent_total := commissionAgent_total + commissionAgent;
              commissionMember_total := commissionMember_total + commissionMember;

              -- ׬ȡ��ˮ
              winCommissionBranch_total := winCommissionBranch_total + winCommissionBranch;
              winCommissionGenAgent_total := winCommissionGenAgent_total + winCommissionGenAgent;
              winCommissionStockholder_total := winCommissionStockholder_total + winCommissionStockholder;
              winCommissionAgent_total := winCommissionAgent_total + winCommissionAgent;
              winCommissionMember_total := winCommissionMember_total + winCommissionMember;

              rateChief_total := rateChief_total + rateChief;
              rateBranch_total := rateBranch_total + rateBranch;
              rateGenAgent_total := rateGenAgent_total + rateGenAgent;
              rateStockholder_total := rateStockholder_total + rateStockholder;
              rateAgent_total := rateAgent_total + rateAgent;

              -- ʵռע��
              moneyRateChief_total := moneyRateChief_total + moneyRateChief;
              moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
              moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
              moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
              moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

              subordinateChief_total := subordinateChief_total + subordinateChief;
              subordinateBranch_total := subordinateBranch_total + subordinateBranch;
              subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
              subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
              subordinateAgent_total := subordinateAgent_total + subordinateAgent;

              -- ����ɽ���������0���򱣴�����
              IF ((turnover_gdklsf + turnover_cqssc + turnover_hklhc + turnover_bjsc) > 0) THEN

                 -- 7. ���ݲ�����ʱ��
                 INSERT INTO TEMP_DELIVERYREPORT
                        (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
                        COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT, RATE, RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
                        COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
                        MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
                 VALUES
                        (userID, subID, '9', '0', subordinate, userName, (turnover_gdklsf + turnover_cqssc + turnover_hklhc + turnover_bjsc), amount, validAmount, memberAmount, memberBackWater, subordinateAmount, winBackWater, realResult, winBackWaterResult, paySuperior,
                        commissionBranch, commissionGenAgent, commissionStockholder, commissionAgent, commissionMember, winCommissionBranch, winCommissionGenAgent, winCommissionStockholder, winCommissionAgent, winCommissionMember, rateChief, rateBranch, rateGenAgent, rateStockholder, rateAgent, subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent, rate, rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
                        commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
                        moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent);
              END IF;

          END LOOP;
      END;

      -- 6.1 ���ݲ����ڣ��ɽ�����Ϊ0���򷵻�
      IF (turnover_total < 1) THEN
         resultFlag := 2; -- ���ý��
         return;
      END IF;
      -- dbms_output.put_line('rateAgent_total��'||rateAgent_total);

      -- ����ռ������ֵ��ƽ��ֵ
      --IF (recNum_total > 0) THEN
         --rate_total := rate_total / recNum_total;
         --rateChiefSet_total := rateChiefSet_total / recNum_total;
         --rateBranchSet_total := rateBranchSet_total / recNum_total;
         --rateStockholderSet_total := rateStockholderSet_total / recNum_total;
         --rateGenAgentSet_total := rateGenAgentSet_total / recNum_total;
         --rateAgentSet_total := rateAgentSet_total / recNum_total;
      --END IF;

      -- 6.3 �ܶ����ݲ�����ʱ��USER_TYPE����Ϊ Z��
      IF (turnover_total > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT, RATE, RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
        VALUES
            (userID, userID, 'Z', '0', '', 'ֱ����Ա�ϼƣ�', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total, rate, rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;

      -- 7. ����ʱ���в�ѯ����
      --OPEN statReportAgent
      --FOR
      --SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 8. ���ý�����ɹ�������������
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_GEN_AGENT
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Gen_Agent(
/*==============================================================*/
/*                  �ܴ����ձ���洢����                      */
/*==============================================================*/
     userID IN varchar2,                -- ����ID
     LOTTERY1688Type IN varchar2,           -- ��Ʊ����
     playType IN varchar2,              -- ��ע����
     periodsNum IN varchar2,            -- ����
     startDate IN varchar2,             -- ��ʼʱ��
     endDate IN varchar2,               -- ����ʱ��
     resultFlag OUT varchar2,           -- �洢ִ�н��ֵ��0-�ɹ���1-userIDΪ�գ�2-����Ϊ��; 9-δ֪����
     statReportAgent OUT statReportResult.resultRef         -- ���ؽ����
) AS
     subordinate varchar2(50);          -- �¼���½�˺�
     userName varchar2(50);             -- �û�����
     turnover NUMBER;                   -- �ɽ�����
     amount NUMBER;                     -- Ͷע�ܶ�
     validAmount NUMBER;                -- ��Ч���
     memberAmount NUMBER;               -- ��Ա��Ӯ
     memberBackWater NUMBER;            -- ��Ա��ˮ
     subordinateAmount NUMBER;          -- Ӧ������
     winBackWater NUMBER;               -- ׬ȡ��ˮ
     realResult NUMBER;                 -- ʵռ���
     winBackWaterResult NUMBER;         -- ׬ˮ����
     paySuperior NUMBER;                -- Ӧ���ϼ�
     subID NUMBER;                      -- ��¼ID
     memberAmount_temp NUMBER;          -- ��ʱ�������洢��Ա��Ӯ����
     memberBackWater_temp NUMBER;       -- ��ʱ��������Ա��ˮ
     recNum NUMBER;                     -- ��ʱ��������¼��

     -- �����α�
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     gdklsf_his_cursor  mycursor;
     member_pos TB_GDKLSF_HIS%rowtype;

     sql_replenish varchar2(2000);              -- ������ѯ sql
     cursor_replenish mycursor;                 -- �����α�
     member_pos_replenish TB_REPLENISH%rowtype; -- �������ݶ���
     turnover_replenish NUMBER;                 -- ��������
     amount_replenish NUMBER;                   -- ����Ͷע�ܶ�
     validAmount_replenish NUMBER;              -- ������Ч���
     amount_win_replenish NUMBER;               -- ������Ӯ
     backWater_replenish NUMBER;                -- ������ˮ
     backWaterResult_replenish NUMBER;          -- ��ˮ����
     backWater_replenish_temp NUMBER;           -- ������ˮ����ʱ��
     amount_win_replenish_temp NUMBER;          -- ������Ӯ����ʱ��

     -- �ܶ�ͳ��ֵ
     turnover_total NUMBER;             -- �ɽ��������ܶ
     amount_total NUMBER;               -- Ͷע�ܶ�ܶ
     validAmount_total NUMBER;          -- ��Ч���ܶ
     memberAmount_total NUMBER;         -- ��Ա��Ӯ���ܶ
     memberBackWater_total NUMBER;      -- ��Ա��ˮ���ܶ
     subordinateAmount_total NUMBER;    -- Ӧ�����ߣ��ܶ
     winBackWater_total NUMBER;         -- ׬ȡ��ˮ���ܶ
     realResult_total NUMBER;           -- ʵռ������ܶ
     winBackWaterResult_total NUMBER;   -- ׬ˮ�������ܶ
     paySuperior_total NUMBER;          -- Ӧ���ϼ����ܶ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ��
     commissionBranch NUMBER;           -- �ֹ�˾Ӷ��
     commissionGenAgent NUMBER;         -- �ܴ���Ӷ��
     commissionStockholder NUMBER;      -- �ɶ�Ӷ��
     commissionAgent NUMBER;            -- ����Ӷ��
     commissionMember NUMBER;           -- ��ԱӶ��

     -- ׬ȡӶ��
     winCommissionBranch NUMBER;           -- �ֹ�˾׬ȡӶ��
     winCommissionGenAgent NUMBER;         -- �ܴ���׬ȡӶ��
     winCommissionStockholder NUMBER;      -- �ɶ�׬ȡӶ��
     winCommissionAgent NUMBER;            -- ����׬ȡӶ��
     winCommissionMember NUMBER;           -- ��Ա׬ȡӶ��

     rateChief NUMBER;                  -- �ܼ�ռ��
     rateBranch NUMBER;                 -- �ֹ�˾ռ��
     rateGenAgent NUMBER;               -- �ܴ���ռ��
     rateStockholder NUMBER;            -- �ɶ�ռ��
     rateAgent NUMBER;                  -- ����ռ��

     moneyRateChief NUMBER;             -- �ܼ�ʵռע��
     moneyRateBranch NUMBER;            -- �ֹ�˾ʵռע��
     moneyRateGenAgent NUMBER;          -- �ܴ���ʵռע��
     moneyRateStockholder NUMBER;       -- �ɶ�ʵռע��
     moneyRateAgent NUMBER;             -- ����ʵռע��

     subordinateChief NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent NUMBER;           -- ����Ӧ�գ�����

     rate NUMBER;                       -- ռ������ֵ
     rateChiefSet NUMBER;               -- �ܼ�ռ������ֵ
     rateBranchSet NUMBER;              -- �ֹ�˾ռ������ֵ
     rateStockholderSet NUMBER;         -- �ɶ�ռ������ֵ
     rateGenAgentSet NUMBER;            -- �ܴ���ռ������ֵ
     rateAgentSet NUMBER;               -- ����ռ������ֵ

     commissionBranchSet NUMBER;        -- �ֹ�˾��ˮ����ֵ
     commissionStockholderSet NUMBER;   -- �ɶ���ˮ����ֵ
     commissionGenAgentSet NUMBER;      -- �ܴ�����ˮ����ֵ
     commissionAgentSet NUMBER;         -- ������ˮ����ֵ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ�գ��ܶ
     commissionBranch_total NUMBER;           -- �ֹ�˾Ӷ���ܶ
     commissionGenAgent_total NUMBER;         -- �ܴ���Ӷ���ܶ
     commissionStockholder_total NUMBER;      -- �ɶ�Ӷ���ܶ
     commissionAgent_total NUMBER;            -- ����Ӷ���ܶ
     commissionMember_total NUMBER;           -- ��ԱӶ���ܶ

     -- ׬ȡӶ��
     winCommissionBranch_total NUMBER;           -- �ֹ�˾׬ȡӶ���ܶ
     winCommissionGenAgent_total NUMBER;         -- �ܴ���׬ȡӶ���ܶ
     winCommissionStockholder_total NUMBER;      -- �ɶ�׬ȡӶ���ܶ
     winCommissionAgent_total NUMBER;            -- ����׬ȡӶ���ܶ
     winCommissionMember_total NUMBER;           -- ��Ա׬ȡӶ���ܶ

     rateChief_total NUMBER;                  -- �ܼ�ռ�ɣ��ܶ
     rateBranch_total NUMBER;                 -- �ֹ�˾ռ�ɣ��ܶ
     rateGenAgent_total NUMBER;               -- �ܴ���ռ�ɣ��ܶ
     rateStockholder_total NUMBER;            -- �ɶ�ռ�ɣ��ܶ
     rateAgent_total NUMBER;                  -- ����ռ�ɣ��ܶ

     moneyRateChief_total NUMBER;                  -- �ܼ�ʵռע��ܶ
     moneyRateBranch_total NUMBER;                 -- �ֹ�˾ʵռע��ܶ
     moneyRateGenAgent_total NUMBER;               -- �ܴ���ʵռע��ܶ
     moneyRateStockholder_total NUMBER;            -- �ɶ�ʵռע��ܶ
     moneyRateAgent_total NUMBER;                  -- ����ʵռע��ܶ

     subordinateChief_total NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch_total NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder_total NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent_total NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent_total NUMBER;           -- ����Ӧ�գ�����

     -- ռ������ֵֻȡ���һ��ֵ�����ܺ�ֵ��Ч
     recNum_total NUMBER;                     -- ��ʱ��������Ч��Ա��
     --rate_total NUMBER;                       -- ռ������ֵ���ܺͣ�
     --rateChiefSet_total NUMBER;               -- �ܼ�ռ������ֵ���ܺͣ�
     --rateBranchSet_total NUMBER;              -- �ֹ�˾ռ������ֵ���ܺͣ�
     --rateStockholderSet_total NUMBER;         -- �ɶ�ռ������ֵ���ܺͣ�
     --rateGenAgentSet_total NUMBER;            -- �ܴ���ռ������ֵ���ܺͣ�
     --rateAgentSet_total NUMBER;               -- ����ռ������ֵ���ܺͣ�
BEGIN
     -- ��ʼ�����ؽ��ֵ
     resultFlag := 0;

     -- 1.1 У���������
     dbms_output.put_line('userID��'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 ��ʼ���ܶ�
     turnover_total := 0;
     amount_total := 0;
     validAmount_total := 0;
     memberAmount_total := 0;
     memberBackWater_total := 0;
     subordinateAmount_total := 0;
     winBackWater_total := 0;
     realResult_total := 0;
     winBackWaterResult_total := 0;
     paySuperior_total := 0;

     commissionBranch_total := 0;
     commissionGenAgent_total := 0;
     commissionStockholder_total := 0;
     commissionAgent_total := 0;
     commissionMember_total := 0;

     winCommissionBranch_total := 0;
     winCommissionGenAgent_total := 0;
     winCommissionStockholder_total := 0;
     winCommissionAgent_total := 0;
     winCommissionMember_total := 0;

     rateChief_total := 0;
     rateBranch_total := 0;
     rateGenAgent_total := 0;
     rateStockholder_total := 0;
     rateAgent_total := 0;

     moneyRateChief_total := 0;
     moneyRateBranch_total := 0;
     moneyRateGenAgent_total := 0;
     moneyRateStockholder_total := 0;
     moneyRateAgent_total := 0;

     subordinateChief_total := 0;
     subordinateBranch_total := 0;
     subordinateStockholder_total := 0;
     subordinateGenAgent_total := 0;
     subordinateAgent_total := 0;

     -- ��ʼ��ռ������ֵ�������
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 ɾ����ʱ���е�����
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 ��ѯ�ܴ����Ӧ�Ĵ�����Ϣ
     declare
     cursor agent_cursor
     IS
     SELECT * FROM
         (TB_AGENT_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 ѭ���������еĴ�����Ϣ
          FOR agent_pos IN agent_cursor LOOP
              -- 2.1.2 ������ݼ�¼
              subordinate := agent_pos.ACCOUNT;             -- �¼���½�˺�
              userName := agent_pos.CHS_NAME;               -- �û�����
              subID := agent_pos.ID;                        -- ��¼ID
              -- 2.1.3 ��ʼ������
              turnover := 0;                  -- �ɽ�����
              amount := 0;                    -- Ͷע�ܶ�
              validAmount := 0;               -- ��Ч���
              memberAmount := 0;              -- ��Ա��Ӯ
              subordinateAmount := 0;         -- Ӧ������
              memberBackWater := 0;           -- ��Ա��ˮ
              winBackWater := 0;              -- ׬ȡ��ˮ
              realResult := 0;                -- ʵռ���
              winBackWaterResult := 0;        -- ׬ˮ����
              paySuperior := 0;               -- Ӧ���ϼ�
              rate := 0;                      -- ռ��
              recNum := 0;

              -- 3.3 ��ʼ���洢��������Ӧ�ļ�����Ӷ��ռ�ɡ��¼�Ӧ��
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- ׬ȡ��ˮ
              winCommissionBranch := 0;
              winCommissionGenAgent := 0;
              winCommissionStockholder := 0;
              winCommissionAgent := 0;
              winCommissionMember := 0;

              rateChief := 0;
              rateBranch := 0;
              rateGenAgent := 0;
              rateStockholder := 0;
              rateAgent := 0;

              moneyRateChief := 0;
              moneyRateBranch := 0;
              moneyRateGenAgent := 0;
              moneyRateStockholder := 0;
              moneyRateAgent := 0;

              subordinateChief := 0;
              subordinateBranch := 0;
              subordinateStockholder := 0;
              subordinateGenAgent := 0;
              subordinateAgent := 0;
              rate := 0;
              rateChiefSet := 0;
              rateBranchSet := 0;
              rateStockholderSet := 0;
              rateGenAgentSet := 0;
              rateAgentSet := 0;

              commissionBranchSet := 0;
              commissionStockholderSet := 0;
              commissionGenAgentSet := 0;
              commissionAgentSet := 0;

              -- 2.1.4 ���ô����ձ���洢����
              Delivery_Report_Agent(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportAgent);
              -- ��ȡ�����ձ���洢�������γɵ�����
              declare
              cursor report_Agent_cursor
              IS
              -- ���˵������Ӧ�Ĳ�����Ϣ
              -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = agent_pos.ID AND t.USER_TYPE NOT IN ('g');

              BEGIN
              FOR report_Agent_pos IN report_Agent_cursor LOOP

                  -- ��Ա��ˮ
                  memberBackWater := report_Agent_pos.COMMISSION_AGENT + report_Agent_pos.COMMISSION_MEMBER;
                  -- Ӧ�����ߣ�ֱ�Ӷ�ȡ����������ı���������ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  -- subordinateAmount := report_Agent_pos.RATE_CHIEF + report_Agent_pos.RATE_BRANCH + report_Agent_pos.RATE_STOCKHOLDER + report_Agent_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_Agent_pos.SUBORDINATE_GEN_AGENT;
                  -- ʵռ�����ֱ�Ӷ�ȡ����������Ĵ���ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  realResult := report_Agent_pos.RATE_GEN_AGENT;
                  -- ׬ȡ��ˮ����Ҫȷ�ϣ�������Ҫ��ȥ�������ˮֵ��
                  winBackWater := report_Agent_pos.WIN_COMMISSION_GEN_AGENT;
                  -- ׬ˮ������ʵռ���-׬ȡ��ˮ��
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- Ӧ�����ߣ�Ӧ�����ߣ�׬ˮ������
                  paySuperior := subordinateAmount - winBackWaterResult;

                  -- ʵռע��
                  moneyRateChief := report_Agent_pos.MONEY_RATE_CHIEF;
                  moneyRateBranch := report_Agent_pos.MONEY_RATE_BRANCH;
                  moneyRateGenAgent := report_Agent_pos.MONEY_RATE_GEN_AGENT;
                  moneyRateStockholder := report_Agent_pos.MONEY_RATE_STOCKHOLDER;
                  moneyRateAgent := report_Agent_pos.MONEY_RATE_AGENT;

                  subordinateChief := report_Agent_pos.SUBORDINATE_CHIEF;
                  subordinateBranch := report_Agent_pos.SUBORDINATE_BRANCH;
                  subordinateStockholder := report_Agent_pos.SUBORDINATE_STOCKHOLDER;
                  subordinateGenAgent := report_Agent_pos.SUBORDINATE_GEN_AGENT;
                  subordinateAgent := report_Agent_pos.SUBORDINATE_AGENT;

                  -- ռ������ֵ
                  rateChiefSet := report_Agent_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_Agent_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_Agent_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_Agent_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_Agent_pos.RATE_AGENT_SET;

                  -- ��ˮ����ֵ
                  commissionBranchSet := report_Agent_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_Agent_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_Agent_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_Agent_pos.COMMISSION_AGENT_SET;

                  rate := report_Agent_pos.RATE_GEN_AGENT_SET;
                  -- ��ֵ��TODO �����������������Ͷע����֮ǰ�����Ƿ��������
                  turnover := report_Agent_pos.TURNOVER;          -- �ɽ�����
                  amount := report_Agent_pos.AMOUNT;              -- Ͷע�ܶ�
                  validAmount := report_Agent_pos.VALID_AMOUNT;   -- ��Ч���
                  memberAmount := report_Agent_pos.MEMBER_AMOUNT; -- ��Ա��Ӯ

                  /*
                  -- �ϲ���ͬ�û��Ĳ������ݺ�Ͷע����
                  declare
                  cursor report_Agent_Inner_cursor
                  IS
                  SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = agent_pos.ID AND t.PARENT_ID = userID;
                  BEGIN
                       FOR report_Agent_Inner_pos IN report_Agent_Inner_cursor LOOP
                           turnover := turnover + report_Agent_Inner_pos.TURNOVER;
                           amount := amount + report_Agent_Inner_pos.AMOUNT;
                           validAmount := validAmount + report_Agent_Inner_pos.VALID_AMOUNT;
                           memberAmount := memberAmount + report_Agent_Inner_pos.MEMBER_AMOUNT;
                       END LOOP;
                  END;

                  -- ɾ��֮ǰ��������ݣ���ͬ�û��Ĳ������ݺ�Ͷע���ݺϳ�һ����¼��
                  EXECUTE IMMEDIATE 'DELETE FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = ' || agent_pos.ID || 'AND t.PARENT_ID = ' || userID;
                  */

                  -- 2.1.4.1 ���ݲ�����ʱ��
                  INSERT INTO TEMP_DELIVERYREPORT
                      (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
                      COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT, RATE, RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
                      COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
                      MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
                  VALUES (
                      userID,
                      agent_pos.ID,
                      '6',
                      agent_pos.ACCOUNT,
                      agent_pos.CHS_NAME,
                      turnover,
                      amount,
                      validAmount,
                      memberAmount,
                      memberBackWater,
                      subordinateAmount,
                      winBackWater,
                      realResult,
                      winBackWaterResult,
                      paySuperior,
                      report_Agent_pos.COMMISSION_BRANCH, report_Agent_pos.COMMISSION_GEN_AGENT, report_Agent_pos.COMMISSION_STOCKHOLDER, report_Agent_pos.COMMISSION_AGENT, report_Agent_pos.COMMISSION_MEMBER, report_Agent_pos.WIN_COMMISSION_BRANCH, report_Agent_pos.WIN_COMMISSION_GEN_AGENT, report_Agent_pos.WIN_COMMISSION_STOCKHOLDER, report_Agent_pos.WIN_COMMISSION_AGENT, report_Agent_pos.WIN_COMMISSION_MEMBER, report_Agent_pos.RATE_CHIEF, report_Agent_pos.RATE_BRANCH, report_Agent_pos.RATE_GEN_AGENT, report_Agent_pos.RATE_STOCKHOLDER, report_Agent_pos.RATE_AGENT,
                      subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent,
                      rate, rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
                      commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
                      moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent
                      );

                   -- 2.1.4.2 �ۼ��ܶ�
                   turnover_total := turnover_total + report_Agent_pos.TURNOVER;
                   amount_total := amount_total + report_Agent_pos.AMOUNT;
                   validAmount_total := validAmount_total + report_Agent_pos.VALID_AMOUNT;
                   memberAmount_total := memberAmount_total + report_Agent_pos.MEMBER_AMOUNT;
                   memberBackWater_total := memberBackWater_total + memberBackWater;
                   subordinateAmount_total := subordinateAmount_total + subordinateAmount;
                   winBackWater_total := winBackWater_total + winBackWater;
                   realResult_total := realResult_total + realResult;
                   winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
                   paySuperior_total := paySuperior_total + paySuperior;

                   -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
                   commissionBranch_total := commissionBranch_total + report_Agent_pos.COMMISSION_BRANCH;
                   commissionGenAgent_total := commissionGenAgent_total + report_Agent_pos.COMMISSION_GEN_AGENT;
                   commissionStockholder_total := commissionStockholder_total + report_Agent_pos.COMMISSION_STOCKHOLDER;
                   commissionAgent_total := commissionAgent_total + report_Agent_pos.COMMISSION_AGENT;
                   commissionMember_total := commissionMember_total + report_Agent_pos.COMMISSION_MEMBER;

                   winCommissionBranch_total := winCommissionBranch_total + report_Agent_pos.WIN_COMMISSION_BRANCH;
                   winCommissionGenAgent_total := winCommissionGenAgent_total + report_Agent_pos.WIN_COMMISSION_GEN_AGENT;
                   winCommissionStockholder_total := winCommissionStockholder_total + report_Agent_pos.WIN_COMMISSION_STOCKHOLDER;
                   winCommissionAgent_total := winCommissionAgent_total + report_Agent_pos.WIN_COMMISSION_AGENT;
                   winCommissionMember_total := winCommissionMember_total + report_Agent_pos.WIN_COMMISSION_MEMBER;

                   rateChief_total := rateChief_total + report_Agent_pos.RATE_CHIEF;
                   rateBranch_total := rateBranch_total + report_Agent_pos.RATE_BRANCH;
                   rateGenAgent_total := rateGenAgent_total + report_Agent_pos.RATE_GEN_AGENT;
                   rateStockholder_total := rateStockholder_total + report_Agent_pos.RATE_STOCKHOLDER;
                   rateAgent_total := rateAgent_total + report_Agent_pos.RATE_AGENT;

                   moneyRateChief_total := moneyRateChief_total + report_Agent_pos.MONEY_RATE_CHIEF;
                   moneyRateBranch_total := moneyRateBranch_total + report_Agent_pos.MONEY_RATE_BRANCH;
                   moneyRateGenAgent_total := moneyRateGenAgent_total + report_Agent_pos.MONEY_RATE_GEN_AGENT;
                   moneyRateStockholder_total := moneyRateStockholder_total + report_Agent_pos.MONEY_RATE_STOCKHOLDER;
                   moneyRateAgent_total := moneyRateAgent_total + report_Agent_pos.MONEY_RATE_AGENT;

                   -- ʵռע��
                   moneyRateChief_total := moneyRateChief_total + moneyRateChief;
                   moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
                   moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
                   moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
                   moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

                   subordinateChief_total := subordinateChief_total + subordinateChief;
                   subordinateBranch_total := subordinateBranch_total + subordinateBranch;
                   subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
                   subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
                   subordinateAgent_total := subordinateAgent_total + subordinateAgent;

                   -- ռ������ֵ
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 ɾ����Ч��ʱ����
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = agent_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** �ܴ����Ӧ��ֱ����Ա���� ��ʼ ********/
      -- ����ֱ����Ա���ձ���洢����
      Delivery_Report_Dir_Member(userID, '5', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- ��ѯֱ����Աͳ������
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- �ۼ�ֱ����Աͳ������
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 �ۼ��ܶ�
               turnover_total := turnover_total + dir_total_pos.TURNOVER;
               amount_total := amount_total + dir_total_pos.AMOUNT;
               validAmount_total := validAmount_total + dir_total_pos.VALID_AMOUNT;
               memberAmount_total := memberAmount_total + dir_total_pos.MEMBER_AMOUNT;
               memberBackWater_total := memberBackWater_total + dir_total_pos.MEMBER_BACK_WATER;
               subordinateAmount_total := subordinateAmount_total + dir_total_pos.SUBORDINATE_AMOUNT;
               winBackWater_total := winBackWater_total + dir_total_pos.WIN_BACK_WATER;
               realResult_total := realResult_total + dir_total_pos.REAL_RESULT;
               winBackWaterResult_total := winBackWaterResult_total + dir_total_pos.WIN_BACK_WATER_RESULT;
               paySuperior_total := paySuperior_total + dir_total_pos.PAY_SUPERIOR;

               -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
               commissionBranch_total := commissionBranch_total + dir_total_pos.COMMISSION_BRANCH;
               commissionGenAgent_total := commissionGenAgent_total + dir_total_pos.COMMISSION_GEN_AGENT;
               commissionStockholder_total := commissionStockholder_total + dir_total_pos.COMMISSION_STOCKHOLDER;
               commissionAgent_total := commissionAgent_total + dir_total_pos.COMMISSION_AGENT;
               commissionMember_total := commissionMember_total + dir_total_pos.COMMISSION_MEMBER;

               winCommissionBranch_total := winCommissionBranch_total + dir_total_pos.WIN_COMMISSION_BRANCH;
               winCommissionGenAgent_total := winCommissionGenAgent_total + dir_total_pos.WIN_COMMISSION_GEN_AGENT;
               winCommissionStockholder_total := winCommissionStockholder_total + dir_total_pos.WIN_COMMISSION_STOCKHOLDER;
               winCommissionAgent_total := winCommissionAgent_total + dir_total_pos.WIN_COMMISSION_AGENT;
               winCommissionMember_total := winCommissionMember_total + dir_total_pos.WIN_COMMISSION_MEMBER;

               rateChief_total := rateChief_total + dir_total_pos.RATE_CHIEF;
               rateBranch_total := rateBranch_total + dir_total_pos.RATE_BRANCH;
               rateGenAgent_total := rateGenAgent_total + dir_total_pos.RATE_GEN_AGENT;
               rateStockholder_total := rateStockholder_total + dir_total_pos.RATE_STOCKHOLDER;
               rateAgent_total := rateAgent_total + dir_total_pos.RATE_AGENT;

               moneyRateChief_total := moneyRateChief_total + dir_total_pos.MONEY_RATE_CHIEF;
               moneyRateBranch_total := moneyRateBranch_total + dir_total_pos.MONEY_RATE_BRANCH;
               moneyRateGenAgent_total := moneyRateGenAgent_total + dir_total_pos.MONEY_RATE_GEN_AGENT;
               moneyRateStockholder_total := moneyRateStockholder_total + dir_total_pos.MONEY_RATE_STOCKHOLDER;
               moneyRateAgent_total := moneyRateAgent_total + dir_total_pos.MONEY_RATE_AGENT;

               -- ʵռע��
               moneyRateChief_total := moneyRateChief_total + dir_total_pos.MONEY_RATE_CHIEF;
               moneyRateBranch_total := moneyRateBranch_total + dir_total_pos.MONEY_RATE_BRANCH;
               moneyRateGenAgent_total := moneyRateGenAgent_total + dir_total_pos.MONEY_RATE_GEN_AGENT;
               moneyRateStockholder_total := moneyRateStockholder_total + dir_total_pos.MONEY_RATE_STOCKHOLDER;
               moneyRateAgent_total := moneyRateAgent_total + dir_total_pos.MONEY_RATE_AGENT;

               subordinateChief_total := subordinateChief_total + dir_total_pos.SUBORDINATE_CHIEF;
               subordinateBranch_total := subordinateBranch_total + dir_total_pos.SUBORDINATE_BRANCH;
               subordinateStockholder_total := subordinateStockholder_total + dir_total_pos.SUBORDINATE_STOCKHOLDER;
               subordinateGenAgent_total := subordinateGenAgent_total + dir_total_pos.SUBORDINATE_GEN_AGENT;
               subordinateAgent_total := subordinateAgent_total + dir_total_pos.SUBORDINATE_AGENT;

               -- ռ������ֵ
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 ɾ����Ч��ʱ����
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;
      /******** �ܴ����Ӧ��ֱ����Ա���� ���� ********/

      /******** �������� ��ʼ ********/
      -- 6.2 ��ѯ�������ݣ�����������Ҫ�����淨���Ͳ�ѯ��
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- ֻ��ѯ�����˵Ĳ�������
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- �жϲ�Ʊ����
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- �㶫
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- ���
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- ����
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- ��ʼ��
      turnover_replenish := 0;                         -- ��������
      amount_replenish := 0;                           -- ����Ͷע�ܶ�
      validAmount_replenish :=0;                       -- ������Ч���
      amount_win_replenish := 0;                       -- ������Ӯ
      backWater_replenish := 0;                        -- ������ˮ
      backWaterResult_replenish := 0;                  -- ��ˮ����
      backWater_replenish_temp := 0;                   -- ������Ӯ����ʱ��
      amount_win_replenish_temp := 0;                  -- ������Ӯ����ʱ��

      -- ��ˮ�������
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- ʵռ���
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- ʵռע��
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- Ӧ������
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- ִ�в�ѯ�����α�
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- ���������˳�
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- �ۼӲ����ܶ�
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- �ۼӲ�������
               turnover_replenish := turnover_replenish + 1;

               -- ������Ӯ����Ӧ�ô������в������ܺ�(������ˮ)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- �ۼӡ��н�����Ͷע��
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- ��ȥ��δ�н�����Ͷע��
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- ������Ч����������
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO ��ˮ��Ҫ��ȫ���м������ˮ��Ϣ
               -- ������ˮ������Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- ����򲻼���Ӷ����ˮ��������ֱ����Ա����
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER) / 100);
                  commissionStockholder := commissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100);
                  commissionGenAgent := commissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - 0) / 100);

                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionStockholder := winCommissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionGenAgent := winCommissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - member_pos_replenish.COMMISSION_AGENT) / 100) * (1 - member_pos_replenish.RATE_AGENT/100);

                  -- ʵռ�������ˮ������Ҳ���� ��ˮ + ��Ӯ��*ռ��%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  rateBranch := rateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * member_pos_replenish.RATE_BRANCH/100;
                  rateStockholder := rateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * member_pos_replenish.RATE_STOCKHOLDER/100;

                  -- ʵռע���Ч��Ͷע��� * ռ��%��
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- ����Ӧ������
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  subordinateBranch := subordinateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100);
                  subordinateStockholder := subordinateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- ������ˮ��������ˮ + ��Ӯ��
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. �������ݲ�����ʱ�������������ͣ������ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + a�������ʵ��ֵΪ1�������ֵ b��ʵ��ֵΪ0�������a��
      -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'f', '1', '����', '����', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. �ۼ��ܶ���Ӳ������ݣ�
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;
      -- commissionAgent_total := commissionAgent_total + backWater_replenish; -- ���Ӵ�������ˮ

      -- 6. �ۻ�������������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
      commissionBranch_total := commissionBranch_total + commissionBranch;
      commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
      commissionStockholder_total := commissionStockholder_total + commissionStockholder;
      commissionAgent_total := commissionAgent_total + commissionAgent;

      winCommissionBranch_total := winCommissionBranch_total + winCommissionBranch;
      winCommissionGenAgent_total := winCommissionGenAgent_total + winCommissionGenAgent;
      winCommissionStockholder_total := winCommissionStockholder_total + winCommissionStockholder;
      winCommissionAgent_total := winCommissionAgent_total + winCommissionAgent;

      rateChief_total := rateChief_total + rateChief;
      rateBranch_total := rateBranch_total + rateBranch;
      rateGenAgent_total := rateGenAgent_total + rateGenAgent;
      rateStockholder_total := rateStockholder_total + rateStockholder;
      rateAgent_total := rateAgent_total + rateAgent;

      -- ʵռע��
      moneyRateChief_total := moneyRateChief_total + moneyRateChief;
      moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
      moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
      moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
      moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

      subordinateChief_total := subordinateChief_total + subordinateChief;
      subordinateBranch_total := subordinateBranch_total + subordinateBranch;
      subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
      subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
      subordinateAgent_total := subordinateAgent_total + subordinateAgent;
      /******** �������� ���� ********/

      -- 4. �ܶ����ݲ�����ʱ��Ϊ���������ܶ����ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + A�������ʵ��ֵΪ1�������ֵ B��
      -- C��2�ܼࣩ��D��3�ֹ�˾����E��4�ɶ�����F��5�ܴ�����G��6������H��7���˺ţ�
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'F', '', '�ϼƣ�', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. ����ʱ���в�ѯ����
      OPEN statReportAgent
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. ���ý�����ɹ�������������
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_STOCKHOLDER
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Stockholder(
/*==============================================================*/
/*                    �ɶ����ձ���洢����                      */
/*==============================================================*/
     userID IN varchar2,                -- ����ID
     LOTTERY1688Type IN varchar2,           -- ��Ʊ����
     playType IN varchar2,              -- ��ע����
     periodsNum IN varchar2,            -- ����
     startDate IN varchar2,             -- ��ʼʱ��
     endDate IN varchar2,               -- ����ʱ��
     resultFlag OUT varchar2,           -- �洢ִ�н��ֵ��0-�ɹ���1-userIDΪ�գ�2-����Ϊ��; 9-δ֪����
     statReportGenAgent OUT statReportResult.resultRef         -- ���ؽ����
) AS
     subordinate varchar2(50);          -- �¼���½�˺�
     userName varchar2(50);             -- �û�����
     turnover NUMBER;                   -- �ɽ�����
     amount NUMBER;                     -- Ͷע�ܶ�
     validAmount NUMBER;                -- ��Ч���
     memberAmount NUMBER;               -- ��Ա��Ӯ
     memberBackWater NUMBER;            -- ��Ա��ˮ
     subordinateAmount NUMBER;          -- Ӧ������
     winBackWater NUMBER;               -- ׬ȡ��ˮ
     realResult NUMBER;                 -- ʵռ���
     winBackWaterResult NUMBER;         -- ׬ˮ����
     paySuperior NUMBER;                -- Ӧ���ϼ�
     subID NUMBER;                      -- ��¼ID
     memberAmount_temp NUMBER;          -- ��ʱ�������洢��Ա��Ӯ����
     memberBackWater_temp NUMBER;       -- ��ʱ��������Ա��ˮ
     recNum NUMBER;                     -- ��ʱ��������¼��

     -- �����α�
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     his_cursor  mycursor;
     member_pos TB_HKLHC_HIS%rowtype;

     sql_replenish varchar2(2000);              -- ������ѯ sql
     cursor_replenish mycursor;                 -- �����α�
     member_pos_replenish TB_REPLENISH%rowtype; -- �������ݶ���
     turnover_replenish NUMBER;                 -- ��������
     amount_replenish NUMBER;                   -- ����Ͷע�ܶ�
     validAmount_replenish NUMBER;              -- ������Ч���
     amount_win_replenish NUMBER;               -- ������Ӯ
     backWater_replenish NUMBER;                -- ������ˮ
     backWaterResult_replenish NUMBER;          -- ��ˮ����
     backWater_replenish_temp NUMBER;           -- ������ˮ����ʱ��
     amount_win_replenish_temp NUMBER;          -- ������Ӯ����ʱ��

     -- �ܶ�ͳ��ֵ
     turnover_total NUMBER;             -- �ɽ��������ܶ
     amount_total NUMBER;               -- Ͷע�ܶ�ܶ
     validAmount_total NUMBER;          -- ��Ч���ܶ
     memberAmount_total NUMBER;         -- ��Ա��Ӯ���ܶ
     memberBackWater_total NUMBER;      -- ��Ա��ˮ���ܶ
     subordinateAmount_total NUMBER;    -- Ӧ�����ߣ��ܶ
     winBackWater_total NUMBER;         -- ׬ȡ��ˮ���ܶ
     realResult_total NUMBER;           -- ʵռ������ܶ
     winBackWaterResult_total NUMBER;   -- ׬ˮ�������ܶ
     paySuperior_total NUMBER;          -- Ӧ���ϼ����ܶ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ��
     commissionBranch NUMBER;           -- �ֹ�˾Ӷ��
     commissionGenAgent NUMBER;         -- �ܴ���Ӷ��
     commissionStockholder NUMBER;      -- �ɶ�Ӷ��
     commissionAgent NUMBER;            -- ����Ӷ��
     commissionMember NUMBER;           -- ��ԱӶ��

     -- ׬ȡӶ��
     winCommissionBranch NUMBER;           -- �ֹ�˾׬ȡӶ��
     winCommissionGenAgent NUMBER;         -- �ܴ���׬ȡӶ��
     winCommissionStockholder NUMBER;      -- �ɶ�׬ȡӶ��
     winCommissionAgent NUMBER;            -- ����׬ȡӶ��
     winCommissionMember NUMBER;           -- ��Ա׬ȡӶ��

     rateChief NUMBER;                  -- �ܼ�ռ��
     rateBranch NUMBER;                 -- �ֹ�˾ռ��
     rateGenAgent NUMBER;               -- �ܴ���ռ��
     rateStockholder NUMBER;            -- �ɶ�ռ��
     rateAgent NUMBER;                  -- ����ռ��

     moneyRateChief NUMBER;             -- �ܼ�ʵռע��
     moneyRateBranch NUMBER;            -- �ֹ�˾ʵռע��
     moneyRateGenAgent NUMBER;          -- �ܴ���ʵռע��
     moneyRateStockholder NUMBER;       -- �ɶ�ʵռע��
     moneyRateAgent NUMBER;             -- ����ʵռע��

     subordinateChief NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent NUMBER;           -- ����Ӧ�գ�����

     rate NUMBER;                       -- ռ������ֵ
     rateChiefSet NUMBER;               -- �ܼ�ռ������ֵ
     rateBranchSet NUMBER;              -- �ֹ�˾ռ������ֵ
     rateStockholderSet NUMBER;         -- �ɶ�ռ������ֵ
     rateGenAgentSet NUMBER;            -- �ܴ���ռ������ֵ
     rateAgentSet NUMBER;               -- ����ռ������ֵ

     commissionBranchSet NUMBER;        -- �ֹ�˾��ˮ����ֵ
     commissionStockholderSet NUMBER;   -- �ɶ���ˮ����ֵ
     commissionGenAgentSet NUMBER;      -- �ܴ�����ˮ����ֵ
     commissionAgentSet NUMBER;         -- ������ˮ����ֵ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ�գ��ܶ
     commissionBranch_total NUMBER;           -- �ֹ�˾Ӷ���ܶ
     commissionGenAgent_total NUMBER;         -- �ܴ���Ӷ���ܶ
     commissionStockholder_total NUMBER;      -- �ɶ�Ӷ���ܶ
     commissionAgent_total NUMBER;            -- ����Ӷ���ܶ
     commissionMember_total NUMBER;           -- ��ԱӶ���ܶ

     -- ׬ȡӶ��
     winCommissionBranch_total NUMBER;           -- �ֹ�˾׬ȡӶ���ܶ
     winCommissionGenAgent_total NUMBER;         -- �ܴ���׬ȡӶ���ܶ
     winCommissionStockholder_total NUMBER;      -- �ɶ�׬ȡӶ���ܶ
     winCommissionAgent_total NUMBER;            -- ����׬ȡӶ���ܶ
     winCommissionMember_total NUMBER;           -- ��Ա׬ȡӶ���ܶ

     rateChief_total NUMBER;                  -- �ܼ�ռ�ɣ��ܶ
     rateBranch_total NUMBER;                 -- �ֹ�˾ռ�ɣ��ܶ
     rateGenAgent_total NUMBER;               -- �ܴ���ռ�ɣ��ܶ
     rateStockholder_total NUMBER;            -- �ɶ�ռ�ɣ��ܶ
     rateAgent_total NUMBER;                  -- ����ռ�ɣ��ܶ

     moneyRateChief_total NUMBER;                  -- �ܼ�ʵռע��ܶ
     moneyRateBranch_total NUMBER;                 -- �ֹ�˾ʵռע��ܶ
     moneyRateGenAgent_total NUMBER;               -- �ܴ���ʵռע��ܶ
     moneyRateStockholder_total NUMBER;            -- �ɶ�ʵռע��ܶ
     moneyRateAgent_total NUMBER;                  -- ����ʵռע��ܶ

     subordinateChief_total NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch_total NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder_total NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent_total NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent_total NUMBER;           -- ����Ӧ�գ�����

     -- ռ������ֵֻȡ���һ��ֵ�����ܺ�ֵ��Ч
     recNum_total NUMBER;                     -- ��ʱ��������Ч��Ա��
     --rate_total NUMBER;                       -- ռ������ֵ���ܺͣ�
     --rateChiefSet_total NUMBER;               -- �ܼ�ռ������ֵ���ܺͣ�
     --rateBranchSet_total NUMBER;              -- �ֹ�˾ռ������ֵ���ܺͣ�
     --rateStockholderSet_total NUMBER;         -- �ɶ�ռ������ֵ���ܺͣ�
     --rateGenAgentSet_total NUMBER;            -- �ܴ���ռ������ֵ���ܺͣ�
     --rateAgentSet_total NUMBER;               -- ����ռ������ֵ���ܺͣ�
BEGIN
     -- ��ʼ�����ؽ��ֵ
     resultFlag := 0;

     -- 1.1 У���������
     dbms_output.put_line('userID��'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 ��ʼ���ܶ�
     turnover_total := 0;
     amount_total := 0;
     validAmount_total := 0;
     memberAmount_total := 0;
     memberBackWater_total := 0;
     subordinateAmount_total := 0;
     winBackWater_total := 0;
     realResult_total := 0;
     winBackWaterResult_total := 0;
     paySuperior_total := 0;

     commissionBranch_total := 0;
     commissionGenAgent_total := 0;
     commissionStockholder_total := 0;
     commissionAgent_total := 0;
     commissionMember_total := 0;

     winCommissionBranch_total := 0;
     winCommissionGenAgent_total := 0;
     winCommissionStockholder_total := 0;
     winCommissionAgent_total := 0;
     winCommissionMember_total := 0;

     rateChief_total := 0;
     rateBranch_total := 0;
     rateGenAgent_total := 0;
     rateStockholder_total := 0;
     rateAgent_total := 0;

     moneyRateChief_total := 0;
     moneyRateBranch_total := 0;
     moneyRateGenAgent_total := 0;
     moneyRateStockholder_total := 0;
     moneyRateAgent_total := 0;

     subordinateChief_total := 0;
     subordinateBranch_total := 0;
     subordinateStockholder_total := 0;
     subordinateGenAgent_total := 0;
     subordinateAgent_total := 0;

     -- ��ʼ��ռ������ֵ�������
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 ɾ����ʱ���е�����
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 ��ѯ�ɶ���Ӧ���ܴ�����Ϣ
     declare
     cursor gen_agent_cursor
     IS
     SELECT * FROM
         (TB_GEN_AGENT_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 ѭ���������е��ܴ�����Ϣ
          FOR gen_agent_pos IN gen_agent_cursor LOOP
              -- 2.1.2 ������ݼ�¼
              subordinate := gen_agent_pos.ACCOUNT;         -- �¼���½�˺�
              userName := gen_agent_pos.CHS_NAME;           -- �û�����
              subID := gen_agent_pos.ID;                    -- ��¼ID
              -- 2.1.3 ��ʼ������
              turnover := 0;                  -- �ɽ�����
              amount := 0;                    -- Ͷע�ܶ�
              validAmount := 0;               -- ��Ч���
              memberAmount := 0;              -- ��Ա��Ӯ
              subordinateAmount := 0;         -- Ӧ������
              memberBackWater := 0;           -- ��Ա��ˮ
              winBackWater := 0;              -- ׬ȡ��ˮ
              realResult := 0;                -- ʵռ���
              winBackWaterResult := 0;        -- ׬ˮ����
              paySuperior := 0;               -- Ӧ���ϼ�
              rate := 0;                      -- ռ��
              recNum := 0;

              -- 3.3 ��ʼ���洢��������Ӧ�ļ�����Ӷ��ռ�ɡ��¼�Ӧ��
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- ׬ȡ��ˮ
              winCommissionBranch := 0;
              winCommissionGenAgent := 0;
              winCommissionStockholder := 0;
              winCommissionAgent := 0;
              winCommissionMember := 0;

              rateChief := 0;
              rateBranch := 0;
              rateGenAgent := 0;
              rateStockholder := 0;
              rateAgent := 0;

              moneyRateChief := 0;
              moneyRateBranch := 0;
              moneyRateGenAgent := 0;
              moneyRateStockholder := 0;
              moneyRateAgent := 0;

              subordinateChief := 0;
              subordinateBranch := 0;
              subordinateStockholder := 0;
              subordinateGenAgent := 0;
              subordinateAgent := 0;
              rate := 0;
              rateChiefSet := 0;
              rateBranchSet := 0;
              rateStockholderSet := 0;
              rateGenAgentSet := 0;
              rateAgentSet := 0;

              commissionBranchSet := 0;
              commissionStockholderSet := 0;
              commissionGenAgentSet := 0;
              commissionAgentSet := 0;

              -- 2.1.4 �����ܴ����ձ���洢����
              Delivery_Report_Gen_Agent(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportGenAgent);
              -- ��ȡ�����ձ���洢�������γɵ�����
              declare
              cursor report_gen_agent_cursor
              IS
              -- ���˵������Ӧ�Ĳ�����Ϣ
              -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = gen_agent_pos.ID AND t.USER_TYPE NOT IN ('g','f');

              BEGIN
              FOR report_gen_agent_pos IN report_gen_agent_cursor LOOP

                  -- ��Ա��ˮ
                  memberBackWater := report_gen_agent_pos.COMMISSION_GEN_AGENT + report_gen_agent_pos.COMMISSION_AGENT + report_gen_agent_pos.COMMISSION_MEMBER;
                  -- Ӧ�����ߣ�ֱ�Ӷ�ȡ����������ı���������ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  -- subordinateAmount := report_gen_agent_pos.RATE_CHIEF + report_gen_agent_pos.RATE_BRANCH + report_gen_agent_pos.RATE_STOCKHOLDER + report_gen_agent_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_gen_agent_pos.SUBORDINATE_STOCKHOLDER;
                  -- ʵռ�����ֱ�Ӷ�ȡ����������Ĺɶ�ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  realResult := report_gen_agent_pos.RATE_STOCKHOLDER;
                  -- ׬ȡ��ˮ
                  winBackWater := report_gen_agent_pos.WIN_COMMISSION_STOCKHOLDER;
                  -- ׬ˮ������ʵռ���-׬ȡ��ˮ��
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- Ӧ�����ߣ�Ӧ�����ߣ�׬ˮ������
                  paySuperior := subordinateAmount - winBackWaterResult;

                  moneyRateChief_total := moneyRateChief_total + report_gen_agent_pos.MONEY_RATE_CHIEF;
                  moneyRateBranch_total := moneyRateBranch_total + report_gen_agent_pos.MONEY_RATE_BRANCH;
                  moneyRateGenAgent_total := moneyRateGenAgent_total + report_gen_agent_pos.MONEY_RATE_GEN_AGENT;
                  moneyRateStockholder_total := moneyRateStockholder_total + report_gen_agent_pos.MONEY_RATE_STOCKHOLDER;
                  moneyRateAgent_total := moneyRateAgent_total + report_gen_agent_pos.MONEY_RATE_AGENT;

                  subordinateChief := report_gen_agent_pos.SUBORDINATE_CHIEF;
                  subordinateBranch := report_gen_agent_pos.SUBORDINATE_BRANCH;
                  subordinateStockholder := report_gen_agent_pos.SUBORDINATE_STOCKHOLDER;
                  subordinateGenAgent := report_gen_agent_pos.SUBORDINATE_GEN_AGENT;
                  subordinateAgent := report_gen_agent_pos.SUBORDINATE_AGENT;

                  -- ռ������ֵ
                  rateChiefSet := report_gen_agent_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_gen_agent_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_gen_agent_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_gen_agent_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_gen_agent_pos.RATE_AGENT_SET;

                  -- ��ˮ����ֵ
                  commissionBranchSet := report_gen_agent_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_gen_agent_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_gen_agent_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_gen_agent_pos.COMMISSION_AGENT_SET;

                  rate := report_gen_agent_pos.RATE_STOCKHOLDER_SET;
                  -- ��ֵ��TODO �����������������Ͷע����֮ǰ�����Ƿ��������
                  turnover := report_gen_agent_pos.TURNOVER;          -- �ɽ�����
                  amount := report_gen_agent_pos.AMOUNT;              -- Ͷע�ܶ�
                  validAmount := report_gen_agent_pos.VALID_AMOUNT;   -- ��Ч���
                  memberAmount := report_gen_agent_pos.MEMBER_AMOUNT; -- ��Ա��Ӯ

                  -- 2.1.4.1 ���ݲ�����ʱ��
                  INSERT INTO TEMP_DELIVERYREPORT
                      (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
                      COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
                      SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
                      RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
                      COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
                      MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
                  VALUES (
                      userID,
                      gen_agent_pos.ID,
                      '5',
                      gen_agent_pos.ACCOUNT,
                      gen_agent_pos.CHS_NAME,
                      turnover,
                      amount,
                      validAmount,
                      memberAmount,
                      memberBackWater,
                      subordinateAmount,
                      winBackWater,
                      realResult,
                      winBackWaterResult,
                      paySuperior,
                      report_gen_agent_pos.COMMISSION_BRANCH, report_gen_agent_pos.COMMISSION_GEN_AGENT, report_gen_agent_pos.COMMISSION_STOCKHOLDER, report_gen_agent_pos.COMMISSION_AGENT, report_gen_agent_pos.COMMISSION_MEMBER, report_gen_agent_pos.WIN_COMMISSION_BRANCH, report_gen_agent_pos.WIN_COMMISSION_GEN_AGENT, report_gen_agent_pos.WIN_COMMISSION_STOCKHOLDER, report_gen_agent_pos.WIN_COMMISSION_AGENT, report_gen_agent_pos.WIN_COMMISSION_MEMBER, report_gen_agent_pos.RATE_CHIEF, report_gen_agent_pos.RATE_BRANCH, report_gen_agent_pos.RATE_GEN_AGENT, report_gen_agent_pos.RATE_STOCKHOLDER, report_gen_agent_pos.RATE_AGENT,
                      rate,
                      subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent,
                      rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
                      commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
                      moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent
                      );

                   -- 2.1.4.2 �ۼ��ܶ�
                   turnover_total := turnover_total + report_gen_agent_pos.TURNOVER;
                   amount_total := amount_total + report_gen_agent_pos.AMOUNT;
                   validAmount_total := validAmount_total + report_gen_agent_pos.VALID_AMOUNT;
                   memberAmount_total := memberAmount_total + report_gen_agent_pos.MEMBER_AMOUNT;
                   memberBackWater_total := memberBackWater_total + memberBackWater;
                   subordinateAmount_total := subordinateAmount_total + subordinateAmount;
                   winBackWater_total := winBackWater_total + winBackWater;
                   realResult_total := realResult_total + realResult;
                   winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
                   paySuperior_total := paySuperior_total + paySuperior;

                   -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
                   commissionBranch_total := commissionBranch_total + report_gen_agent_pos.COMMISSION_BRANCH;
                   commissionGenAgent_total := commissionGenAgent_total + report_gen_agent_pos.COMMISSION_GEN_AGENT;
                   commissionStockholder_total := commissionStockholder_total + report_gen_agent_pos.COMMISSION_STOCKHOLDER;
                   commissionAgent_total := commissionAgent_total + report_gen_agent_pos.COMMISSION_AGENT;
                   commissionMember_total := commissionMember_total + report_gen_agent_pos.COMMISSION_MEMBER;

                   winCommissionBranch_total := winCommissionBranch_total + report_gen_agent_pos.WIN_COMMISSION_BRANCH;
                   winCommissionGenAgent_total := winCommissionGenAgent_total + report_gen_agent_pos.WIN_COMMISSION_GEN_AGENT;
                   winCommissionStockholder_total := winCommissionStockholder_total + report_gen_agent_pos.WIN_COMMISSION_STOCKHOLDER;
                   winCommissionAgent_total := winCommissionAgent_total + report_gen_agent_pos.WIN_COMMISSION_AGENT;
                   winCommissionMember_total := winCommissionMember_total + report_gen_agent_pos.WIN_COMMISSION_MEMBER;

                   rateChief_total := rateChief_total + report_gen_agent_pos.RATE_CHIEF;
                   rateBranch_total := rateBranch_total + report_gen_agent_pos.RATE_BRANCH;
                   rateGenAgent_total := rateGenAgent_total + report_gen_agent_pos.RATE_GEN_AGENT;
                   rateStockholder_total := rateStockholder_total + report_gen_agent_pos.RATE_STOCKHOLDER;
                   rateAgent_total := rateAgent_total + report_gen_agent_pos.RATE_AGENT;

                   -- ʵռע��
                   moneyRateChief_total := moneyRateChief_total + moneyRateChief;
                   moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
                   moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
                   moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
                   moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

                   subordinateChief_total := subordinateChief_total + subordinateChief;
                   subordinateBranch_total := subordinateBranch_total + subordinateBranch;
                   subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
                   subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
                   subordinateAgent_total := subordinateAgent_total + subordinateAgent;

                   -- ռ������ֵ
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 ɾ����Ч��ʱ����
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = gen_agent_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** �ɶ���Ӧ��ֱ����Ա���� ��ʼ ********/
      -- ����ֱ����Ա���ձ���洢����
      Delivery_Report_Dir_Member(userID, '4', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- ��ѯֱ����Աͳ������
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- �ۼ�ֱ����Աͳ������
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 �ۼ��ܶ�
               turnover_total := turnover_total + dir_total_pos.TURNOVER;
               amount_total := amount_total + dir_total_pos.AMOUNT;
               validAmount_total := validAmount_total + dir_total_pos.VALID_AMOUNT;
               memberAmount_total := memberAmount_total + dir_total_pos.MEMBER_AMOUNT;
               memberBackWater_total := memberBackWater_total + dir_total_pos.MEMBER_BACK_WATER;
               subordinateAmount_total := subordinateAmount_total + dir_total_pos.SUBORDINATE_AMOUNT;
               winBackWater_total := winBackWater_total + dir_total_pos.WIN_BACK_WATER;
               realResult_total := realResult_total + dir_total_pos.REAL_RESULT;
               winBackWaterResult_total := winBackWaterResult_total + dir_total_pos.WIN_BACK_WATER_RESULT;
               paySuperior_total := paySuperior_total + dir_total_pos.PAY_SUPERIOR;

               -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
               commissionBranch_total := commissionBranch_total + dir_total_pos.COMMISSION_BRANCH;
               commissionGenAgent_total := commissionGenAgent_total + dir_total_pos.COMMISSION_GEN_AGENT;
               commissionStockholder_total := commissionStockholder_total + dir_total_pos.COMMISSION_STOCKHOLDER;
               commissionAgent_total := commissionAgent_total + dir_total_pos.COMMISSION_AGENT;
               commissionMember_total := commissionMember_total + dir_total_pos.COMMISSION_MEMBER;

               winCommissionBranch_total := winCommissionBranch_total + dir_total_pos.WIN_COMMISSION_BRANCH;
               winCommissionGenAgent_total := winCommissionGenAgent_total + dir_total_pos.WIN_COMMISSION_GEN_AGENT;
               winCommissionStockholder_total := winCommissionStockholder_total + dir_total_pos.WIN_COMMISSION_STOCKHOLDER;
               winCommissionAgent_total := winCommissionAgent_total + dir_total_pos.WIN_COMMISSION_AGENT;
               winCommissionMember_total := winCommissionMember_total + dir_total_pos.WIN_COMMISSION_MEMBER;

               rateChief_total := rateChief_total + dir_total_pos.RATE_CHIEF;
               rateBranch_total := rateBranch_total + dir_total_pos.RATE_BRANCH;
               rateGenAgent_total := rateGenAgent_total + dir_total_pos.RATE_GEN_AGENT;
               rateStockholder_total := rateStockholder_total + dir_total_pos.RATE_STOCKHOLDER;
               rateAgent_total := rateAgent_total + dir_total_pos.RATE_AGENT;

               moneyRateChief_total := moneyRateChief_total + dir_total_pos.MONEY_RATE_CHIEF;
               moneyRateBranch_total := moneyRateBranch_total + dir_total_pos.MONEY_RATE_BRANCH;
               moneyRateGenAgent_total := moneyRateGenAgent_total + dir_total_pos.MONEY_RATE_GEN_AGENT;
               moneyRateStockholder_total := moneyRateStockholder_total + dir_total_pos.MONEY_RATE_STOCKHOLDER;
               moneyRateAgent_total := moneyRateAgent_total + dir_total_pos.MONEY_RATE_AGENT;

               subordinateChief_total := subordinateChief_total + dir_total_pos.SUBORDINATE_CHIEF;
               subordinateBranch_total := subordinateBranch_total + dir_total_pos.SUBORDINATE_BRANCH;
               subordinateStockholder_total := subordinateStockholder_total + dir_total_pos.SUBORDINATE_STOCKHOLDER;
               subordinateGenAgent_total := subordinateGenAgent_total + dir_total_pos.SUBORDINATE_GEN_AGENT;
               subordinateAgent_total := subordinateAgent_total + dir_total_pos.SUBORDINATE_AGENT;

               -- ռ������ֵ
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 ɾ����Ч��ʱ����
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;
      /******** �ɶ���Ӧ��ֱ����Ա���� ���� ********/

      /******** �������� ��ʼ ********/
      -- 6.2 ��ѯ�������ݣ�����������Ҫ�����淨���Ͳ�ѯ��
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- ֻ��ѯ�����˵Ĳ�������
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- �жϲ�Ʊ����
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- �㶫
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- ���
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- ����
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- ��ʼ��
      turnover_replenish := 0;                         -- ��������
      amount_replenish := 0;                           -- ����Ͷע�ܶ�
      validAmount_replenish :=0;                       -- ������Ч���
      amount_win_replenish := 0;                       -- ������Ӯ
      backWater_replenish := 0;                        -- ������ˮ
      backWaterResult_replenish := 0;                  -- ��ˮ����
      backWater_replenish_temp := 0;                   -- ������Ӯ����ʱ��
      amount_win_replenish_temp := 0;                  -- ������Ӯ����ʱ��

      -- ��ˮ�������
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- ʵռ���
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- ʵռע��
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- Ӧ������
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- ִ�в�ѯ�����α�
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- ���������˳�
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- �ۼӲ����ܶ�
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- �ۼӲ�������
               turnover_replenish := turnover_replenish + 1;

               -- ������Ӯ����Ӧ�ô������в������ܺ�(������ˮ)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- �ۼӡ��н�����Ͷע��
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- ��ȥ��δ�н�����Ͷע��
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- ������Ч����������
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO ��ˮ��Ҫ��ȫ���м������ˮ��Ϣ
               -- ������ˮ������Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- ����򲻼���Ӷ����ˮ��������ֱ����Ա����
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER) / 100);
                  commissionStockholder := commissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - 0) / 100);

                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionStockholder := winCommissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);

                  -- ʵռ�������ˮ������Ҳ���� ��ˮ + ��Ӯ��*ռ��%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  rateBranch := rateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * member_pos_replenish.RATE_BRANCH/100;

                  -- ʵռע���Ч��Ͷע��� * ռ��%��
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- ����Ӧ������
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  subordinateBranch := subordinateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- ������ˮ��������ˮ + ��Ӯ��
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. �������ݲ�����ʱ�������������ͣ������ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + a�������ʵ��ֵΪ1�������ֵ b��ʵ��ֵΪ0�������a��
      -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'e', '1', '����', '����', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. �ۼ��ܶ���Ӳ������ݣ�
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;

      -- 6. �ۻ�������������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
      commissionBranch_total := commissionBranch_total + commissionBranch;
      commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
      commissionStockholder_total := commissionStockholder_total + commissionStockholder;
      commissionAgent_total := commissionAgent_total + commissionAgent;

      winCommissionBranch_total := winCommissionBranch_total + winCommissionBranch;
      winCommissionGenAgent_total := winCommissionGenAgent_total + winCommissionGenAgent;
      winCommissionStockholder_total := winCommissionStockholder_total + winCommissionStockholder;
      winCommissionAgent_total := winCommissionAgent_total + winCommissionAgent;

      rateChief_total := rateChief_total + rateChief;
      rateBranch_total := rateBranch_total + rateBranch;
      rateGenAgent_total := rateGenAgent_total + rateGenAgent;
      rateStockholder_total := rateStockholder_total + rateStockholder;
      rateAgent_total := rateAgent_total + rateAgent;

      -- ʵռע��
      moneyRateChief_total := moneyRateChief_total + moneyRateChief;
      moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
      moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
      moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
      moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

      subordinateChief_total := subordinateChief_total + subordinateChief;
      subordinateBranch_total := subordinateBranch_total + subordinateBranch;
      subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
      subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
      subordinateAgent_total := subordinateAgent_total + subordinateAgent;
      /******** �������� ���� ********/

      -- 4. �ܶ����ݲ�����ʱ��Ϊ���������ܶ����ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + A�������ʵ��ֵΪ1�������ֵ B��
      -- C��2�ܼࣩ��D��3�ֹ�˾����E��4�ɶ�����F��5�ܴ�����G��6������H��7���˺ţ�
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'E', '', '�ϼƣ�', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. ����ʱ���в�ѯ����
      OPEN statReportGenAgent
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. ���ý�����ɹ�������������
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_BRANCH
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Branch(
/*==============================================================*/
/*                    �ֹ�˾���ձ���洢����                      */
/*==============================================================*/
     userID IN varchar2,                -- ����ID
     LOTTERY1688Type IN varchar2,           -- ��Ʊ����
     playType IN varchar2,              -- ��ע����
     periodsNum IN varchar2,            -- ����
     startDate IN varchar2,             -- ��ʼʱ��
     endDate IN varchar2,               -- ����ʱ��
     resultFlag OUT varchar2,           -- �洢ִ�н��ֵ��0-�ɹ���1-userIDΪ�գ�2-����Ϊ��; 9-δ֪����
     statReportStockholder OUT statReportResult.resultRef         -- ���ؽ����
) AS
     subordinate varchar2(50);          -- �¼���½�˺�
     userName varchar2(50);             -- �û�����
     turnover NUMBER;                   -- �ɽ�����
     amount NUMBER;                     -- Ͷע�ܶ�
     validAmount NUMBER;                -- ��Ч���
     memberAmount NUMBER;               -- ��Ա��Ӯ
     memberBackWater NUMBER;            -- ��Ա��ˮ
     subordinateAmount NUMBER;          -- Ӧ������
     winBackWater NUMBER;               -- ׬ȡ��ˮ
     realResult NUMBER;                 -- ʵռ���
     winBackWaterResult NUMBER;         -- ׬ˮ����
     paySuperior NUMBER;                -- Ӧ���ϼ�
     subID NUMBER;                      -- ��¼ID
     memberAmount_temp NUMBER;          -- ��ʱ�������洢��Ա��Ӯ����
     memberBackWater_temp NUMBER;       -- ��ʱ��������Ա��ˮ
     recNum NUMBER;                     -- ��ʱ��������¼��

     -- �����α�
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     his_cursor  mycursor;
     member_pos TB_HKLHC_HIS%rowtype;

     sql_replenish varchar2(2000);              -- ������ѯ sql
     cursor_replenish mycursor;                 -- �����α�
     member_pos_replenish TB_REPLENISH%rowtype; -- �������ݶ���
     turnover_replenish NUMBER;                 -- ��������
     amount_replenish NUMBER;                   -- ����Ͷע�ܶ�
     validAmount_replenish NUMBER;              -- ������Ч���
     amount_win_replenish NUMBER;               -- ������Ӯ
     backWater_replenish NUMBER;                -- ������ˮ
     backWaterResult_replenish NUMBER;          -- ��ˮ����
     backWater_replenish_temp NUMBER;           -- ������ˮ����ʱ��
     amount_win_replenish_temp NUMBER;          -- ������Ӯ����ʱ��

     -- �ܶ�ͳ��ֵ
     turnover_total NUMBER;             -- �ɽ��������ܶ
     amount_total NUMBER;               -- Ͷע�ܶ�ܶ
     validAmount_total NUMBER;          -- ��Ч���ܶ
     memberAmount_total NUMBER;         -- ��Ա��Ӯ���ܶ
     memberBackWater_total NUMBER;      -- ��Ա��ˮ���ܶ
     subordinateAmount_total NUMBER;    -- Ӧ�����ߣ��ܶ
     winBackWater_total NUMBER;         -- ׬ȡ��ˮ���ܶ
     realResult_total NUMBER;           -- ʵռ������ܶ
     winBackWaterResult_total NUMBER;   -- ׬ˮ�������ܶ
     paySuperior_total NUMBER;          -- Ӧ���ϼ����ܶ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ��
     commissionBranch NUMBER;           -- �ֹ�˾Ӷ��
     commissionGenAgent NUMBER;         -- �ܴ���Ӷ��
     commissionStockholder NUMBER;      -- �ɶ�Ӷ��
     commissionAgent NUMBER;            -- ����Ӷ��
     commissionMember NUMBER;           -- ��ԱӶ��

     -- ׬ȡӶ��
     winCommissionBranch NUMBER;           -- �ֹ�˾׬ȡӶ��
     winCommissionGenAgent NUMBER;         -- �ܴ���׬ȡӶ��
     winCommissionStockholder NUMBER;      -- �ɶ�׬ȡӶ��
     winCommissionAgent NUMBER;            -- ����׬ȡӶ��
     winCommissionMember NUMBER;           -- ��Ա׬ȡӶ��

     rateChief NUMBER;                  -- �ܼ�ռ��
     rateBranch NUMBER;                 -- �ֹ�˾ռ��
     rateGenAgent NUMBER;               -- �ܴ���ռ��
     rateStockholder NUMBER;            -- �ɶ�ռ��
     rateAgent NUMBER;                  -- ����ռ��

     moneyRateChief NUMBER;             -- �ܼ�ʵռע��
     moneyRateBranch NUMBER;            -- �ֹ�˾ʵռע��
     moneyRateGenAgent NUMBER;          -- �ܴ���ʵռע��
     moneyRateStockholder NUMBER;       -- �ɶ�ʵռע��
     moneyRateAgent NUMBER;             -- ����ʵռע��

     subordinateChief NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent NUMBER;           -- ����Ӧ�գ�����

     rate NUMBER;                       -- ռ������ֵ
     rateChiefSet NUMBER;               -- �ܼ�ռ������ֵ
     rateBranchSet NUMBER;              -- �ֹ�˾ռ������ֵ
     rateStockholderSet NUMBER;         -- �ɶ�ռ������ֵ
     rateGenAgentSet NUMBER;            -- �ܴ���ռ������ֵ
     rateAgentSet NUMBER;               -- ����ռ������ֵ

     commissionBranchSet NUMBER;        -- �ֹ�˾��ˮ����ֵ
     commissionStockholderSet NUMBER;   -- �ɶ���ˮ����ֵ
     commissionGenAgentSet NUMBER;      -- �ܴ�����ˮ����ֵ
     commissionAgentSet NUMBER;         -- ������ˮ����ֵ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ�գ��ܶ
     commissionBranch_total NUMBER;           -- �ֹ�˾Ӷ���ܶ
     commissionGenAgent_total NUMBER;         -- �ܴ���Ӷ���ܶ
     commissionStockholder_total NUMBER;      -- �ɶ�Ӷ���ܶ
     commissionAgent_total NUMBER;            -- ����Ӷ���ܶ
     commissionMember_total NUMBER;           -- ��ԱӶ���ܶ

     -- ׬ȡӶ��
     winCommissionBranch_total NUMBER;           -- �ֹ�˾׬ȡӶ���ܶ
     winCommissionGenAgent_total NUMBER;         -- �ܴ���׬ȡӶ���ܶ
     winCommissionStockholder_total NUMBER;      -- �ɶ�׬ȡӶ���ܶ
     winCommissionAgent_total NUMBER;            -- ����׬ȡӶ���ܶ
     winCommissionMember_total NUMBER;           -- ��Ա׬ȡӶ���ܶ

     rateChief_total NUMBER;                  -- �ܼ�ռ�ɣ��ܶ
     rateBranch_total NUMBER;                 -- �ֹ�˾ռ�ɣ��ܶ
     rateGenAgent_total NUMBER;               -- �ܴ���ռ�ɣ��ܶ
     rateStockholder_total NUMBER;            -- �ɶ�ռ�ɣ��ܶ
     rateAgent_total NUMBER;                  -- ����ռ�ɣ��ܶ

     moneyRateChief_total NUMBER;                  -- �ܼ�ʵռע��ܶ
     moneyRateBranch_total NUMBER;                 -- �ֹ�˾ʵռע��ܶ
     moneyRateGenAgent_total NUMBER;               -- �ܴ���ʵռע��ܶ
     moneyRateStockholder_total NUMBER;            -- �ɶ�ʵռע��ܶ
     moneyRateAgent_total NUMBER;                  -- ����ʵռע��ܶ

     subordinateChief_total NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch_total NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder_total NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent_total NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent_total NUMBER;           -- ����Ӧ�գ�����

     recNum_total NUMBER;                     -- ��ʱ��������Ч��Ա��
     -- ռ������ֵֻȡ���һ��ֵ�����ܺ�ֵ��Ч
     --rate_total NUMBER;                       -- ռ������ֵ���ܺͣ�
     --rateChiefSet_total NUMBER;               -- �ܼ�ռ������ֵ���ܺͣ�
     --rateBranchSet_total NUMBER;              -- �ֹ�˾ռ������ֵ���ܺͣ�
     --rateStockholderSet_total NUMBER;         -- �ɶ�ռ������ֵ���ܺͣ�
     --rateGenAgentSet_total NUMBER;            -- �ܴ���ռ������ֵ���ܺͣ�
     --rateAgentSet_total NUMBER;               -- ����ռ������ֵ���ܺͣ�
BEGIN
     -- ��ʼ�����ؽ��ֵ
     resultFlag := 0;

     -- 1.1 У���������
     dbms_output.put_line('userID��'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 ��ʼ���ܶ�
     turnover_total := 0;
     amount_total := 0;
     validAmount_total := 0;
     memberAmount_total := 0;
     memberBackWater_total := 0;
     subordinateAmount_total := 0;
     winBackWater_total := 0;
     realResult_total := 0;
     winBackWaterResult_total := 0;
     paySuperior_total := 0;

     commissionBranch_total := 0;
     commissionGenAgent_total := 0;
     commissionStockholder_total := 0;
     commissionAgent_total := 0;
     commissionMember_total := 0;

     winCommissionBranch_total := 0;
     winCommissionGenAgent_total := 0;
     winCommissionStockholder_total := 0;
     winCommissionAgent_total := 0;
     winCommissionMember_total := 0;

     rateChief_total := 0;
     rateBranch_total := 0;
     rateGenAgent_total := 0;
     rateStockholder_total := 0;
     rateAgent_total := 0;

     moneyRateChief_total := 0;
     moneyRateBranch_total := 0;
     moneyRateGenAgent_total := 0;
     moneyRateStockholder_total := 0;
     moneyRateAgent_total := 0;

     subordinateChief_total := 0;
     subordinateBranch_total := 0;
     subordinateStockholder_total := 0;
     subordinateGenAgent_total := 0;
     subordinateAgent_total := 0;

     -- ��ʼ��ռ������ֵ�������
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 ɾ����ʱ���е�����
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 ��ѯ�ֹ�˾��Ӧ�Ĺɶ���Ϣ
     declare
     cursor stockholder_cursor
     IS
     SELECT * FROM
         (TB_STOCKHOLDER_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 ѭ���������еĹɶ���Ϣ
          FOR stockholder_pos IN stockholder_cursor LOOP
              -- 2.1.2 ������ݼ�¼
              subordinate := stockholder_pos.ACCOUNT;         -- �¼���½�˺�
              userName := stockholder_pos.CHS_NAME;           -- �û�����
              subID := stockholder_pos.ID;                    -- ��¼ID
              -- 2.1.3 ��ʼ������
              turnover := 0;                  -- �ɽ�����
              amount := 0;                    -- Ͷע�ܶ�
              validAmount := 0;               -- ��Ч���
              memberAmount := 0;              -- ��Ա��Ӯ
              subordinateAmount := 0;         -- Ӧ������
              memberBackWater := 0;           -- ��Ա��ˮ
              winBackWater := 0;              -- ׬ȡ��ˮ
              realResult := 0;                -- ʵռ���
              winBackWaterResult := 0;        -- ׬ˮ����
              paySuperior := 0;               -- Ӧ���ϼ�
              rate := 0;                      -- ռ��
              recNum := 0;

              -- 3.3 ��ʼ���洢��������Ӧ�ļ�����Ӷ��ռ�ɡ��¼�Ӧ��
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- ׬ȡ��ˮ
              winCommissionBranch := 0;
              winCommissionGenAgent := 0;
              winCommissionStockholder := 0;
              winCommissionAgent := 0;
              winCommissionMember := 0;

              rateChief := 0;
              rateBranch := 0;
              rateGenAgent := 0;
              rateStockholder := 0;
              rateAgent := 0;

              moneyRateChief := 0;
              moneyRateBranch := 0;
              moneyRateGenAgent := 0;
              moneyRateStockholder := 0;
              moneyRateAgent := 0;

              subordinateChief := 0;
              subordinateBranch := 0;
              subordinateStockholder := 0;
              subordinateGenAgent := 0;
              subordinateAgent := 0;
              rate := 0;
              rateChiefSet := 0;
              rateBranchSet := 0;
              rateStockholderSet := 0;
              rateGenAgentSet := 0;
              rateAgentSet := 0;

              commissionBranchSet := 0;
              commissionStockholderSet := 0;
              commissionGenAgentSet := 0;
              commissionAgentSet := 0;

              -- 2.1.4 ���ùɶ����ձ���洢����
              Delivery_Report_Stockholder(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportStockholder);
              -- ��ȡ�����ձ���洢�������γɵ�����
              declare
              cursor report_stockholder_cursor
              IS
              -- ���˵��¼��û���Ӧ�Ĳ�����Ϣ
              -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = stockholder_pos.ID AND t.USER_TYPE NOT IN ('g','f','e');

              BEGIN
              FOR report_stockholder_pos IN report_stockholder_cursor LOOP

                  -- ��Ա��ˮ
                  memberBackWater := report_stockholder_pos.COMMISSION_STOCKHOLDER + report_stockholder_pos.COMMISSION_GEN_AGENT + report_stockholder_pos.COMMISSION_AGENT + report_stockholder_pos.COMMISSION_MEMBER;
                  -- Ӧ�����ߣ�ֱ�Ӷ�ȡ����������ı���������ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  -- subordinateAmount := report_stockholder_pos.RATE_CHIEF + report_stockholder_pos.RATE_BRANCH + report_stockholder_pos.RATE_STOCKHOLDER + report_stockholder_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_stockholder_pos.SUBORDINATE_BRANCH;
                  -- ʵռ�����ֱ�Ӷ�ȡ����������Ĺɶ�ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  realResult := report_stockholder_pos.RATE_BRANCH;
                  -- ׬ȡ��ˮ
                  winBackWater := report_stockholder_pos.WIN_COMMISSION_BRANCH;
                  -- ׬ˮ������ʵռ���-׬ȡ��ˮ��
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- Ӧ�����ߣ�Ӧ�����ߣ�׬ˮ������
                  paySuperior := subordinateAmount - winBackWaterResult;

                  -- ʵռע��
                  moneyRateChief := report_stockholder_pos.MONEY_RATE_CHIEF;
                  moneyRateBranch := report_stockholder_pos.MONEY_RATE_BRANCH;
                  moneyRateGenAgent := report_stockholder_pos.MONEY_RATE_GEN_AGENT;
                  moneyRateStockholder := report_stockholder_pos.MONEY_RATE_STOCKHOLDER;
                  moneyRateAgent := report_stockholder_pos.MONEY_RATE_AGENT;

                  subordinateChief := report_stockholder_pos.SUBORDINATE_CHIEF;
                  subordinateBranch := report_stockholder_pos.SUBORDINATE_BRANCH;
                  subordinateStockholder := report_stockholder_pos.SUBORDINATE_STOCKHOLDER;
                  subordinateGenAgent := report_stockholder_pos.SUBORDINATE_GEN_AGENT;
                  subordinateAgent := report_stockholder_pos.SUBORDINATE_AGENT;

                  -- ռ������ֵ
                  rateChiefSet := report_stockholder_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_stockholder_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_stockholder_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_stockholder_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_stockholder_pos.RATE_AGENT_SET;

                  -- ��ˮ����ֵ
                  commissionBranchSet := report_stockholder_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_stockholder_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_stockholder_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_stockholder_pos.COMMISSION_AGENT_SET;

                  rate := report_stockholder_pos.RATE_BRANCH_SET;
                  -- ��ֵ��TODO �����������������Ͷע����֮ǰ�����Ƿ��������
                  turnover := report_stockholder_pos.TURNOVER;          -- �ɽ�����
                  amount := report_stockholder_pos.AMOUNT;              -- Ͷע�ܶ�
                  validAmount := report_stockholder_pos.VALID_AMOUNT;   -- ��Ч���
                  memberAmount := report_stockholder_pos.MEMBER_AMOUNT; -- ��Ա��Ӯ

                  -- 2.1.4.1 ���ݲ�����ʱ��
                  INSERT INTO TEMP_DELIVERYREPORT
                      (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
                      COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
                      SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
                      RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
                      COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
                      MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
                  VALUES (
                      userID,
                      stockholder_pos.ID,
                      '4',
                      stockholder_pos.ACCOUNT,
                      stockholder_pos.CHS_NAME,
                      turnover,
                      amount,
                      validAmount,
                      memberAmount,
                      memberBackWater,
                      subordinateAmount,
                      winBackWater,
                      realResult,
                      winBackWaterResult,
                      paySuperior,
                      report_stockholder_pos.COMMISSION_BRANCH, report_stockholder_pos.COMMISSION_GEN_AGENT, report_stockholder_pos.COMMISSION_STOCKHOLDER, report_stockholder_pos.COMMISSION_AGENT, report_stockholder_pos.COMMISSION_MEMBER, report_stockholder_pos.WIN_COMMISSION_BRANCH, report_stockholder_pos.WIN_COMMISSION_GEN_AGENT, report_stockholder_pos.WIN_COMMISSION_STOCKHOLDER, report_stockholder_pos.WIN_COMMISSION_AGENT, report_stockholder_pos.WIN_COMMISSION_MEMBER, report_stockholder_pos.RATE_CHIEF, report_stockholder_pos.RATE_BRANCH, report_stockholder_pos.RATE_GEN_AGENT, report_stockholder_pos.RATE_STOCKHOLDER, report_stockholder_pos.RATE_AGENT,
                      rate,
                      subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent,
                      rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
                      commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
                      moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent
                      );

                   -- 2.1.4.2 �ۼ��ܶ�
                   turnover_total := turnover_total + report_stockholder_pos.TURNOVER;
                   amount_total := amount_total + report_stockholder_pos.AMOUNT;
                   validAmount_total := validAmount_total + report_stockholder_pos.VALID_AMOUNT;
                   memberAmount_total := memberAmount_total + report_stockholder_pos.MEMBER_AMOUNT;
                   memberBackWater_total := memberBackWater_total + memberBackWater;
                   subordinateAmount_total := subordinateAmount_total + subordinateAmount;
                   winBackWater_total := winBackWater_total + winBackWater;
                   realResult_total := realResult_total + realResult;
                   winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
                   paySuperior_total := paySuperior_total + paySuperior;

                   -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
                   commissionBranch_total := commissionBranch_total + report_stockholder_pos.COMMISSION_BRANCH;
                   commissionGenAgent_total := commissionGenAgent_total + report_stockholder_pos.COMMISSION_GEN_AGENT;
                   commissionStockholder_total := commissionStockholder_total + report_stockholder_pos.COMMISSION_STOCKHOLDER;
                   commissionAgent_total := commissionAgent_total + report_stockholder_pos.COMMISSION_AGENT;
                   commissionMember_total := commissionMember_total + report_stockholder_pos.COMMISSION_MEMBER;

                   winCommissionBranch_total := winCommissionBranch_total + report_stockholder_pos.WIN_COMMISSION_BRANCH;
                   winCommissionGenAgent_total := winCommissionGenAgent_total + report_stockholder_pos.WIN_COMMISSION_GEN_AGENT;
                   winCommissionStockholder_total := winCommissionStockholder_total + report_stockholder_pos.WIN_COMMISSION_STOCKHOLDER;
                   winCommissionAgent_total := winCommissionAgent_total + report_stockholder_pos.WIN_COMMISSION_AGENT;
                   winCommissionMember_total := winCommissionMember_total + report_stockholder_pos.WIN_COMMISSION_MEMBER;

                   rateChief_total := rateChief_total + report_stockholder_pos.RATE_CHIEF;
                   rateBranch_total := rateBranch_total + report_stockholder_pos.RATE_BRANCH;
                   rateGenAgent_total := rateGenAgent_total + report_stockholder_pos.RATE_GEN_AGENT;
                   rateStockholder_total := rateStockholder_total + report_stockholder_pos.RATE_STOCKHOLDER;
                   rateAgent_total := rateAgent_total + report_stockholder_pos.RATE_AGENT;

                   -- ʵռע��
                   moneyRateChief_total := moneyRateChief_total + moneyRateChief;
                   moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
                   moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
                   moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
                   moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

                   subordinateChief_total := subordinateChief_total + subordinateChief;
                   subordinateBranch_total := subordinateBranch_total + subordinateBranch;
                   subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
                   subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
                   subordinateAgent_total := subordinateAgent_total + subordinateAgent;

                   -- ռ������ֵ
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 ɾ����Ч��ʱ����
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = stockholder_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** �ֹ�˾��Ӧ��ֱ����Ա���� ��ʼ ********/
      -- ����ֱ����Ա���ձ���洢����
      Delivery_Report_Dir_Member(userID, '3', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- ��ѯֱ����Աͳ������
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- �ۼ�ֱ����Աͳ������
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 �ۼ��ܶ�
               turnover_total := turnover_total + dir_total_pos.TURNOVER;
               amount_total := amount_total + dir_total_pos.AMOUNT;
               validAmount_total := validAmount_total + dir_total_pos.VALID_AMOUNT;
               memberAmount_total := memberAmount_total + dir_total_pos.MEMBER_AMOUNT;
               memberBackWater_total := memberBackWater_total + dir_total_pos.MEMBER_BACK_WATER;
               subordinateAmount_total := subordinateAmount_total + dir_total_pos.SUBORDINATE_AMOUNT;
               winBackWater_total := winBackWater_total + dir_total_pos.WIN_BACK_WATER;
               realResult_total := realResult_total + dir_total_pos.REAL_RESULT;
               winBackWaterResult_total := winBackWaterResult_total + dir_total_pos.WIN_BACK_WATER_RESULT;
               paySuperior_total := paySuperior_total + dir_total_pos.PAY_SUPERIOR;

               -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
               commissionBranch_total := commissionBranch_total + dir_total_pos.COMMISSION_BRANCH;
               commissionGenAgent_total := commissionGenAgent_total + dir_total_pos.COMMISSION_GEN_AGENT;
               commissionStockholder_total := commissionStockholder_total + dir_total_pos.COMMISSION_STOCKHOLDER;
               commissionAgent_total := commissionAgent_total + dir_total_pos.COMMISSION_AGENT;
               commissionMember_total := commissionMember_total + dir_total_pos.COMMISSION_MEMBER;

               winCommissionBranch_total := winCommissionBranch_total + dir_total_pos.WIN_COMMISSION_BRANCH;
               winCommissionGenAgent_total := winCommissionGenAgent_total + dir_total_pos.WIN_COMMISSION_GEN_AGENT;
               winCommissionStockholder_total := winCommissionStockholder_total + dir_total_pos.WIN_COMMISSION_STOCKHOLDER;
               winCommissionAgent_total := winCommissionAgent_total + dir_total_pos.WIN_COMMISSION_AGENT;
               winCommissionMember_total := winCommissionMember_total + dir_total_pos.WIN_COMMISSION_MEMBER;

               rateChief_total := rateChief_total + dir_total_pos.RATE_CHIEF;
               rateBranch_total := rateBranch_total + dir_total_pos.RATE_BRANCH;
               rateGenAgent_total := rateGenAgent_total + dir_total_pos.RATE_GEN_AGENT;
               rateStockholder_total := rateStockholder_total + dir_total_pos.RATE_STOCKHOLDER;
               rateAgent_total := rateAgent_total + dir_total_pos.RATE_AGENT;

               moneyRateChief_total := moneyRateChief_total + dir_total_pos.MONEY_RATE_CHIEF;
               moneyRateBranch_total := moneyRateBranch_total + dir_total_pos.MONEY_RATE_BRANCH;
               moneyRateGenAgent_total := moneyRateGenAgent_total + dir_total_pos.MONEY_RATE_GEN_AGENT;
               moneyRateStockholder_total := moneyRateStockholder_total + dir_total_pos.MONEY_RATE_STOCKHOLDER;
               moneyRateAgent_total := moneyRateAgent_total + dir_total_pos.MONEY_RATE_AGENT;

               subordinateChief_total := subordinateChief_total + dir_total_pos.SUBORDINATE_CHIEF;
               subordinateBranch_total := subordinateBranch_total + dir_total_pos.SUBORDINATE_BRANCH;
               subordinateStockholder_total := subordinateStockholder_total + dir_total_pos.SUBORDINATE_STOCKHOLDER;
               subordinateGenAgent_total := subordinateGenAgent_total + dir_total_pos.SUBORDINATE_GEN_AGENT;
               subordinateAgent_total := subordinateAgent_total + dir_total_pos.SUBORDINATE_AGENT;

               -- ռ������ֵ
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 ɾ����Ч��ʱ����
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;
      /******** �ֹ�˾��Ӧ��ֱ����Ա���� ���� ********/

      /******** �������� ��ʼ ********/
      -- 6.2 ��ѯ�������ݣ�����������Ҫ�����淨���Ͳ�ѯ��
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- ֻ��ѯ�����˵Ĳ�������
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- �жϲ�Ʊ����
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- �㶫
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- ���
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- ����
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- ��ʼ��
      turnover_replenish := 0;                         -- ��������
      amount_replenish := 0;                           -- ����Ͷע�ܶ�
      validAmount_replenish :=0;                       -- ������Ч���
      amount_win_replenish := 0;                       -- ������Ӯ
      backWater_replenish := 0;                        -- ������ˮ
      backWaterResult_replenish := 0;                  -- ��ˮ����
      backWater_replenish_temp := 0;                   -- ������Ӯ����ʱ��
      amount_win_replenish_temp := 0;                  -- ������Ӯ����ʱ��

      -- ��ˮ�������
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- ʵռ���
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- ʵռע��
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- Ӧ������
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- ִ�в�ѯ�����α�
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- ���������˳�
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- �ۼӲ����ܶ�
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- �ۼӲ�������
               turnover_replenish := turnover_replenish + 1;

               -- ������Ӯ����Ӧ�ô������в������ܺ�(������ˮ)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- �ۼӡ��н�����Ͷע��
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- ��ȥ��δ�н�����Ͷע��
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- ������Ч����������
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO ��ˮ��Ҫ��ȫ���м������ˮ��Ϣ
               -- ������ˮ������Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- ����򲻼���Ӷ����ˮ��������ֱ����Ա����
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - 0) / 100);

                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);

                  -- ʵռ�������ˮ������Ҳ���� ��ˮ + ��Ӯ��*ռ��%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;

                  -- ʵռע���Ч��Ͷע��� * ռ��%��
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- ����Ӧ������
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- ������ˮ��������ˮ + ��Ӯ��
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. �������ݲ�����ʱ�������������ͣ������ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + a�������ʵ��ֵΪ1�������ֵ b��ʵ��ֵΪ0�������a��
      -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'd', '1', '����', '����', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. �ۼ��ܶ���Ӳ������ݣ�
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;

      -- 6. �ۻ�������������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
      commissionBranch_total := commissionBranch_total + commissionBranch;
      commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
      commissionStockholder_total := commissionStockholder_total + commissionStockholder;
      commissionAgent_total := commissionAgent_total + commissionAgent;

      winCommissionBranch_total := winCommissionBranch_total + winCommissionBranch;
      winCommissionGenAgent_total := winCommissionGenAgent_total + winCommissionGenAgent;
      winCommissionStockholder_total := winCommissionStockholder_total + winCommissionStockholder;
      winCommissionAgent_total := winCommissionAgent_total + winCommissionAgent;

      rateChief_total := rateChief_total + rateChief;
      rateBranch_total := rateBranch_total + rateBranch;
      rateGenAgent_total := rateGenAgent_total + rateGenAgent;
      rateStockholder_total := rateStockholder_total + rateStockholder;
      rateAgent_total := rateAgent_total + rateAgent;

      -- ʵռע��
      moneyRateChief_total := moneyRateChief_total + moneyRateChief;
      moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
      moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
      moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
      moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

      subordinateChief_total := subordinateChief_total + subordinateChief;
      subordinateBranch_total := subordinateBranch_total + subordinateBranch;
      subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
      subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
      subordinateAgent_total := subordinateAgent_total + subordinateAgent;
      /******** �������� ���� ********/

      -- 4. �ܶ����ݲ�����ʱ��Ϊ���������ܶ����ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + A�������ʵ��ֵΪ1�������ֵ B��
      -- C��2�ܼࣩ��D��3�ֹ�˾����E��4�ɶ�����F��5�ܴ�����G��6������H��7���˺ţ�
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'D', '', '�ϼƣ�', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. ����ʱ���в�ѯ����
      OPEN statReportStockholder
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. ���ý�����ɹ�������������
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_CHIEF
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Chief(
/*==============================================================*/
/*                    �ཻܼ�ձ���洢����                      */
/*==============================================================*/
     userID IN varchar2,                -- ����ID
     LOTTERY1688Type IN varchar2,           -- ��Ʊ����
     playType IN varchar2,              -- ��ע����
     periodsNum IN varchar2,            -- ����
     startDate IN varchar2,             -- ��ʼʱ��
     endDate IN varchar2,               -- ����ʱ��
     resultFlag OUT varchar2,           -- �洢ִ�н��ֵ��0-�ɹ���1-userIDΪ�գ�2-����Ϊ��; 9-δ֪����
     statReportBranch OUT statReportResult.resultRef         -- ���ؽ����
) AS
     subordinate varchar2(50);          -- �¼���½�˺�
     userName varchar2(50);             -- �û�����
     turnover NUMBER;                   -- �ɽ�����
     amount NUMBER;                     -- Ͷע�ܶ�
     validAmount NUMBER;                -- ��Ч���
     memberAmount NUMBER;               -- ��Ա��Ӯ
     memberBackWater NUMBER;            -- ��Ա��ˮ
     subordinateAmount NUMBER;          -- Ӧ������
     winBackWater NUMBER;               -- ׬ȡ��ˮ
     realResult NUMBER;                 -- ʵռ���
     winBackWaterResult NUMBER;         -- ׬ˮ����
     paySuperior NUMBER;                -- Ӧ���ϼ�
     subID NUMBER;                      -- ��¼ID
     memberAmount_temp NUMBER;          -- ��ʱ�������洢��Ա��Ӯ����
     memberBackWater_temp NUMBER;       -- ��ʱ��������Ա��ˮ
     recNum NUMBER;                     -- ��ʱ��������¼��

     -- �����α�
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     his_cursor  mycursor;
     member_pos TB_HKLHC_HIS%rowtype;

     sql_replenish varchar2(2000);              -- ������ѯ sql
     cursor_replenish mycursor;                 -- �����α�
     member_pos_replenish TB_REPLENISH%rowtype; -- �������ݶ���
     turnover_replenish NUMBER;                 -- ��������
     amount_replenish NUMBER;                   -- ����Ͷע�ܶ�
     validAmount_replenish NUMBER;              -- ������Ч���
     amount_win_replenish NUMBER;               -- ������Ӯ
     backWater_replenish NUMBER;                -- ������ˮ
     backWaterResult_replenish NUMBER;          -- ��ˮ����
     backWater_replenish_temp NUMBER;           -- ������ˮ����ʱ��
     amount_win_replenish_temp NUMBER;          -- ������Ӯ����ʱ��

     -- �ܶ�ͳ��ֵ
     turnover_total NUMBER;             -- �ɽ��������ܶ
     amount_total NUMBER;               -- Ͷע�ܶ�ܶ
     validAmount_total NUMBER;          -- ��Ч���ܶ
     memberAmount_total NUMBER;         -- ��Ա��Ӯ���ܶ
     memberBackWater_total NUMBER;      -- ��Ա��ˮ���ܶ
     subordinateAmount_total NUMBER;    -- Ӧ�����ߣ��ܶ
     winBackWater_total NUMBER;         -- ׬ȡ��ˮ���ܶ
     realResult_total NUMBER;           -- ʵռ������ܶ
     winBackWaterResult_total NUMBER;   -- ׬ˮ�������ܶ
     paySuperior_total NUMBER;          -- Ӧ���ϼ����ܶ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ��
     commissionBranch NUMBER;           -- �ֹ�˾Ӷ��
     commissionGenAgent NUMBER;         -- �ܴ���Ӷ��
     commissionStockholder NUMBER;      -- �ɶ�Ӷ��
     commissionAgent NUMBER;            -- ����Ӷ��
     commissionMember NUMBER;           -- ��ԱӶ��

     -- ׬ȡӶ��
     winCommissionBranch NUMBER;           -- �ֹ�˾׬ȡӶ��
     winCommissionGenAgent NUMBER;         -- �ܴ���׬ȡӶ��
     winCommissionStockholder NUMBER;      -- �ɶ�׬ȡӶ��
     winCommissionAgent NUMBER;            -- ����׬ȡӶ��
     winCommissionMember NUMBER;           -- ��Ա׬ȡӶ��

     rateChief NUMBER;                  -- �ܼ�ռ��
     rateBranch NUMBER;                 -- �ֹ�˾ռ��
     rateGenAgent NUMBER;               -- �ܴ���ռ��
     rateStockholder NUMBER;            -- �ɶ�ռ��
     rateAgent NUMBER;                  -- ����ռ��

     moneyRateChief NUMBER;             -- �ܼ�ʵռע��
     moneyRateBranch NUMBER;            -- �ֹ�˾ʵռע��
     moneyRateGenAgent NUMBER;          -- �ܴ���ʵռע��
     moneyRateStockholder NUMBER;       -- �ɶ�ʵռע��
     moneyRateAgent NUMBER;             -- ����ʵռע��

     subordinateChief NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent NUMBER;           -- ����Ӧ�գ�����

     rate NUMBER;                       -- ռ������ֵ
     rateChiefSet NUMBER;               -- �ܼ�ռ������ֵ
     rateBranchSet NUMBER;              -- �ֹ�˾ռ������ֵ
     rateStockholderSet NUMBER;         -- �ɶ�ռ������ֵ
     rateGenAgentSet NUMBER;            -- �ܴ���ռ������ֵ
     rateAgentSet NUMBER;               -- ����ռ������ֵ

     commissionBranchSet NUMBER;        -- �ֹ�˾��ˮ����ֵ
     commissionStockholderSet NUMBER;   -- �ɶ���ˮ����ֵ
     commissionGenAgentSet NUMBER;      -- �ܴ�����ˮ����ֵ
     commissionAgentSet NUMBER;         -- ������ˮ����ֵ

     -- �洢��������Ӧ�ļ�����Ӷ��ռ�ɡ�����Ӧ�գ��ܶ
     commissionBranch_total NUMBER;           -- �ֹ�˾Ӷ���ܶ
     commissionGenAgent_total NUMBER;         -- �ܴ���Ӷ���ܶ
     commissionStockholder_total NUMBER;      -- �ɶ�Ӷ���ܶ
     commissionAgent_total NUMBER;            -- ����Ӷ���ܶ
     commissionMember_total NUMBER;           -- ��ԱӶ���ܶ

     -- ׬ȡӶ��
     winCommissionBranch_total NUMBER;           -- �ֹ�˾׬ȡӶ���ܶ
     winCommissionGenAgent_total NUMBER;         -- �ܴ���׬ȡӶ���ܶ
     winCommissionStockholder_total NUMBER;      -- �ɶ�׬ȡӶ���ܶ
     winCommissionAgent_total NUMBER;            -- ����׬ȡӶ���ܶ
     winCommissionMember_total NUMBER;           -- ��Ա׬ȡӶ���ܶ

     rateChief_total NUMBER;                  -- �ܼ�ռ�ɣ��ܶ
     rateBranch_total NUMBER;                 -- �ֹ�˾ռ�ɣ��ܶ
     rateGenAgent_total NUMBER;               -- �ܴ���ռ�ɣ��ܶ
     rateStockholder_total NUMBER;            -- �ɶ�ռ�ɣ��ܶ
     rateAgent_total NUMBER;                  -- ����ռ�ɣ��ܶ

     moneyRateChief_total NUMBER;                  -- �ܼ�ʵռע��ܶ
     moneyRateBranch_total NUMBER;                 -- �ֹ�˾ʵռע��ܶ
     moneyRateGenAgent_total NUMBER;               -- �ܴ���ʵռע��ܶ
     moneyRateStockholder_total NUMBER;            -- �ɶ�ʵռע��ܶ
     moneyRateAgent_total NUMBER;                  -- ����ʵռע��ܶ

     subordinateChief_total NUMBER;           -- ����Ӧ�գ��ܼࣩ
     subordinateBranch_total NUMBER;          -- ����Ӧ�գ��ֹ�˾��
     subordinateStockholder_total NUMBER;     -- ����Ӧ�գ��ɶ���
     subordinateGenAgent_total NUMBER;        -- ����Ӧ�գ��ܴ���
     subordinateAgent_total NUMBER;           -- ����Ӧ�գ�����

     -- ռ������ֵֻȡ���һ��ֵ�����ܺ�ֵ��Ч
     recNum_total NUMBER;                     -- ��ʱ��������Ч��Ա��
     --rate_total NUMBER;                       -- ռ������ֵ���ܺͣ�
     --rateChiefSet_total NUMBER;               -- �ܼ�ռ������ֵ���ܺͣ�
     --rateBranchSet_total NUMBER;              -- �ֹ�˾ռ������ֵ���ܺͣ�
     --rateStockholderSet_total NUMBER;         -- �ɶ�ռ������ֵ���ܺͣ�
     --rateGenAgentSet_total NUMBER;            -- �ܴ���ռ������ֵ���ܺͣ�
     --rateAgentSet_total NUMBER;               -- ����ռ������ֵ���ܺͣ�
BEGIN
     -- ��ʼ�����ؽ��ֵ
     resultFlag := 0;

     -- 1.1 У���������
     dbms_output.put_line('userID��'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 ��ʼ���ܶ�
     turnover_total := 0;
     amount_total := 0;
     validAmount_total := 0;
     memberAmount_total := 0;
     memberBackWater_total := 0;
     subordinateAmount_total := 0;
     winBackWater_total := 0;
     realResult_total := 0;
     winBackWaterResult_total := 0;
     paySuperior_total := 0;

     commissionBranch_total := 0;
     commissionGenAgent_total := 0;
     commissionStockholder_total := 0;
     commissionAgent_total := 0;
     commissionMember_total := 0;

     winCommissionBranch_total := 0;
     winCommissionGenAgent_total := 0;
     winCommissionStockholder_total := 0;
     winCommissionAgent_total := 0;
     winCommissionMember_total := 0;

     rateChief_total := 0;
     rateBranch_total := 0;
     rateGenAgent_total := 0;
     rateStockholder_total := 0;
     rateAgent_total := 0;

     moneyRateChief_total := 0;
     moneyRateBranch_total := 0;
     moneyRateGenAgent_total := 0;
     moneyRateStockholder_total := 0;
     moneyRateAgent_total := 0;

     subordinateChief_total := 0;
     subordinateBranch_total := 0;
     subordinateStockholder_total := 0;
     subordinateGenAgent_total := 0;
     subordinateAgent_total := 0;

     -- ��ʼ��ռ������ֵ�������
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 ɾ����ʱ���е�����
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 ��ѯ�ܼ��Ӧ�ķֹ�˾��Ϣ
     declare
     cursor branch_cursor
     IS
     SELECT * FROM
         (TB_BRANCH_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 ѭ���������еķֹ�˾��Ϣ
          FOR branch_pos IN branch_cursor LOOP
              -- 2.1.2 ������ݼ�¼
              subordinate := branch_pos.ACCOUNT;         -- �¼���½�˺�
              userName := branch_pos.CHS_NAME;           -- �û�����
              subID := branch_pos.ID;                    -- ��¼ID
              -- 2.1.3 ��ʼ������
              turnover := 0;                  -- �ɽ�����
              amount := 0;                    -- Ͷע�ܶ�
              validAmount := 0;               -- ��Ч���
              memberAmount := 0;              -- ��Ա��Ӯ
              subordinateAmount := 0;         -- Ӧ������
              memberBackWater := 0;           -- ��Ա��ˮ
              winBackWater := 0;              -- ׬ȡ��ˮ
              realResult := 0;                -- ʵռ���
              winBackWaterResult := 0;        -- ׬ˮ����
              paySuperior := 0;               -- Ӧ���ϼ�
              rate := 0;                      -- ռ��
              recNum := 0;

              -- 3.3 ��ʼ���洢��������Ӧ�ļ�����Ӷ��ռ�ɡ��¼�Ӧ��
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- ׬ȡ��ˮ
              winCommissionBranch := 0;
              winCommissionGenAgent := 0;
              winCommissionStockholder := 0;
              winCommissionAgent := 0;
              winCommissionMember := 0;

              rateChief := 0;
              rateBranch := 0;
              rateGenAgent := 0;
              rateStockholder := 0;
              rateAgent := 0;

              moneyRateChief := 0;
              moneyRateBranch := 0;
              moneyRateGenAgent := 0;
              moneyRateStockholder := 0;
              moneyRateAgent := 0;

              subordinateChief := 0;
              subordinateBranch := 0;
              subordinateStockholder := 0;
              subordinateGenAgent := 0;
              subordinateAgent := 0;
              rate := 0;
              rateChiefSet := 0;
              rateBranchSet := 0;
              rateStockholderSet := 0;
              rateGenAgentSet := 0;
              rateAgentSet := 0;

              commissionBranchSet := 0;
              commissionStockholderSet := 0;
              commissionGenAgentSet := 0;
              commissionAgentSet := 0;

              -- 2.1.4 ���ùɶ����ձ���洢����
              Delivery_Report_Branch(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportBranch);
              -- ��ȡ�����ձ���洢�������γɵ�����
              declare
              cursor report_branch_cursor
              IS
              -- ���˵��¼��û���Ӧ�Ĳ�����Ϣ
              -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = branch_pos.ID AND t.USER_TYPE NOT IN ('g','f','e','d');

              BEGIN
              FOR report_branch_pos IN report_branch_cursor LOOP

                  -- ��Ա��ˮ
                  memberBackWater := report_branch_pos.COMMISSION_BRANCH + report_branch_pos.COMMISSION_STOCKHOLDER + report_branch_pos.COMMISSION_GEN_AGENT + report_branch_pos.COMMISSION_AGENT + report_branch_pos.COMMISSION_MEMBER;
                  -- Ӧ�����ߣ�ֱ�Ӷ�ȡ����������ı���������ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  -- subordinateAmount := report_branch_pos.RATE_CHIEF + report_branch_pos.RATE_BRANCH + report_branch_pos.RATE_STOCKHOLDER + report_branch_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_branch_pos.SUBORDINATE_CHIEF;
                  -- ʵռ�����ֱ�Ӷ�ȡ����������Ĺɶ�ռ�ɽ�����˴����ܼ��㣬��Ϊ��ͬ��Ͷעռ��ֵ��ͬ��
                  realResult := report_branch_pos.RATE_CHIEF;
                  -- ׬ȡ��ˮ
                  winBackWater := 0;
                  -- ׬ˮ������ʵռ���-׬ȡ��ˮ��
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- Ӧ�����ߣ�Ӧ�����ߣ�׬ˮ������
                  paySuperior := subordinateAmount - winBackWaterResult;

                  moneyRateChief_total := moneyRateChief_total + report_branch_pos.MONEY_RATE_CHIEF;
                  moneyRateBranch_total := moneyRateBranch_total + report_branch_pos.MONEY_RATE_BRANCH;
                  moneyRateGenAgent_total := moneyRateGenAgent_total + report_branch_pos.MONEY_RATE_GEN_AGENT;
                  moneyRateStockholder_total := moneyRateStockholder_total + report_branch_pos.MONEY_RATE_STOCKHOLDER;
                  moneyRateAgent_total := moneyRateAgent_total + report_branch_pos.MONEY_RATE_AGENT;

                  subordinateChief := report_branch_pos.SUBORDINATE_CHIEF;
                  subordinateBranch := report_branch_pos.SUBORDINATE_BRANCH;
                  subordinateStockholder := report_branch_pos.SUBORDINATE_STOCKHOLDER;
                  subordinateGenAgent := report_branch_pos.SUBORDINATE_GEN_AGENT;
                  subordinateAgent := report_branch_pos.SUBORDINATE_AGENT;

                  -- ռ������ֵ
                  rateChiefSet := report_branch_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_branch_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_branch_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_branch_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_branch_pos.RATE_AGENT_SET;

                  -- ��ˮ����ֵ
                  commissionBranchSet := report_branch_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_branch_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_branch_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_branch_pos.COMMISSION_AGENT_SET;

                  rate := report_branch_pos.RATE_CHIEF_SET;
                  -- ��ֵ��TODO �����������������Ͷע����֮ǰ�����Ƿ��������
                  turnover := report_branch_pos.TURNOVER;          -- �ɽ�����
                  amount := report_branch_pos.AMOUNT;              -- Ͷע�ܶ�
                  validAmount := report_branch_pos.VALID_AMOUNT;   -- ��Ч���
                  memberAmount := report_branch_pos.MEMBER_AMOUNT; -- ��Ա��Ӯ

                  -- 2.1.4.1 ���ݲ�����ʱ��
                  INSERT INTO TEMP_DELIVERYREPORT
                      (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
                      COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
                      SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
                      RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
                      COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
                      MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
                  VALUES (
                      userID,
                      branch_pos.ID,
                      '3',
                      branch_pos.ACCOUNT,
                      branch_pos.CHS_NAME,
                      turnover,
                      amount,
                      validAmount,
                      memberAmount,
                      memberBackWater,
                      subordinateAmount,
                      winBackWater,
                      realResult,
                      winBackWaterResult,
                      paySuperior,
                      report_branch_pos.COMMISSION_BRANCH, report_branch_pos.COMMISSION_GEN_AGENT, report_branch_pos.COMMISSION_STOCKHOLDER, report_branch_pos.COMMISSION_AGENT, report_branch_pos.COMMISSION_MEMBER, report_branch_pos.WIN_COMMISSION_BRANCH, report_branch_pos.WIN_COMMISSION_GEN_AGENT, report_branch_pos.WIN_COMMISSION_STOCKHOLDER, report_branch_pos.WIN_COMMISSION_AGENT, report_branch_pos.WIN_COMMISSION_MEMBER, report_branch_pos.RATE_CHIEF, report_branch_pos.RATE_BRANCH, report_branch_pos.RATE_GEN_AGENT, report_branch_pos.RATE_STOCKHOLDER, report_branch_pos.RATE_AGENT,
                      rate,
                      subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent,
                      rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
                      commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
                      moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent
                      );

                   -- 2.1.4.2 �ۼ��ܶ�
                   turnover_total := turnover_total + report_branch_pos.TURNOVER;
                   amount_total := amount_total + report_branch_pos.AMOUNT;
                   validAmount_total := validAmount_total + report_branch_pos.VALID_AMOUNT;
                   memberAmount_total := memberAmount_total + report_branch_pos.MEMBER_AMOUNT;
                   memberBackWater_total := memberBackWater_total + memberBackWater;
                   subordinateAmount_total := subordinateAmount_total + subordinateAmount;
                   winBackWater_total := winBackWater_total + winBackWater;
                   realResult_total := realResult_total + realResult;
                   winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
                   paySuperior_total := paySuperior_total + paySuperior;

                   -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
                   commissionBranch_total := commissionBranch_total + report_branch_pos.COMMISSION_BRANCH;
                   commissionGenAgent_total := commissionGenAgent_total + report_branch_pos.COMMISSION_GEN_AGENT;
                   commissionStockholder_total := commissionStockholder_total + report_branch_pos.COMMISSION_STOCKHOLDER;
                   commissionAgent_total := commissionAgent_total + report_branch_pos.COMMISSION_AGENT;
                   commissionMember_total := commissionMember_total + report_branch_pos.COMMISSION_MEMBER;

                   winCommissionBranch_total := winCommissionBranch_total + report_branch_pos.WIN_COMMISSION_BRANCH;
                   winCommissionGenAgent_total := winCommissionGenAgent_total + report_branch_pos.WIN_COMMISSION_GEN_AGENT;
                   winCommissionStockholder_total := winCommissionStockholder_total + report_branch_pos.WIN_COMMISSION_STOCKHOLDER;
                   winCommissionAgent_total := winCommissionAgent_total + report_branch_pos.WIN_COMMISSION_AGENT;
                   winCommissionMember_total := winCommissionMember_total + report_branch_pos.WIN_COMMISSION_MEMBER;

                   rateChief_total := rateChief_total + report_branch_pos.RATE_CHIEF;
                   rateBranch_total := rateBranch_total + report_branch_pos.RATE_BRANCH;
                   rateGenAgent_total := rateGenAgent_total + report_branch_pos.RATE_GEN_AGENT;
                   rateStockholder_total := rateStockholder_total + report_branch_pos.RATE_STOCKHOLDER;
                   rateAgent_total := rateAgent_total + report_branch_pos.RATE_AGENT;

                   -- ʵռע��
                   moneyRateChief_total := moneyRateChief_total + moneyRateChief;
                   moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
                   moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
                   moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
                   moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

                   subordinateChief_total := subordinateChief_total + subordinateChief;
                   subordinateBranch_total := subordinateBranch_total + subordinateBranch;
                   subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
                   subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
                   subordinateAgent_total := subordinateAgent_total + subordinateAgent;

                   -- ռ������ֵ
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 ɾ����Ч��ʱ����
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = branch_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** �ܼ��Ӧ��ֱ����Ա���� ��ʼ ********/
      -- ����ֱ����Ա���ձ���洢����
      Delivery_Report_Dir_Member(userID, '2', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- ��ѯֱ����Աͳ������
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- �ۼ�ֱ����Աͳ������
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 �ۼ��ܶ�
               turnover_total := turnover_total + dir_total_pos.TURNOVER;
               amount_total := amount_total + dir_total_pos.AMOUNT;
               validAmount_total := validAmount_total + dir_total_pos.VALID_AMOUNT;
               memberAmount_total := memberAmount_total + dir_total_pos.MEMBER_AMOUNT;
               memberBackWater_total := memberBackWater_total + dir_total_pos.MEMBER_BACK_WATER;
               subordinateAmount_total := subordinateAmount_total + dir_total_pos.SUBORDINATE_AMOUNT;
               winBackWater_total := winBackWater_total + dir_total_pos.WIN_BACK_WATER;
               realResult_total := realResult_total + dir_total_pos.REAL_RESULT;
               winBackWaterResult_total := winBackWaterResult_total + dir_total_pos.WIN_BACK_WATER_RESULT;
               paySuperior_total := paySuperior_total + dir_total_pos.PAY_SUPERIOR;

               -- 2.1.5. ��ȡ��������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
               commissionBranch_total := commissionBranch_total + dir_total_pos.COMMISSION_BRANCH;
               commissionGenAgent_total := commissionGenAgent_total + dir_total_pos.COMMISSION_GEN_AGENT;
               commissionStockholder_total := commissionStockholder_total + dir_total_pos.COMMISSION_STOCKHOLDER;
               commissionAgent_total := commissionAgent_total + dir_total_pos.COMMISSION_AGENT;
               commissionMember_total := commissionMember_total + dir_total_pos.COMMISSION_MEMBER;

               winCommissionBranch_total := winCommissionBranch_total + dir_total_pos.WIN_COMMISSION_BRANCH;
               winCommissionGenAgent_total := winCommissionGenAgent_total + dir_total_pos.WIN_COMMISSION_GEN_AGENT;
               winCommissionStockholder_total := winCommissionStockholder_total + dir_total_pos.WIN_COMMISSION_STOCKHOLDER;
               winCommissionAgent_total := winCommissionAgent_total + dir_total_pos.WIN_COMMISSION_AGENT;
               winCommissionMember_total := winCommissionMember_total + dir_total_pos.WIN_COMMISSION_MEMBER;

               rateChief_total := rateChief_total + dir_total_pos.RATE_CHIEF;
               rateBranch_total := rateBranch_total + dir_total_pos.RATE_BRANCH;
               rateGenAgent_total := rateGenAgent_total + dir_total_pos.RATE_GEN_AGENT;
               rateStockholder_total := rateStockholder_total + dir_total_pos.RATE_STOCKHOLDER;
               rateAgent_total := rateAgent_total + dir_total_pos.RATE_AGENT;

               moneyRateChief_total := moneyRateChief_total + dir_total_pos.MONEY_RATE_CHIEF;
               moneyRateBranch_total := moneyRateBranch_total + dir_total_pos.MONEY_RATE_BRANCH;
               moneyRateGenAgent_total := moneyRateGenAgent_total + dir_total_pos.MONEY_RATE_GEN_AGENT;
               moneyRateStockholder_total := moneyRateStockholder_total + dir_total_pos.MONEY_RATE_STOCKHOLDER;
               moneyRateAgent_total := moneyRateAgent_total + dir_total_pos.MONEY_RATE_AGENT;

               subordinateChief_total := subordinateChief_total + dir_total_pos.SUBORDINATE_CHIEF;
               subordinateBranch_total := subordinateBranch_total + dir_total_pos.SUBORDINATE_BRANCH;
               subordinateStockholder_total := subordinateStockholder_total + dir_total_pos.SUBORDINATE_STOCKHOLDER;
               subordinateGenAgent_total := subordinateGenAgent_total + dir_total_pos.SUBORDINATE_GEN_AGENT;
               subordinateAgent_total := subordinateAgent_total + dir_total_pos.SUBORDINATE_AGENT;

               -- ռ������ֵ
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 ɾ����Ч��ʱ����
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;

      /******** �ܼ��Ӧ��ֱ����Ա���� ���� ********/

      /******** �������� ��ʼ ********/
      -- 6.2 ��ѯ�������ݣ�����������Ҫ�����淨���Ͳ�ѯ��
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- ֻ��ѯ�����˵Ĳ�������
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- �жϲ�Ʊ����
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- �㶫
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- ���
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- ����
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- ��ʼ��
      turnover_replenish := 0;                         -- ��������
      amount_replenish := 0;                           -- ����Ͷע�ܶ�
      validAmount_replenish :=0;                       -- ������Ч���
      amount_win_replenish := 0;                       -- ������Ӯ
      backWater_replenish := 0;                        -- ������ˮ
      backWaterResult_replenish := 0;                  -- ��ˮ����
      backWater_replenish_temp := 0;                   -- ������Ӯ����ʱ��
      amount_win_replenish_temp := 0;                  -- ������Ӯ����ʱ��

      -- ��ˮ�������
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- ʵռ���
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- ʵռע��
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- Ӧ������
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- ִ�в�ѯ�����α�
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- ���������˳�
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- �ۼӲ����ܶ�
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- �ۼӲ�������
               turnover_replenish := turnover_replenish + 1;

               -- ������Ӯ����Ӧ�ô������в������ܺ�(������ˮ)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- �ۼӡ��н�����Ͷע��
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_CHIEF / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- ��ȥ��δ�н�����Ͷע��
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_CHIEF / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- ������Ч����������
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO ��ˮ��Ҫ��ȫ���м������ˮ��Ϣ
               -- ������ˮ������Ӷ��*Ͷע����˴�ͣ������Ķ�Ҫ��ˮ��
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;

                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;

               -- ����ʵռע��
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  -- ʵռע���Ч��Ͷע��� * ռ��%��
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);
               END IF;

               -- ����򲻼���Ӷ����ˮ��������ֱ����Ա����
               -- IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  -- commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - 0) / 100);

                  -- ʵռ�������ˮ������Ҳ���� ��ˮ + ��Ӯ��*ռ��%
                  -- rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;

                  -- ����Ӧ������
                  -- subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * (1);
               -- END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- ������ˮ��������ˮ + ��Ӯ��
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. �������ݲ�����ʱ�������������ͣ������ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + a�������ʵ��ֵΪ1�������ֵ b��ʵ��ֵΪ0�������a��
      -- c��2�ܼࣩ��d��3�ֹ�˾����e��4�ɶ�����f��5�ܴ�����g��6������h��7���˺ţ�
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'c', '1', '����', '����', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. �ۼ��ܶ���Ӳ������ݣ�
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;

      -- 6. �ۻ�������������Ӧ�ļ�����Ӷ��ռ�ɣ��ܶ
      commissionBranch_total := commissionBranch_total + commissionBranch;
      commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
      commissionStockholder_total := commissionStockholder_total + commissionStockholder;
      commissionAgent_total := commissionAgent_total + commissionAgent;

      winCommissionBranch_total := winCommissionBranch_total + winCommissionBranch;
      winCommissionGenAgent_total := winCommissionGenAgent_total + winCommissionGenAgent;
      winCommissionStockholder_total := winCommissionStockholder_total + winCommissionStockholder;
      winCommissionAgent_total := winCommissionAgent_total + winCommissionAgent;

      rateChief_total := rateChief_total + rateChief;
      rateBranch_total := rateBranch_total + rateBranch;
      rateGenAgent_total := rateGenAgent_total + rateGenAgent;
      rateStockholder_total := rateStockholder_total + rateStockholder;
      rateAgent_total := rateAgent_total + rateAgent;

      -- ʵռע��
      moneyRateChief_total := moneyRateChief_total + moneyRateChief;
      moneyRateBranch_total := moneyRateBranch_total + moneyRateBranch;
      moneyRateGenAgent_total := moneyRateGenAgent_total + moneyRateGenAgent;
      moneyRateStockholder_total := moneyRateStockholder_total + moneyRateStockholder;
      moneyRateAgent_total := moneyRateAgent_total + moneyRateAgent;

      subordinateChief_total := subordinateChief_total + subordinateChief;
      subordinateBranch_total := subordinateBranch_total + subordinateBranch;
      subordinateGenAgent_total := subordinateGenAgent_total + subordinateGenAgent;
      subordinateStockholder_total := subordinateStockholder_total + subordinateStockholder;
      subordinateAgent_total := subordinateAgent_total + subordinateAgent;
      /******** �������� ���� ********/

      -- 4. �ܶ����ݲ�����ʱ��Ϊ���������ܶ����ݶ�Ӧ�� USER_TYPE Ϊʵ��ֵ + A�������ʵ��ֵΪ1�������ֵ B��
      -- C��2�ܼࣩ��D��3�ֹ�˾����E��4�ɶ�����F��5�ܴ�����G��6������H��7���˺ţ�
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'C', '', '�ϼƣ�', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. ����ʱ���в�ѯ����
      OPEN statReportBranch
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. ���ý�����ɹ�������������
      resultFlag := 0;
END;
/


spool off
