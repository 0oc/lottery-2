CREATE OR REPLACE PROCEDURE Delivery_Report_Gen_Agent(
/*==============================================================*/
/*                  �ܴ����ձ���洢����                      */
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
              Delivery_Report_Agent(subID, lotteryType, playType, periodsNum, startDate, endDate, resultFlag, statReportAgent);
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
      Delivery_Report_Dir_Member(userID, '5', lotteryType, playType, periodsNum, startDate, endDate, resultFlag);
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
      IF lotteryType = 'GDKLSF' THEN
         -- �㶫
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF lotteryType = 'HKLHC' THEN
         -- ���
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF lotteryType = 'CQSSC' THEN
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
