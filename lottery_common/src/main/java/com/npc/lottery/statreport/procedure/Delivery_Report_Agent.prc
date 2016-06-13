CREATE OR REPLACE PROCEDURE Delivery_Report_Agent(
/*==============================================================*/
/*                  �����ձ���洢����                        */
/*==============================================================*/
     userID IN varchar2,                -- ����ID
     lotteryType IN varchar2,           -- ��Ʊ����
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
              IF lotteryType = 'ALL' OR lotteryType = 'GDKLSF' THEN

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
              IF lotteryType = 'ALL' OR lotteryType = 'CQSSC' THEN

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
              IF lotteryType = 'ALL' OR lotteryType = 'HKLHC' THEN

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
              IF lotteryType = 'ALL' OR lotteryType = 'BJSC' THEN

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
      IF lotteryType = 'GDKLSF' THEN
         -- �㶫����ʮ��
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF lotteryType = 'HKLHC' THEN
         -- ������ϲ�
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF lotteryType = 'CQSSC' THEN
         -- ����ʱʱ��
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;
      IF lotteryType = 'BJSC' THEN
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
