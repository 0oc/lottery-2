﻿--------------------------------------------
-- Export file        --
-- Created by Eric on 2013/4/17, 15:31:15 --
--------------------------------------------

spool proc.log

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
/*                  代理交收报表存储过程                        */
/*==============================================================*/
     userID IN varchar2,                -- 代理ID
     LOTTERY1688Type IN varchar2,           -- 彩票种类
     playType IN varchar2,              -- 下注类型
     periodsNum IN varchar2,            -- 期数
     startDate IN varchar2,             -- 开始时间
     endDate IN varchar2,               -- 结束时间
     resultFlag OUT varchar2,           -- 存储执行结果值：0-成功；1-userID为空；2-数据为空; 9-未知错误
     statReportAgent OUT statReportResult.resultRef         -- 返回结果集
) AS
     subordinate varchar2(50);          -- 下级登陆账号
     userName varchar2(50);             -- 用户名称
     turnover_gdklsf NUMBER;            -- 成交笔数（广东快乐十分）
     turnover_cqssc NUMBER;             -- 成交笔数（重庆时时彩）
     turnover_hklhc NUMBER;             -- 成交笔数（香港六合彩）
     turnover_bjsc NUMBER;              -- 成交笔数（北京赛车）
     amount NUMBER;                     -- 投注总额
     validAmount NUMBER;                -- 有效金额
     memberAmount NUMBER;               -- 会员输赢
     memberBackWater NUMBER;            -- 会员退水
     subordinateAmount NUMBER;          -- 应收下线
     winBackWater NUMBER;               -- 赚取退水
     realResult NUMBER;                 -- 实占结果
     winBackWaterResult NUMBER;         -- 赚水后结果
     paySuperior NUMBER;                -- 应付上级
     subID NUMBER;                      -- 记录ID
     memberAmount_temp NUMBER;          -- 临时变量，存储会员输赢数据
     memberBackWater_temp NUMBER;       -- 临时变量，会员退水
     recNum NUMBER;                     -- 临时变量，记录数

     -- 定义游标
     type   mycursor   is   ref   cursor;

     sql_str varchar2(2000);                    -- 临时SQL语句

     sql_gdklsf varchar2(2000);                 -- 广东快乐十分查询 sql
     cursor_his_gdklsf  mycursor;               -- 广东快乐十分游标
     member_pos_gdklsf TB_GDKLSF_HIS%rowtype;   -- 广东快乐十分数据对象

     sql_cqssc varchar2(2000);                  -- 重庆时时彩查询 sql
     cursor_his_cqssc  mycursor;                -- 重庆时时彩游标
     member_pos_cqssc TB_CQSSC_HIS%rowtype;     -- 重庆时时彩数据对象

     sql_hklhc varchar2(2000);                  -- 香港六合彩查询 sql
     cursor_his_hklhc  mycursor;                -- 香港六合彩游标
     member_pos_hklhc TB_HKLHC_HIS%rowtype;     -- 香港六合彩数据对象

     sql_bjsc varchar2(2000);                   -- 北京赛车查询 sql
     cursor_his_bjsc  mycursor;                 -- 北京赛车游标
     member_pos_bjsc TB_BJSC_HIS%rowtype;       -- 北京赛车数据对象

     sql_replenish varchar2(2000);              -- 补货查询 sql
     cursor_replenish mycursor;                 -- 补货游标
     member_pos_replenish TB_REPLENISH%rowtype; -- 补货数据对象
     turnover_replenish NUMBER;                 -- 补货笔数
     amount_replenish NUMBER;                   -- 补货投注总额
     validAmount_replenish NUMBER;              -- 补货有效金额
     amount_win_replenish NUMBER;               -- 补货输赢
     backWater_replenish NUMBER;                -- 补货退水
     backWaterResult_replenish NUMBER;          -- 退水后结果
     backWater_replenish_temp NUMBER;           -- 补货退水（临时）
     amount_win_replenish_temp NUMBER;          -- 补货输赢（临时）

     -- 总额统计值
     turnover_total NUMBER;             -- 成交笔数（总额）
     amount_total NUMBER;               -- 投注总额（总额）
     validAmount_total NUMBER;          -- 有效金额（总额）
     memberAmount_total NUMBER;         -- 会员输赢（总额）
     memberBackWater_total NUMBER;      -- 会员退水（总额）
     subordinateAmount_total NUMBER;    -- 应收下线（总额）
     winBackWater_total NUMBER;         -- 赚取退水（总额）
     realResult_total NUMBER;           -- 实占结果（总额）
     winBackWaterResult_total NUMBER;   -- 赚水后结果（总额）
     paySuperior_total NUMBER;          -- 应付上级（总额）

     -- 存储上线所对应的计算后的佣金、占成、下线应收
     commissionBranch NUMBER;           -- 分公司佣金
     commissionGenAgent NUMBER;         -- 总代理佣金
     commissionStockholder NUMBER;      -- 股东佣金
     commissionAgent NUMBER;            -- 代理佣金
     commissionMember NUMBER;           -- 会员佣金

     winCommissionBranch NUMBER;           -- 分公司赚取佣金
     winCommissionGenAgent NUMBER;         -- 总代理赚取佣金
     winCommissionStockholder NUMBER;      -- 股东赚取佣金
     winCommissionAgent NUMBER;            -- 代理赚取佣金
     winCommissionMember NUMBER;           -- 会员赚取佣金

     rateChief NUMBER;                  -- 总监占成
     rateBranch NUMBER;                 -- 分公司占成
     rateGenAgent NUMBER;               -- 总代理占成
     rateStockholder NUMBER;            -- 股东占成
     rateAgent NUMBER;                  -- 代理占成

     moneyRateChief NUMBER;             -- 总监实占注额
     moneyRateBranch NUMBER;            -- 分公司实占注额
     moneyRateGenAgent NUMBER;          -- 总代理实占注额
     moneyRateStockholder NUMBER;       -- 股东实占注额
     moneyRateAgent NUMBER;             -- 代理实占注额

     subordinateChief NUMBER;           -- 下线应收（总监）
     subordinateBranch NUMBER;          -- 下线应收（分公司）
     subordinateStockholder NUMBER;     -- 下线应收（股东）
     subordinateGenAgent NUMBER;        -- 下线应收（总代理）
     subordinateAgent NUMBER;           -- 下线应收（代理）
     rate NUMBER;                       -- 占成设置值
     rateChiefSet NUMBER;               -- 总监占成设置值
     rateBranchSet NUMBER;              -- 分公司占成设置值
     rateStockholderSet NUMBER;         -- 股东占成设置值
     rateGenAgentSet NUMBER;            -- 总代理占成设置值
     rateAgentSet NUMBER;               -- 代理占成设置值
     commissionBranchSet NUMBER;        -- 分公司退水设置值
     commissionStockholderSet NUMBER;   -- 股东退水设置值
     commissionGenAgentSet NUMBER;      -- 总代理退水设置值
     commissionAgentSet NUMBER;         -- 代理退水设置值

     -- 存储上线所对应的计算后的佣金、占成、下线应收（总额）
     commissionBranch_total NUMBER;           -- 分公司佣金（总额）
     commissionGenAgent_total NUMBER;         -- 总代理佣金（总额）
     commissionStockholder_total NUMBER;      -- 股东佣金（总额）
     commissionAgent_total NUMBER;            -- 代理佣金（总额）
     commissionMember_total NUMBER;           -- 会员佣金（总额）

     winCommissionBranch_total NUMBER;           -- 分公司赚取佣金（总额）
     winCommissionGenAgent_total NUMBER;         -- 总代理赚取佣金（总额）
     winCommissionStockholder_total NUMBER;      -- 股东赚取佣金（总额）
     winCommissionAgent_total NUMBER;            -- 代理赚取佣金（总额）
     winCommissionMember_total NUMBER;           -- 会员赚取佣金（总额）

     rateChief_total NUMBER;                  -- 总监占成（总额）
     rateBranch_total NUMBER;                 -- 分公司占成（总额）
     rateGenAgent_total NUMBER;               -- 总代理占成（总额）
     rateStockholder_total NUMBER;            -- 股东占成（总额）
     rateAgent_total NUMBER;                  -- 代理占成（总额）

     moneyRateChief_total NUMBER;                  -- 总监实占注额（总额）
     moneyRateBranch_total NUMBER;                 -- 分公司实占注额（总额）
     moneyRateGenAgent_total NUMBER;               -- 总代理实占注额（总额）
     moneyRateStockholder_total NUMBER;            -- 股东实占注额（总额）
     moneyRateAgent_total NUMBER;                  -- 代理实占注额（总额）

     subordinateChief_total NUMBER;           -- 下线应收（总监）
     subordinateBranch_total NUMBER;          -- 下线应收（分公司）
     subordinateStockholder_total NUMBER;     -- 下线应收（股东）
     subordinateGenAgent_total NUMBER;        -- 下线应收（总代理）
     subordinateAgent_total NUMBER;           -- 下线应收（代理）

     -- 占成设置值只取最后一个值，故总和值无效
     recNum_total NUMBER;                     -- 临时变量，有效会员数
     --rate_total NUMBER;                       -- 占成设置值（总和）
     --rateChiefSet_total NUMBER;               -- 总监占成设置值（总和）
     --rateBranchSet_total NUMBER;              -- 分公司占成设置值（总和）
     --rateStockholderSet_total NUMBER;         -- 股东占成设置值（总和）
     --rateGenAgentSet_total NUMBER;            -- 总代理占成设置值（总和）
     --rateAgentSet_total NUMBER;               -- 代理占成设置值（总和）

BEGIN
     -- 初始化返回结果值
     resultFlag := 0;

     -- 1.1 校验输入参数
     dbms_output.put_line('userID：'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 初始化总额
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

     -- 赚取退水
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

     -- 2. 查询代理对应的会员信息
     declare
     cursor agent_cursor
     IS
     SELECT * FROM
         (TB_MEMBER_STAFF_EXT ext INNER JOIN TB_FRAME_MEMBER_STAFF member ON ext.MEMBER_STAFF_ID = member.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1 删除临时表中的本级统计数据
          DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

          -- 2.2 循环处理所有的会员信息
          FOR agent_member_pos IN agent_cursor LOOP
              -- 3.1 填充数据记录
              subordinate := agent_member_pos.ACCOUNT;             -- 下级登陆账号
              userName := agent_member_pos.CHS_NAME;               -- 用户名称
              subID := agent_member_pos.ID;                        -- 记录ID

              -- 3.2 初始化数据
              turnover_gdklsf := 0;           -- 成交笔数（广东快乐十分）
              turnover_cqssc := 0;            -- 成交笔数（重庆时时彩）
              turnover_hklhc := 0;            -- 成交笔数（香港六合彩）
              turnover_bjsc := 0;             -- 成交笔数（北京赛车）
              amount := 0;                    -- 投注总额
              validAmount := 0;               -- 有效金额
              memberAmount := 0;              -- 会员输赢
              subordinateAmount := 0;         -- 应收下线
              memberBackWater := 0;           -- 会员退水
              winBackWater := 0;              -- 赚取退水
              realResult := 0;                -- 实占结果
              winBackWaterResult := 0;        -- 赚水后结果
              paySuperior := 0;               -- 应付上级
              recNum := 0;

              -- 3.3 初始化存储上线所对应的计算后的佣金、占成、下级应收
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

              /******** 广东快乐十分 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'GDKLSF' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_gdklsf := 'SELECT * FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_gdklsf := sql_gdklsf || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_gdklsf
              FOR
              sql_gdklsf;

              -- 统计投注笔数
              execute immediate sql_str into turnover_gdklsf;
              turnover_total := turnover_total + turnover_gdklsf;

              BEGIN
                   LOOP
                   FETCH cursor_his_gdklsf INTO member_pos_gdklsf;
                       -- 无数据则退出
                       IF (cursor_his_gdklsf%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_gdklsf.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_gdklsf.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_AGENT / 100);

                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_gdklsf.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_gdklsf.WIN_AMOUNT;
                          memberAmount_temp := member_pos_gdklsf.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_gdklsf.MONEY;
                          memberAmount_temp := - member_pos_gdklsf.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- 累积上级的占成
                       --            * ((member_pos_gdklsf.RATE_CHIEF + member_pos_gdklsf.RATE_BRANCH + member_pos_gdklsf.RATE_GEN_AGENT + member_pos_gdklsf.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_gdklsf.RATE_STOCKHOLDER/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);
                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * member_pos_gdklsf.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * member_pos_gdklsf.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * member_pos_gdklsf.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 - member_pos_gdklsf.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_gdklsf.RATE_AGENT ;-- 代理占成（只需要存最后一条记录的占成即可）
                       rateChiefSet := rateChiefSet + member_pos_gdklsf.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_gdklsf.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_gdklsf.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_gdklsf.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_gdklsf.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_gdklsf.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_gdklsf.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_gdklsf.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_gdklsf.COMMISSION_AGENT;

                   END LOOP;
                   CLOSE cursor_his_gdklsf;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接填充代理实占结果值
              realResult := rateAgent;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 广东快乐十分 结束 ********/

              /******** 重庆时时彩 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'CQSSC' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_cqssc := 'SELECT * FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_cqssc := sql_cqssc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_cqssc
              FOR
              sql_cqssc;

              -- 统计投注笔数
              execute immediate sql_str into turnover_cqssc;
              turnover_total := turnover_total + turnover_cqssc;

              BEGIN
                   LOOP
                   FETCH cursor_his_cqssc INTO member_pos_cqssc;
                       -- 无数据则退出
                       IF (cursor_his_cqssc%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_cqssc.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_cqssc.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100) * (1 - member_pos_cqssc.RATE_AGENT / 100);

                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_cqssc.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_cqssc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_cqssc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_cqssc.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_cqssc.MONEY;
                          memberAmount_temp := - member_pos_cqssc.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- 累积上级的占成
                       --            * ((member_pos_cqssc.RATE_CHIEF + member_pos_cqssc.RATE_BRANCH + member_pos_cqssc.RATE_GEN_AGENT + member_pos_cqssc.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_cqssc.RATE_STOCKHOLDER/100 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * member_pos_cqssc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * member_pos_cqssc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * member_pos_cqssc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * member_pos_cqssc.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100 - member_pos_cqssc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_cqssc.RATE_AGENT ;-- 代理占成（只需要存最后一条记录的占成即可）
                       rateChiefSet := rateChiefSet + member_pos_cqssc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_cqssc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_cqssc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_cqssc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_cqssc.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_cqssc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_cqssc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_cqssc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_cqssc.COMMISSION_AGENT;
                   END LOOP;
                   CLOSE cursor_his_cqssc;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接填充代理实占结果值
              realResult := rateAgent;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 重庆时时彩 结束 ********/

              /******** 香港六合彩 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'HKLHC' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_hklhc := 'SELECT * FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_hklhc := sql_hklhc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_hklhc
              FOR
              sql_hklhc;

              -- 统计投注笔数
              execute immediate sql_str into turnover_hklhc;
              turnover_total := turnover_total + turnover_hklhc;

              BEGIN
                   LOOP
                   FETCH cursor_his_hklhc INTO member_pos_hklhc;

                       -- 无数据则退出
                       IF (cursor_his_hklhc%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_hklhc.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_hklhc.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100) * (1 - member_pos_hklhc.RATE_AGENT / 100);

                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_hklhc.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_hklhc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_hklhc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_hklhc.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_hklhc.MONEY;
                          memberAmount_temp := - member_pos_hklhc.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                       -- 累积上级的占成
                       --            * ((member_pos_hklhc.RATE_CHIEF + member_pos_hklhc.RATE_BRANCH + member_pos_hklhc.RATE_GEN_AGENT + member_pos_hklhc.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_hklhc.RATE_STOCKHOLDER/100 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * member_pos_hklhc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * member_pos_hklhc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * member_pos_hklhc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * member_pos_hklhc.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100 - member_pos_hklhc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_hklhc.RATE_AGENT ;-- 代理占成（只需要存最后一条记录的占成即可）
                       rateChiefSet := rateChiefSet + member_pos_hklhc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_hklhc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_hklhc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_hklhc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_hklhc.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_hklhc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_hklhc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_hklhc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_hklhc.COMMISSION_AGENT;
                   END LOOP;
                   CLOSE cursor_his_hklhc;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接填充代理实占结果值
              realResult := rateAgent;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 香港六合彩 结束 ********/

              /******** 北京赛车 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'BJSC' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_bjsc := 'SELECT * FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_bjsc := sql_bjsc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_bjsc
              FOR
              sql_bjsc;

              -- 统计投注笔数
              execute immediate sql_str into turnover_bjsc;
              turnover_total := turnover_total + turnover_bjsc;

              BEGIN
                   LOOP
                   FETCH cursor_his_bjsc INTO member_pos_bjsc;
                       -- 无数据则退出
                       IF (cursor_his_bjsc%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_bjsc.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_bjsc.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100;
                          winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_AGENT / 100);

                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_bjsc.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_bjsc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_bjsc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_bjsc.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_bjsc.MONEY;
                          memberAmount_temp := - member_pos_bjsc.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- 累积上级的占成
                       --            * ((member_pos_bjsc.RATE_CHIEF + member_pos_bjsc.RATE_BRANCH + member_pos_bjsc.RATE_GEN_AGENT + member_pos_bjsc.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_bjsc.RATE_STOCKHOLDER/100 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * member_pos_bjsc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * member_pos_bjsc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * member_pos_bjsc.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * member_pos_bjsc.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100 - member_pos_bjsc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       winBackWaterResult := rateAgent - winBackWater;

                       rate := member_pos_bjsc.RATE_AGENT ;-- 代理占成（只需要存最后一条记录的占成即可）
                       rateChiefSet := rateChiefSet + member_pos_bjsc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_bjsc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_bjsc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_bjsc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_bjsc.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_bjsc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_bjsc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_bjsc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_bjsc.COMMISSION_AGENT;

                   END LOOP;
                   CLOSE cursor_his_bjsc;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接填充代理实占结果值
              realResult := rateAgent;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 北京赛车 结束 ********/

              -- 计算占成设置值的平均值
              IF (recNum > 0) THEN
                 rateChiefSet := rateChiefSet / recNum;
                 rateBranchSet := rateBranchSet / recNum;
                 rateStockholderSet := rateStockholderSet / recNum;
                 rateGenAgentSet := rateGenAgentSet / recNum;
                 rateAgentSet := rateAgentSet / recNum;

                 -- rate的值设置为代理的值
                 rate := rateAgentSet;
                 -- 累加有效投注会员数
                 recNum_total := recNum_total + 1;
                 -- 累加占着设置值的总值
                 --rate_total := rate_total + rate;
                 --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                 --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                 --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                 --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                 --rateAgentSet_total := rateAgentSet_total + rateAgentSet;
              END IF;

              -- 5. 累加总额
              amount_total := amount_total + amount;
              validAmount_total := validAmount_total + validAmount;
              memberAmount_total := memberAmount_total + memberAmount;
              memberBackWater_total := memberBackWater_total + memberBackWater;
              subordinateAmount_total := subordinateAmount_total + subordinateAmount;
              winBackWater_total := winBackWater_total + winBackWater;
              realResult_total := realResult_total + realResult;
              winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
              paySuperior_total := paySuperior_total + paySuperior;

              -- 6. 累积上线所对应的计算后的佣金、占成（总额）
              commissionBranch_total := commissionBranch_total + commissionBranch;
              commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
              commissionStockholder_total := commissionStockholder_total + commissionStockholder;
              commissionAgent_total := commissionAgent_total + commissionAgent;
              commissionMember_total := commissionMember_total + commissionMember;

              -- 赚取退水
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

              -- 如果成交笔数大于0，则保存数据
              IF ((turnover_gdklsf + turnover_cqssc + turnover_hklhc + turnover_bjsc) > 0) THEN

                 -- 7. 数据插入临时表
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

      -- 6.1 数据不存在（成交笔数为0）则返回
      IF (turnover_total < 1) THEN
         resultFlag := 2; -- 设置结果
         return;
      END IF;
      -- dbms_output.put_line('rateAgent_total：'||rateAgent_total);

      -- 计算占成设置值的平均值
      --IF (recNum_total > 0) THEN
      --   rate_total := rate_total / recNum_total;
      --   rateChiefSet_total := rateChiefSet_total / recNum_total;
      --   rateBranchSet_total := rateBranchSet_total / recNum_total;
      --   rateStockholderSet_total := rateStockholderSet_total / recNum_total;
      --   rateGenAgentSet_total := rateGenAgentSet_total / recNum_total;
      --   rateAgentSet_total := rateAgentSet_total / recNum_total;
      --END IF;

      /******** 补货数据 开始 ********/
      -- 6.2 查询补货数据（补货后续需要区分玩法类型查询）
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- 只查询结算了的补货数据
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- 判断彩票种类
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- 广东快乐十分
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- 香港六合彩
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- 重庆时时彩
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;
      IF LOTTERY1688Type = 'BJSC' THEN
         -- 北京赛车
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''BJSC_%'' ';
      END IF;

      -- 初始化
      turnover_replenish := 0;                         -- 补货笔数
      amount_replenish := 0;                           -- 补货投注总额
      validAmount_replenish :=0;                       -- 补货有效金额
      amount_win_replenish := 0;                       -- 补货输赢
      backWater_replenish := 0;                        -- 补货退水
      backWaterResult_replenish := 0;                  -- 退水后结果
      backWater_replenish_temp := 0;                   -- 补货输赢（临时）
      amount_win_replenish_temp := 0;                  -- 补货输赢（临时）

      -- 退水相关数据
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      -- 赚取佣金（退水）
      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- 实占结果
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- 实占注额
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- 应收下线
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- 执行查询，打开游标
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- 无数据则退出
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- 累加补货总额
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- 累加补货笔数
               turnover_replenish := turnover_replenish + 1;

               -- 补货输赢，对应该代理所有补货的总和(不计退水)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- 累加“中奖”的投注额
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- 减去“未中奖”的投注额
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- 补货有效金额，不计算打和
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO 退水需要补全所有级别的退水信息
               -- 补货退水（代理佣金*投注额，除了打和，其他的都要退水）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- 打和则不计算佣金（退水）（当做直属会员处理）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER) / 100);
                  commissionStockholder := commissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100);
                  commissionGenAgent := commissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - member_pos_replenish.COMMISSION_AGENT) / 100);
                  commissionAgent := commissionAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_AGENT - 0) / 100);

                  -- 赚取佣金（退水）
                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionStockholder := winCommissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionGenAgent := winCommissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - member_pos_replenish.COMMISSION_AGENT) / 100) * (1 - member_pos_replenish.RATE_AGENT/100);
                  winCommissionAgent := winCommissionAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_AGENT - member_pos_replenish.COMMISSION_MEMBER) / 100);
                  winCommissionMember := winCommissionMember + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_MEMBER - 0) / 100);

                  -- 实占结果（退水后结果，也即是 退水 + 输赢）*占成%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  rateBranch := rateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * member_pos_replenish.RATE_BRANCH/100;
                  rateStockholder := rateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * member_pos_replenish.RATE_STOCKHOLDER/100;
                  rateGenAgent := rateGenAgent + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100)) * member_pos_replenish.RATE_GEN_AGENT/100;

                  -- 实占注额（有效的投注金额 * 占成%）
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- 各级应收下线
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  subordinateBranch := subordinateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 - member_pos_replenish.RATE_STOCKHOLDER/100);
                  subordinateStockholder := subordinateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_replenish.RATE_GEN_AGENT/100);
                  subordinateGenAgent := subordinateGenAgent + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_AGENT / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- 补货退水后结果（退水 + 输赢）
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. 补货数据插入临时表（处理数据类型）（数据对应的 USER_TYPE 为实际值 + a，即如果实际值为1，则填充值 b，实际值为0，则填充a）
      -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
      IF (turnover_replenish > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT,
               COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
               MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
              (userID, userID, 'g', '1', '补货', '补货', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish,
              commissionBranch, commissionGenAgent, commissionStockholder, commissionAgent, commissionMember, winCommissionBranch, winCommissionGenAgent, winCommissionStockholder, winCommissionAgent, winCommissionMember, rateChief, rateBranch, rateGenAgent, rateStockholder, rateAgent, subordinateChief, subordinateBranch, subordinateStockholder, subordinateGenAgent, subordinateAgent,
              moneyRateChief, moneyRateBranch, moneyRateStockholder, moneyRateGenAgent, moneyRateAgent);
      END IF;

      -- 5. 累加总额（增加补货数据）
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;
      -- commissionAgent_total := commissionAgent_total + backWater_replenish; -- 增加代理补货退水

      -- 6. 累积补货上线所对应的计算后的佣金、占成（总额）
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
      /******** 补货数据 结束 ********/

      -- 6.3 总额数据插入临时表（为方便排序，总额数据对应的 USER_TYPE 为实际值 + A，即如果实际值为1，则填充值 B，实际值为0，则填充A）
      -- C（2总监）、D（3分公司）、E（4股东）、F（5总代理）、G（6代理）、H（7子账号）
      IF (turnover_total > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT, RATE, RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET, COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
        VALUES
            (userID, userID, 'G', '0', '', '合计：', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total, rate, rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet, commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;

      -- 7. 从临时表中查询数据
      OPEN statReportAgent
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 8. 设置结果（成功，正常结束）
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_DIR_MEMBER
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Dir_Member(
/*==============================================================*/
/*   直属会员交收报表存储过程（此存储过程提供其他管理用户调用） */
/*==============================================================*/
     userID IN varchar2,                -- 管理用户ID
     userType IN varchar2,              -- 管理用户类型
     LOTTERY1688Type IN varchar2,           -- 彩票种类
     playType IN varchar2,              -- 下注类型
     periodsNum IN varchar2,            -- 期数
     startDate IN varchar2,             -- 开始时间
     endDate IN varchar2,               -- 结束时间
     resultFlag OUT varchar2            -- 存储执行结果值：0-成功；1-userID为空；2-数据为空; 9-未知错误
) AS
     subordinate varchar2(50);          -- 下级登陆账号
     userName varchar2(50);             -- 用户名称
     turnover_gdklsf NUMBER;            -- 成交笔数（广东快乐十分）
     turnover_cqssc NUMBER;             -- 成交笔数（重庆时时彩）
     turnover_hklhc NUMBER;             -- 成交笔数（香港六合彩）
     turnover_bjsc NUMBER;              -- 成交笔数（北京赛车）
     amount NUMBER;                     -- 投注总额
     validAmount NUMBER;                -- 有效金额
     memberAmount NUMBER;               -- 会员输赢
     memberBackWater NUMBER;            -- 会员退水
     subordinateAmount NUMBER;          -- 应收下线
     winBackWater NUMBER;               -- 赚取退水
     realResult NUMBER;                 -- 实占结果
     winBackWaterResult NUMBER;         -- 赚水后结果
     paySuperior NUMBER;                -- 应付上级
     subID NUMBER;                      -- 记录ID
     memberAmount_temp NUMBER;          -- 临时变量，存储会员输赢数据
     memberBackWater_temp NUMBER;       -- 临时变量，会员退水
     recNum NUMBER;                     -- 临时变量，记录数

     -- 定义游标
     type   mycursor   is   ref   cursor;

     sql_str varchar2(2000);                    -- 临时SQL语句

     sql_gdklsf varchar2(2000);                 -- 广东快乐十分查询 sql
     cursor_his_gdklsf  mycursor;               -- 广东快乐十分游标
     member_pos_gdklsf TB_GDKLSF_HIS%rowtype;   -- 广东快乐十分数据对象

     sql_cqssc varchar2(2000);                  -- 重庆时时彩查询 sql
     cursor_his_cqssc  mycursor;                -- 重庆时时彩游标
     member_pos_cqssc TB_CQSSC_HIS%rowtype;     -- 重庆时时彩数据对象

     sql_hklhc varchar2(2000);                  -- 香港六合彩查询 sql
     cursor_his_hklhc  mycursor;                -- 香港六合彩游标
     member_pos_hklhc TB_HKLHC_HIS%rowtype;     -- 香港六合彩数据对象

     sql_bjsc varchar2(2000);                   -- 北京赛车十分查询 sql
     cursor_his_bjsc  mycursor;                 -- 北京赛车十分游标
     member_pos_bjsc TB_BJSC_HIS%rowtype;       -- 北京赛车十分数据对象

     sql_replenish varchar2(2000);              -- 补货查询 sql
     cursor_replenish mycursor;                 -- 补货游标
     member_pos_replenish TB_REPLENISH%rowtype; -- 补货数据对象
     turnover_replenish NUMBER;                 -- 补货笔数
     amount_replenish NUMBER;                   -- 补货投注总额
     validAmount_replenish NUMBER;              -- 补货有效金额
     amount_win_replenish NUMBER;               -- 补货输赢
     backWater_replenish NUMBER;                -- 补货退水
     backWaterResult_replenish NUMBER;          -- 退水后结果
     backWater_replenish_temp NUMBER;           -- 补货退水（临时）
     amount_win_replenish_temp NUMBER;          -- 补货输赢（临时）

     -- 总额统计值
     turnover_total NUMBER;             -- 成交笔数（总额）
     amount_total NUMBER;               -- 投注总额（总额）
     validAmount_total NUMBER;          -- 有效金额（总额）
     memberAmount_total NUMBER;         -- 会员输赢（总额）
     memberBackWater_total NUMBER;      -- 会员退水（总额）
     subordinateAmount_total NUMBER;    -- 应收下线（总额）
     winBackWater_total NUMBER;         -- 赚取退水（总额）
     realResult_total NUMBER;           -- 实占结果（总额）
     winBackWaterResult_total NUMBER;   -- 赚水后结果（总额）
     paySuperior_total NUMBER;          -- 应付上级（总额）

     -- 存储上线所对应的计算后的佣金、占成、下线应收
     commissionBranch NUMBER;           -- 分公司佣金
     commissionGenAgent NUMBER;         -- 总代理佣金
     commissionStockholder NUMBER;      -- 股东佣金
     commissionAgent NUMBER;            -- 代理佣金
     commissionMember NUMBER;           -- 会员佣金

     winCommissionBranch NUMBER;           -- 分公司赚取佣金
     winCommissionGenAgent NUMBER;         -- 总代理赚取佣金
     winCommissionStockholder NUMBER;      -- 股东赚取佣金
     winCommissionAgent NUMBER;            -- 代理赚取佣金
     winCommissionMember NUMBER;           -- 会员赚取佣金

     rateChief NUMBER;                  -- 总监占成
     rateBranch NUMBER;                 -- 分公司占成
     rateGenAgent NUMBER;               -- 总代理占成
     rateStockholder NUMBER;            -- 股东占成
     rateAgent NUMBER;                  -- 代理占成

     moneyRateChief NUMBER;             -- 总监实占注额
     moneyRateBranch NUMBER;            -- 分公司实占注额
     moneyRateGenAgent NUMBER;          -- 总代理实占注额
     moneyRateStockholder NUMBER;       -- 股东实占注额
     moneyRateAgent NUMBER;             -- 代理实占注额

     subordinateChief NUMBER;           -- 下线应收（总监）
     subordinateBranch NUMBER;          -- 下线应收（分公司）
     subordinateStockholder NUMBER;     -- 下线应收（股东）
     subordinateGenAgent NUMBER;        -- 下线应收（总代理）
     subordinateAgent NUMBER;           -- 下线应收（代理）
     rate NUMBER;                       -- 占成设置值
     rateChiefSet NUMBER;               -- 总监占成设置值
     rateBranchSet NUMBER;              -- 分公司占成设置值
     rateStockholderSet NUMBER;         -- 股东占成设置值
     rateGenAgentSet NUMBER;            -- 总代理占成设置值
     rateAgentSet NUMBER;               -- 代理占成设置值

     commissionBranchSet NUMBER;        -- 分公司退水设置值
     commissionStockholderSet NUMBER;   -- 股东退水设置值
     commissionGenAgentSet NUMBER;      -- 总代理退水设置值
     commissionAgentSet NUMBER;         -- 代理退水设置值

     -- 存储上线所对应的计算后的佣金、占成、下线应收（总额）
     commissionBranch_total NUMBER;           -- 分公司佣金（总额）
     commissionGenAgent_total NUMBER;         -- 总代理佣金（总额）
     commissionStockholder_total NUMBER;      -- 股东佣金（总额）
     commissionAgent_total NUMBER;            -- 代理佣金（总额）
     commissionMember_total NUMBER;           -- 会员佣金（总额）

     winCommissionBranch_total NUMBER;           -- 分公司赚取佣金（总额）
     winCommissionGenAgent_total NUMBER;         -- 总代理赚取佣金（总额）
     winCommissionStockholder_total NUMBER;      -- 股东赚取佣金（总额）
     winCommissionAgent_total NUMBER;            -- 代理赚取佣金（总额）
     winCommissionMember_total NUMBER;           -- 会员赚取佣金（总额）

     rateChief_total NUMBER;                  -- 总监占成（总额）
     rateBranch_total NUMBER;                 -- 分公司占成（总额）
     rateGenAgent_total NUMBER;               -- 总代理占成（总额）
     rateStockholder_total NUMBER;            -- 股东占成（总额）
     rateAgent_total NUMBER;                  -- 代理占成（总额）

     moneyRateChief_total NUMBER;                  -- 总监实占注额（总额）
     moneyRateBranch_total NUMBER;                 -- 分公司实占注额（总额）
     moneyRateGenAgent_total NUMBER;               -- 总代理实占注额（总额）
     moneyRateStockholder_total NUMBER;            -- 股东实占注额（总额）
     moneyRateAgent_total NUMBER;                  -- 代理实占注额（总额）

     subordinateChief_total NUMBER;           -- 下线应收（总监）
     subordinateBranch_total NUMBER;          -- 下线应收（分公司）
     subordinateStockholder_total NUMBER;     -- 下线应收（股东）
     subordinateGenAgent_total NUMBER;        -- 下线应收（总代理）
     subordinateAgent_total NUMBER;           -- 下线应收（代理）

     -- 占成设置值只取最后一个值，故总和值无效
     recNum_total NUMBER;                     -- 临时变量，有效会员数
     --rate_total NUMBER;                       -- 占成设置值（总和）
     --rateChiefSet_total NUMBER;               -- 总监占成设置值（总和）
     --rateBranchSet_total NUMBER;              -- 分公司占成设置值（总和）
     --rateStockholderSet_total NUMBER;         -- 股东占成设置值（总和）
     --rateGenAgentSet_total NUMBER;            -- 总代理占成设置值（总和）
     --rateAgentSet_total NUMBER;               -- 代理占成设置值（总和）

BEGIN
     -- 初始化返回结果值
     resultFlag := 0;

     -- 1.1 校验输入参数
     dbms_output.put_line('userID：'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 初始化总额
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

     -- 赚取退水
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

     -- 2 查询管理对应的直属会员信息
      declare
      cursor directly_cursor
      IS
      SELECT * FROM
         (TB_MEMBER_STAFF_EXT ext INNER JOIN TB_FRAME_MEMBER_STAFF member ON ext.MEMBER_STAFF_ID = member.ID)
      WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.2 循环处理所有的会员信息
          FOR dir_member_pos IN directly_cursor LOOP
              -- 3.1 填充数据记录
              subordinate := dir_member_pos.ACCOUNT;             -- 下级登陆账号
              userName := dir_member_pos.CHS_NAME;               -- 用户名称
              subID := dir_member_pos.ID;                        -- 记录ID

              -- 3.2 初始化数据
              turnover_gdklsf := 0;           -- 成交笔数（广东快乐十分）
              turnover_cqssc := 0;            -- 成交笔数（重庆时时彩）
              turnover_hklhc := 0;            -- 成交笔数（香港六合彩）
              turnover_bjsc := 0;             -- 成交笔数（北京赛车）
              amount := 0;                    -- 投注总额
              validAmount := 0;               -- 有效金额
              memberAmount := 0;              -- 会员输赢
              subordinateAmount := 0;         -- 应收下线
              memberBackWater := 0;           -- 会员退水
              winBackWater := 0;              -- 赚取退水
              realResult := 0;                -- 实占结果
              winBackWaterResult := 0;        -- 赚水后结果
              paySuperior := 0;               -- 应付上级
              recNum := 0;

              -- 3.3 初始化存储上线所对应的计算后的佣金、占成、下级应收
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

              /******** 广东快乐十分 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'GDKLSF' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_gdklsf := 'SELECT * FROM TB_GDKLSF_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_gdklsf := sql_gdklsf || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_gdklsf
              FOR
              sql_gdklsf;

              -- 统计投注笔数
              execute immediate sql_str into turnover_gdklsf;
              turnover_total := turnover_total + turnover_gdklsf;

              BEGIN
                   LOOP
                   FETCH cursor_his_gdklsf INTO member_pos_gdklsf;
                       -- 无数据则退出
                       IF (cursor_his_gdklsf%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_gdklsf.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_gdklsf.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100;
                          -- 根据不同的管理用户类型，计算对应的佣金
                          IF (userType = 2) THEN
                            -- 总监
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (1 - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_BRANCH / 100);
                          ELSIF(userType = 4) THEN
                            -- 股东
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_STOCKHOLDER / 100);
                          ELSIF(userType = 5) THEN
                            -- 总代理
                            winBackWater := winBackWater + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100) * (1 - member_pos_gdklsf.RATE_GEN_AGENT / 100);
                          END IF;

                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_gdklsf.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_gdklsf.WIN_AMOUNT;
                          memberAmount_temp := member_pos_gdklsf.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_gdklsf.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_gdklsf.MONEY;
                          memberAmount_temp := - member_pos_gdklsf.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- 累积上级的占成
                       --            * ((member_pos_gdklsf.RATE_CHIEF + member_pos_gdklsf.RATE_BRANCH + member_pos_gdklsf.RATE_GEN_AGENT + member_pos_gdklsf.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_gdklsf.WIN_STATE = 1 OR member_pos_gdklsf.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_BRANCH - member_pos_gdklsf.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_gdklsf.RATE_STOCKHOLDER/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_STOCKHOLDER - member_pos_gdklsf.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_GEN_AGENT/100 -  member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_GEN_AGENT - member_pos_gdklsf.COMMISSION_AGENT) / 100) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_AGENT - member_pos_gdklsf.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_gdklsf.MONEY * (member_pos_gdklsf.COMMISSION_MEMBER - 0) / 100);

                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * member_pos_gdklsf.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * member_pos_gdklsf.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * member_pos_gdklsf.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_gdklsf.MONEY * member_pos_gdklsf.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_BRANCH / 100)) * member_pos_gdklsf.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100 - member_pos_gdklsf.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_gdklsf.RATE_AGENT/100 - member_pos_gdklsf.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       IF (userType = 2) THEN
                            -- 总监
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_gdklsf.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_gdklsf.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_gdklsf.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_gdklsf.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_gdklsf.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_gdklsf.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_gdklsf.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_gdklsf.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_gdklsf.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- 总监
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- 分公司
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- 股东
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- 总代理
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_gdklsf;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接设置直属会员对应的上级实占结果值
              IF (userType = 2) THEN
                -- 总监
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- 分公司
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- 股东
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- 总代理
                realResult := rateGenAgent;
              END IF;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 广东快乐十分 结束 ********/

              /******** 重庆时时彩 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'CQSSC' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_cqssc := 'SELECT * FROM TB_CQSSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_cqssc := sql_cqssc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_cqssc
              FOR
              sql_cqssc;

              -- 统计投注笔数
              execute immediate sql_str into turnover_cqssc;
              turnover_total := turnover_total + turnover_cqssc;

              BEGIN
                   LOOP
                   FETCH cursor_his_cqssc INTO member_pos_cqssc;
                       -- 无数据则退出
                       IF (cursor_his_cqssc%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_cqssc.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_cqssc.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100;
                          IF (userType = 2) THEN
                            -- 总监
                            winBackWater := winBackWater + (member_pos_cqssc.MONEY * (0 - member_pos_cqssc.COMMISSION_MEMBER) / 100) * (1 - member_pos_cqssc.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWater := winBackWater + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100) * (1 - member_pos_cqssc.RATE_AGENT / 100);
                          END IF;
                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_cqssc.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_cqssc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_cqssc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_cqssc.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_cqssc.MONEY;
                          memberAmount_temp := - member_pos_cqssc.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- 累积上级的占成
                       --            * ((member_pos_cqssc.RATE_CHIEF + member_pos_cqssc.RATE_BRANCH + member_pos_cqssc.RATE_GEN_AGENT + member_pos_cqssc.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_cqssc.WIN_STATE = 1 OR member_pos_cqssc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_BRANCH - member_pos_cqssc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_cqssc.RATE_STOCKHOLDER/100 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_STOCKHOLDER - member_pos_cqssc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_cqssc.RATE_GEN_AGENT/100 -  member_pos_cqssc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_GEN_AGENT - member_pos_cqssc.COMMISSION_AGENT) / 100) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_AGENT - member_pos_cqssc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_cqssc.MONEY * (member_pos_cqssc.COMMISSION_MEMBER - 0) / 100);

                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * member_pos_cqssc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * member_pos_cqssc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * member_pos_cqssc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * member_pos_cqssc.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_cqssc.MONEY * member_pos_cqssc.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_BRANCH / 100)) * member_pos_cqssc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100 - member_pos_cqssc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_cqssc.RATE_AGENT/100 - member_pos_cqssc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_cqssc.MONEY * member_pos_cqssc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       IF (userType = 2) THEN
                            -- 总监
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_cqssc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_cqssc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_cqssc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_cqssc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_cqssc.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_cqssc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_cqssc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_cqssc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_cqssc.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- 总监
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- 分公司
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- 股东
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- 总代理
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_cqssc;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接设置直属会员对应的上级实占结果值
              IF (userType = 2) THEN
                -- 总监
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- 分公司
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- 股东
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- 总代理
                realResult := rateGenAgent;
              END IF;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 重庆时时彩 结束 ********/

              /******** 香港六合彩 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'HKLHC' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_hklhc := 'SELECT * FROM TB_HKLHC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_hklhc := sql_hklhc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_hklhc
              FOR
              sql_hklhc;

              -- 统计投注笔数
              execute immediate sql_str into turnover_hklhc;
              turnover_total := turnover_total + turnover_hklhc;

              BEGIN
                   LOOP
                   FETCH cursor_his_hklhc INTO member_pos_hklhc;

                       -- 无数据则退出
                       IF (cursor_his_hklhc%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_hklhc.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_hklhc.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100;

                          IF (userType = 2) THEN
                            -- 总监
                            winBackWater := winBackWater + (member_pos_hklhc.MONEY * (0 - member_pos_hklhc.COMMISSION_MEMBER) / 100) * (1 - member_pos_hklhc.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWater := winBackWater + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100) * (1 - member_pos_hklhc.RATE_AGENT / 100);
                          END IF;

                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_hklhc.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_hklhc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_hklhc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_hklhc.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_hklhc.MONEY;
                          memberAmount_temp := - member_pos_hklhc.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                       -- 累积上级的占成
                       --            * ((member_pos_hklhc.RATE_CHIEF + member_pos_hklhc.RATE_BRANCH + member_pos_hklhc.RATE_GEN_AGENT + member_pos_hklhc.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_hklhc.WIN_STATE = 1 OR member_pos_hklhc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_BRANCH - member_pos_hklhc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_hklhc.RATE_STOCKHOLDER/100 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_STOCKHOLDER - member_pos_hklhc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_hklhc.RATE_GEN_AGENT/100 -  member_pos_hklhc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_GEN_AGENT - member_pos_hklhc.COMMISSION_AGENT) / 100) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_AGENT - member_pos_hklhc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_hklhc.MONEY * (member_pos_hklhc.COMMISSION_MEMBER - 0) / 100);

                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * member_pos_hklhc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * member_pos_hklhc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * member_pos_hklhc.RATE_STOCKHOLDER/100;
                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * member_pos_hklhc.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_hklhc.MONEY * member_pos_hklhc.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_BRANCH / 100)) * member_pos_hklhc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100 - member_pos_hklhc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_hklhc.RATE_AGENT/100 - member_pos_hklhc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_hklhc.MONEY * member_pos_hklhc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       IF (userType = 2) THEN
                            -- 总监
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_hklhc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_hklhc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_hklhc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_hklhc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_hklhc.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_hklhc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_hklhc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_hklhc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_hklhc.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- 总监
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- 分公司
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- 股东
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- 总代理
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_hklhc;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接设置直属会员对应的上级实占结果值
              IF (userType = 2) THEN
                -- 总监
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- 分公司
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- 股东
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- 总代理
                realResult := rateGenAgent;
              END IF;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 香港六合彩 结束 ********/


              /******** 北京赛车 开始 ********/
              IF LOTTERY1688Type = 'ALL' OR LOTTERY1688Type = 'BJSC' THEN

              -- 3.3 从投注历史表中查询对应会员的投注信息数据
              -- 构造查询语句
              sql_str := 'SELECT COUNT(Distinct ORDER_NO) FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
              sql_bjsc := 'SELECT * FROM TB_BJSC_HIS WHERE BETTING_USER_ID = ' || subID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';

              IF playType IS NOT NULL THEN
                 sql_str := sql_str || ' AND TYPE_CODE IN (' || playType || ')';
                 sql_bjsc := sql_bjsc || ' AND TYPE_CODE IN (' || playType || ')';
              END IF;

              -- 执行查询，打开游标
              OPEN cursor_his_bjsc
              FOR
              sql_bjsc;

              -- 统计投注笔数
              execute immediate sql_str into turnover_bjsc;
              turnover_total := turnover_total + turnover_bjsc;

              BEGIN
                   LOOP
                   FETCH cursor_his_bjsc INTO member_pos_bjsc;
                       -- 无数据则退出
                       IF (cursor_his_bjsc%found = false) THEN
                           EXIT;
                       END IF;
                       -- 累加投注总额
                       amount := amount + member_pos_bjsc.MONEY;

                       -- 累加投注笔数（存在连码，故不能在此处累加投注笔数）
                       -- turnover := turnover + 1;

                       -- 累加记录数目
                       recNum := recNum + 1;

                       memberAmount_temp := 0;
                       memberBackWater_temp := 0;
                       -- 有效金额、赚取退水
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          -- 统计状态为“中奖”、“未中奖”的投注额
                          -- 有效金额
                          validAmount := validAmount + member_pos_bjsc.MONEY;
                          -- 赚取退水（佣金(截留部份)*投注额，除了打和，其他的都要退水）
                          memberBackWater_temp := member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100;
                          -- 根据不同的管理用户类型，计算对应的佣金
                          IF (userType = 2) THEN
                            -- 总监
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (1 - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_CHIEF / 100);
                          ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_BRANCH / 100);
                          ELSIF(userType = 4) THEN
                            -- 股东
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_STOCKHOLDER / 100);
                          ELSIF(userType = 5) THEN
                            -- 总代理
                            winBackWater := winBackWater + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100) * (1 - member_pos_bjsc.RATE_GEN_AGENT / 100);
                          END IF;

                          -- 会员退水（会员自身的佣金*投注额，除了打和，其他的都要退水）
                          memberBackWater := memberBackWater + memberBackWater_temp;
                       END IF;

                       -- 会员输赢，对应该会员所有输赢的总和(不计退水)
                       IF (member_pos_bjsc.WIN_STATE = 1) THEN
                          -- 累加“中奖”的投注额
                          memberAmount := memberAmount + member_pos_bjsc.WIN_AMOUNT;
                          memberAmount_temp := member_pos_bjsc.WIN_AMOUNT;
                       END IF;
                       IF (member_pos_bjsc.WIN_STATE = 2) THEN
                          -- 减去“未中奖”的投注额
                          memberAmount := memberAmount - member_pos_bjsc.MONEY;
                          memberAmount_temp := - member_pos_bjsc.MONEY;
                       END IF;

                       -- 应付上级（【指会员输赢+会员退水+赚取退水(实际就是水差)】*上级占的成数*（-1））
                       -- paySuperior := paySuperior + ((memberAmount_temp + memberBackWater_temp) * (-1)
                                   -- 累积上级的占成
                       --            * ((member_pos_bjsc.RATE_CHIEF + member_pos_bjsc.RATE_BRANCH + member_pos_bjsc.RATE_GEN_AGENT + member_pos_bjsc.RATE_STOCKHOLDER)/100));

                       -- 计算上线所对应的计算后的佣金、占成
                       -- 打和则不计算佣金（退水）
                       IF (member_pos_bjsc.WIN_STATE = 1 OR member_pos_bjsc.WIN_STATE = 2) THEN
                          commissionBranch := commissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100);
                          commissionGenAgent := commissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100);
                          commissionStockholder := commissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100);
                          commissionAgent := commissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          commissionMember := commissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- 赚取佣金
                          winCommissionBranch := winCommissionBranch + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_BRANCH - member_pos_bjsc.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_bjsc.RATE_STOCKHOLDER/100 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionStockholder := winCommissionStockholder + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_STOCKHOLDER - member_pos_bjsc.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_bjsc.RATE_GEN_AGENT/100 -  member_pos_bjsc.RATE_AGENT/100);
                          winCommissionGenAgent := winCommissionGenAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_GEN_AGENT - member_pos_bjsc.COMMISSION_AGENT) / 100) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          winCommissionAgent := winCommissionAgent + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_AGENT - member_pos_bjsc.COMMISSION_MEMBER) / 100);
                          winCommissionMember := winCommissionMember + (member_pos_bjsc.MONEY * (member_pos_bjsc.COMMISSION_MEMBER - 0) / 100);

                          -- 实占结果（指会员输赢 + 会员退水）*占成%
                          rateChief := rateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          rateBranch := rateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * member_pos_bjsc.RATE_BRANCH/100;
                          rateGenAgent := rateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * member_pos_bjsc.RATE_GEN_AGENT/100;
                          rateStockholder := rateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * member_pos_bjsc.RATE_STOCKHOLDER/100;

                          rateAgent := rateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * member_pos_bjsc.RATE_AGENT/100;

                          -- 实占注额（有效的投注金额 * 占成%）
                          moneyRateChief := moneyRateChief + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_CHIEF / 100);
                          moneyRateBranch := moneyRateBranch + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_BRANCH / 100);
                          moneyRateStockholder := moneyRateStockholder + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_STOCKHOLDER / 100);
                          moneyRateGenAgent := moneyRateGenAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_GEN_AGENT / 100);
                          moneyRateAgent := moneyRateAgent + (member_pos_bjsc.MONEY * member_pos_bjsc.RATE_AGENT / 100);

                          -- 各级应收下线
                          subordinateChief := subordinateChief + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_BRANCH / 100)) * member_pos_bjsc.RATE_CHIEF/100;
                          subordinateBranch := subordinateBranch + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100 - member_pos_bjsc.RATE_STOCKHOLDER/100);
                          subordinateGenAgent := subordinateGenAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100);
                          subordinateStockholder := subordinateStockholder + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_GEN_AGENT / 100)) * (1 - member_pos_bjsc.RATE_AGENT/100 - member_pos_bjsc.RATE_GEN_AGENT/100);
                          subordinateAgent := subordinateAgent + (memberAmount_temp + (member_pos_bjsc.MONEY * member_pos_bjsc.COMMISSION_MEMBER / 100)) * 1;
                       END IF;
                       -- dbms_output.put_line('memberAmount_temp'||memberAmount_temp||' memberBackWater_temp'||memberBackWater_temp);
                       -- dbms_output.put_line('rateChief：'||rateChief||' rateBranch:'||rateBranch||' rateGenAgent:'||rateGenAgent||' rateStockholder'||rateStockholder||' rateAgent'||rateAgent);

                       -- 赚水后结果（实占结果（代理实占）－赚取退水）
                       IF (userType = 2) THEN
                            -- 总监
                            winBackWaterResult := rateChief - winBackWater;
                       ELSIF(userType = 3) THEN
                            -- 分公司
                            winBackWaterResult := rateBranch - winBackWater;
                       END IF;

                       rateChiefSet := rateChiefSet + member_pos_bjsc.RATE_CHIEF;
                       rateBranchSet := rateBranchSet + member_pos_bjsc.RATE_BRANCH;
                       rateStockholderSet := rateStockholderSet + member_pos_bjsc.RATE_STOCKHOLDER;
                       rateGenAgentSet := rateGenAgentSet + member_pos_bjsc.RATE_GEN_AGENT;
                       rateAgentSet := rateAgentSet + member_pos_bjsc.RATE_AGENT;

                       -- 退水设置值
                       commissionBranchSet := member_pos_bjsc.COMMISSION_BRANCH;
                       commissionStockholderSet := member_pos_bjsc.COMMISSION_STOCKHOLDER;
                       commissionGenAgentSet := member_pos_bjsc.COMMISSION_GEN_AGENT;
                       commissionAgentSet := member_pos_bjsc.COMMISSION_AGENT;

                       IF (userType = 2) THEN
                          -- 总监
                          rate := rateChiefSet;
                       ELSIF(userType = 3) THEN
                          -- 分公司
                          rate := rateBranchSet;
                       ELSIF(userType = 4) THEN
                          -- 股东
                          rate := rateStockholderSet;
                       ELSIF(userType = 5) THEN
                          -- 总代理
                          rate := rateGenAgentSet;
                       END IF;

                   END LOOP;
                   CLOSE cursor_his_bjsc;
              END;

              -- 应收下线，指对应该会员所有输赢的总和+退水总和(和局不算退水)
              subordinateAmount := memberAmount + memberBackWater;

              -- 实占结果，会员退水后结果*占成%，此处可以直接设置直属会员对应的上级实占结果值
              IF (userType = 2) THEN
                -- 总监
                realResult := rateChief;
              ELSIF(userType = 3) THEN
                -- 分公司
                realResult := rateBranch;
              ELSIF(userType = 4) THEN
                -- 股东
                realResult := rateStockholder;
              ELSIF(userType = 5) THEN
                -- 总代理
                realResult := rateGenAgent;
              END IF;

              -- 应付上级（应收下线－赚水后结果）
              paySuperior := subordinateAmount - winBackWaterResult;

              END IF;
              /******** 北京赛车 结束 ********/

              -- 计算占成设置值的平均值
              IF (recNum > 0) THEN
                 rateChiefSet := rateChiefSet / recNum;
                 rateBranchSet := rateBranchSet / recNum;
                 rateStockholderSet := rateStockholderSet / recNum;
                 rateGenAgentSet := rateGenAgentSet / recNum;
                 rateAgentSet := rateAgentSet / recNum;

                 IF (userType = 2) THEN
                    -- 总监
                    rate := rateChiefSet;
                 ELSIF(userType = 3) THEN
                    -- 分公司
                    rate := rateBranchSet;
                 ELSIF(userType = 4) THEN
                    -- 股东
                    rate := rateStockholderSet;
                 ELSIF(userType = 5) THEN
                    -- 总代理
                    rate := rateGenAgentSet;
                 END IF;
                 -- 累加有效投注会员数
                 recNum_total := recNum_total + 1;
                 -- 累加占着设置值的总值
                 --rate_total := rate_total + rate;
                 --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                 --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                 --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                 --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                 --rateAgentSet_total := rateAgentSet_total + rateAgentSet;
              END IF;

              -- 5. 累加总额
              amount_total := amount_total + amount;
              validAmount_total := validAmount_total + validAmount;
              memberAmount_total := memberAmount_total + memberAmount;
              memberBackWater_total := memberBackWater_total + memberBackWater;
              subordinateAmount_total := subordinateAmount_total + subordinateAmount;
              winBackWater_total := winBackWater_total + winBackWater;
              realResult_total := realResult_total + realResult;
              winBackWaterResult_total := winBackWaterResult_total + winBackWaterResult;
              paySuperior_total := paySuperior_total + paySuperior;

              -- 6. 累积上线所对应的计算后的佣金、占成（总额）
              commissionBranch_total := commissionBranch_total + commissionBranch;
              commissionGenAgent_total := commissionGenAgent_total + commissionGenAgent;
              commissionStockholder_total := commissionStockholder_total + commissionStockholder;
              commissionAgent_total := commissionAgent_total + commissionAgent;
              commissionMember_total := commissionMember_total + commissionMember;

              -- 赚取退水
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

              -- 实占注额
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

              -- 如果成交笔数大于0，则保存数据
              IF ((turnover_gdklsf + turnover_cqssc + turnover_hklhc + turnover_bjsc) > 0) THEN

                 -- 7. 数据插入临时表
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

      -- 6.1 数据不存在（成交笔数为0）则返回
      IF (turnover_total < 1) THEN
         resultFlag := 2; -- 设置结果
         return;
      END IF;
      -- dbms_output.put_line('rateAgent_total：'||rateAgent_total);

      -- 计算占成设置值的平均值
      --IF (recNum_total > 0) THEN
         --rate_total := rate_total / recNum_total;
         --rateChiefSet_total := rateChiefSet_total / recNum_total;
         --rateBranchSet_total := rateBranchSet_total / recNum_total;
         --rateStockholderSet_total := rateStockholderSet_total / recNum_total;
         --rateGenAgentSet_total := rateGenAgentSet_total / recNum_total;
         --rateAgentSet_total := rateAgentSet_total / recNum_total;
      --END IF;

      -- 6.3 总额数据插入临时表（USER_TYPE设置为 Z）
      IF (turnover_total > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT, RATE, RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
        VALUES
            (userID, userID, 'Z', '0', '', '直属会员合计：', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total, rate, rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;

      -- 7. 从临时表中查询数据
      --OPEN statReportAgent
      --FOR
      --SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 8. 设置结果（成功，正常结束）
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_GEN_AGENT
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Gen_Agent(
/*==============================================================*/
/*                  总代理交收报表存储过程                      */
/*==============================================================*/
     userID IN varchar2,                -- 代理ID
     LOTTERY1688Type IN varchar2,           -- 彩票种类
     playType IN varchar2,              -- 下注类型
     periodsNum IN varchar2,            -- 期数
     startDate IN varchar2,             -- 开始时间
     endDate IN varchar2,               -- 结束时间
     resultFlag OUT varchar2,           -- 存储执行结果值：0-成功；1-userID为空；2-数据为空; 9-未知错误
     statReportAgent OUT statReportResult.resultRef         -- 返回结果集
) AS
     subordinate varchar2(50);          -- 下级登陆账号
     userName varchar2(50);             -- 用户名称
     turnover NUMBER;                   -- 成交笔数
     amount NUMBER;                     -- 投注总额
     validAmount NUMBER;                -- 有效金额
     memberAmount NUMBER;               -- 会员输赢
     memberBackWater NUMBER;            -- 会员退水
     subordinateAmount NUMBER;          -- 应收下线
     winBackWater NUMBER;               -- 赚取退水
     realResult NUMBER;                 -- 实占结果
     winBackWaterResult NUMBER;         -- 赚水后结果
     paySuperior NUMBER;                -- 应付上级
     subID NUMBER;                      -- 记录ID
     memberAmount_temp NUMBER;          -- 临时变量，存储会员输赢数据
     memberBackWater_temp NUMBER;       -- 临时变量，会员退水
     recNum NUMBER;                     -- 临时变量，记录数

     -- 定义游标
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     gdklsf_his_cursor  mycursor;
     member_pos TB_GDKLSF_HIS%rowtype;

     sql_replenish varchar2(2000);              -- 补货查询 sql
     cursor_replenish mycursor;                 -- 补货游标
     member_pos_replenish TB_REPLENISH%rowtype; -- 补货数据对象
     turnover_replenish NUMBER;                 -- 补货笔数
     amount_replenish NUMBER;                   -- 补货投注总额
     validAmount_replenish NUMBER;              -- 补货有效金额
     amount_win_replenish NUMBER;               -- 补货输赢
     backWater_replenish NUMBER;                -- 补货退水
     backWaterResult_replenish NUMBER;          -- 退水后结果
     backWater_replenish_temp NUMBER;           -- 补货退水（临时）
     amount_win_replenish_temp NUMBER;          -- 补货输赢（临时）

     -- 总额统计值
     turnover_total NUMBER;             -- 成交笔数（总额）
     amount_total NUMBER;               -- 投注总额（总额）
     validAmount_total NUMBER;          -- 有效金额（总额）
     memberAmount_total NUMBER;         -- 会员输赢（总额）
     memberBackWater_total NUMBER;      -- 会员退水（总额）
     subordinateAmount_total NUMBER;    -- 应收下线（总额）
     winBackWater_total NUMBER;         -- 赚取退水（总额）
     realResult_total NUMBER;           -- 实占结果（总额）
     winBackWaterResult_total NUMBER;   -- 赚水后结果（总额）
     paySuperior_total NUMBER;          -- 应付上级（总额）

     -- 存储上线所对应的计算后的佣金、占成、下线应收
     commissionBranch NUMBER;           -- 分公司佣金
     commissionGenAgent NUMBER;         -- 总代理佣金
     commissionStockholder NUMBER;      -- 股东佣金
     commissionAgent NUMBER;            -- 代理佣金
     commissionMember NUMBER;           -- 会员佣金

     -- 赚取佣金
     winCommissionBranch NUMBER;           -- 分公司赚取佣金
     winCommissionGenAgent NUMBER;         -- 总代理赚取佣金
     winCommissionStockholder NUMBER;      -- 股东赚取佣金
     winCommissionAgent NUMBER;            -- 代理赚取佣金
     winCommissionMember NUMBER;           -- 会员赚取佣金

     rateChief NUMBER;                  -- 总监占成
     rateBranch NUMBER;                 -- 分公司占成
     rateGenAgent NUMBER;               -- 总代理占成
     rateStockholder NUMBER;            -- 股东占成
     rateAgent NUMBER;                  -- 代理占成

     moneyRateChief NUMBER;             -- 总监实占注额
     moneyRateBranch NUMBER;            -- 分公司实占注额
     moneyRateGenAgent NUMBER;          -- 总代理实占注额
     moneyRateStockholder NUMBER;       -- 股东实占注额
     moneyRateAgent NUMBER;             -- 代理实占注额

     subordinateChief NUMBER;           -- 下线应收（总监）
     subordinateBranch NUMBER;          -- 下线应收（分公司）
     subordinateStockholder NUMBER;     -- 下线应收（股东）
     subordinateGenAgent NUMBER;        -- 下线应收（总代理）
     subordinateAgent NUMBER;           -- 下线应收（代理）

     rate NUMBER;                       -- 占成设置值
     rateChiefSet NUMBER;               -- 总监占成设置值
     rateBranchSet NUMBER;              -- 分公司占成设置值
     rateStockholderSet NUMBER;         -- 股东占成设置值
     rateGenAgentSet NUMBER;            -- 总代理占成设置值
     rateAgentSet NUMBER;               -- 代理占成设置值

     commissionBranchSet NUMBER;        -- 分公司退水设置值
     commissionStockholderSet NUMBER;   -- 股东退水设置值
     commissionGenAgentSet NUMBER;      -- 总代理退水设置值
     commissionAgentSet NUMBER;         -- 代理退水设置值

     -- 存储上线所对应的计算后的佣金、占成、下线应收（总额）
     commissionBranch_total NUMBER;           -- 分公司佣金（总额）
     commissionGenAgent_total NUMBER;         -- 总代理佣金（总额）
     commissionStockholder_total NUMBER;      -- 股东佣金（总额）
     commissionAgent_total NUMBER;            -- 代理佣金（总额）
     commissionMember_total NUMBER;           -- 会员佣金（总额）

     -- 赚取佣金
     winCommissionBranch_total NUMBER;           -- 分公司赚取佣金（总额）
     winCommissionGenAgent_total NUMBER;         -- 总代理赚取佣金（总额）
     winCommissionStockholder_total NUMBER;      -- 股东赚取佣金（总额）
     winCommissionAgent_total NUMBER;            -- 代理赚取佣金（总额）
     winCommissionMember_total NUMBER;           -- 会员赚取佣金（总额）

     rateChief_total NUMBER;                  -- 总监占成（总额）
     rateBranch_total NUMBER;                 -- 分公司占成（总额）
     rateGenAgent_total NUMBER;               -- 总代理占成（总额）
     rateStockholder_total NUMBER;            -- 股东占成（总额）
     rateAgent_total NUMBER;                  -- 代理占成（总额）

     moneyRateChief_total NUMBER;                  -- 总监实占注额（总额）
     moneyRateBranch_total NUMBER;                 -- 分公司实占注额（总额）
     moneyRateGenAgent_total NUMBER;               -- 总代理实占注额（总额）
     moneyRateStockholder_total NUMBER;            -- 股东实占注额（总额）
     moneyRateAgent_total NUMBER;                  -- 代理实占注额（总额）

     subordinateChief_total NUMBER;           -- 下线应收（总监）
     subordinateBranch_total NUMBER;          -- 下线应收（分公司）
     subordinateStockholder_total NUMBER;     -- 下线应收（股东）
     subordinateGenAgent_total NUMBER;        -- 下线应收（总代理）
     subordinateAgent_total NUMBER;           -- 下线应收（代理）

     -- 占成设置值只取最后一个值，故总和值无效
     recNum_total NUMBER;                     -- 临时变量，有效会员数
     --rate_total NUMBER;                       -- 占成设置值（总和）
     --rateChiefSet_total NUMBER;               -- 总监占成设置值（总和）
     --rateBranchSet_total NUMBER;              -- 分公司占成设置值（总和）
     --rateStockholderSet_total NUMBER;         -- 股东占成设置值（总和）
     --rateGenAgentSet_total NUMBER;            -- 总代理占成设置值（总和）
     --rateAgentSet_total NUMBER;               -- 代理占成设置值（总和）
BEGIN
     -- 初始化返回结果值
     resultFlag := 0;

     -- 1.1 校验输入参数
     dbms_output.put_line('userID：'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 初始化总额
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

     -- 初始化占成设置值相关数据
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 删除临时表中的数据
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 查询总代理对应的代理信息
     declare
     cursor agent_cursor
     IS
     SELECT * FROM
         (TB_AGENT_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 循环处理所有的代理信息
          FOR agent_pos IN agent_cursor LOOP
              -- 2.1.2 填充数据记录
              subordinate := agent_pos.ACCOUNT;             -- 下级登陆账号
              userName := agent_pos.CHS_NAME;               -- 用户名称
              subID := agent_pos.ID;                        -- 记录ID
              -- 2.1.3 初始化数据
              turnover := 0;                  -- 成交笔数
              amount := 0;                    -- 投注总额
              validAmount := 0;               -- 有效金额
              memberAmount := 0;              -- 会员输赢
              subordinateAmount := 0;         -- 应收下线
              memberBackWater := 0;           -- 会员退水
              winBackWater := 0;              -- 赚取退水
              realResult := 0;                -- 实占结果
              winBackWaterResult := 0;        -- 赚水后结果
              paySuperior := 0;               -- 应付上级
              rate := 0;                      -- 占成
              recNum := 0;

              -- 3.3 初始化存储上线所对应的计算后的佣金、占成、下级应收
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- 赚取退水
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

              -- 2.1.4 调用代理交收报表存储过程
              Delivery_Report_Agent(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportAgent);
              -- 读取代理交收报表存储过程所形成的数据
              declare
              cursor report_Agent_cursor
              IS
              -- 过滤掉代理对应的补货信息
              -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = agent_pos.ID AND t.USER_TYPE NOT IN ('g');

              BEGIN
              FOR report_Agent_pos IN report_Agent_cursor LOOP

                  -- 会员退水
                  memberBackWater := report_Agent_pos.COMMISSION_AGENT + report_Agent_pos.COMMISSION_MEMBER;
                  -- 应收下线（直接读取下线所计算的本级及上线占成结果，此处不能计算，因为不同的投注占成值不同）
                  -- subordinateAmount := report_Agent_pos.RATE_CHIEF + report_Agent_pos.RATE_BRANCH + report_Agent_pos.RATE_STOCKHOLDER + report_Agent_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_Agent_pos.SUBORDINATE_GEN_AGENT;
                  -- 实占结果（直接读取下线所计算的代理占成结果，此处不能计算，因为不同的投注占成值不同）
                  realResult := report_Agent_pos.RATE_GEN_AGENT;
                  -- 赚取退水（需要确认，可能需要减去下面的退水值）
                  winBackWater := report_Agent_pos.WIN_COMMISSION_GEN_AGENT;
                  -- 赚水后结果（实占结果-赚取退水）
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- 应付上线（应收下线－赚水后结果）
                  paySuperior := subordinateAmount - winBackWaterResult;

                  -- 实占注额
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

                  -- 占成设置值
                  rateChiefSet := report_Agent_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_Agent_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_Agent_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_Agent_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_Agent_pos.RATE_AGENT_SET;

                  -- 退水设置值
                  commissionBranchSet := report_Agent_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_Agent_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_Agent_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_Agent_pos.COMMISSION_AGENT_SET;

                  rate := report_Agent_pos.RATE_GEN_AGENT_SET;
                  -- 赋值，TODO 考虑如果补货数据在投注数据之前出现是否会有问题
                  turnover := report_Agent_pos.TURNOVER;          -- 成交笔数
                  amount := report_Agent_pos.AMOUNT;              -- 投注总额
                  validAmount := report_Agent_pos.VALID_AMOUNT;   -- 有效金额
                  memberAmount := report_Agent_pos.MEMBER_AMOUNT; -- 会员输赢

                  /*
                  -- 合并相同用户的补货数据和投注数据
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

                  -- 删除之前存入的数据（相同用户的补货数据和投注数据合成一条记录）
                  EXECUTE IMMEDIATE 'DELETE FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = ' || agent_pos.ID || 'AND t.PARENT_ID = ' || userID;
                  */

                  -- 2.1.4.1 数据插入临时表
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

                   -- 2.1.4.2 累加总额
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

                   -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

                   -- 实占注额
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

                   -- 占成设置值
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 删除无效临时数据
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = agent_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** 总代理对应的直属会员数据 开始 ********/
      -- 调用直属会员交收报表存储过程
      Delivery_Report_Dir_Member(userID, '5', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- 查询直属会员统计数据
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- 累加直属会员统计数据
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 累加总额
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

               -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

               -- 实占注额
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

               -- 占成设置值
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 删除无效临时数据
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;
      /******** 总代理对应的直属会员数据 结束 ********/

      /******** 补货数据 开始 ********/
      -- 6.2 查询补货数据（补货后续需要区分玩法类型查询）
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- 只查询结算了的补货数据
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- 判断彩票种类
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- 广东
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- 香港
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- 重庆
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- 初始化
      turnover_replenish := 0;                         -- 补货笔数
      amount_replenish := 0;                           -- 补货投注总额
      validAmount_replenish :=0;                       -- 补货有效金额
      amount_win_replenish := 0;                       -- 补货输赢
      backWater_replenish := 0;                        -- 补货退水
      backWaterResult_replenish := 0;                  -- 退水后结果
      backWater_replenish_temp := 0;                   -- 补货输赢（临时）
      amount_win_replenish_temp := 0;                  -- 补货输赢（临时）

      -- 退水相关数据
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- 实占结果
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- 实占注额
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- 应收下线
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- 执行查询，打开游标
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- 无数据则退出
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- 累加补货总额
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- 累加补货笔数
               turnover_replenish := turnover_replenish + 1;

               -- 补货输赢，对应该代理所有补货的总和(不计退水)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- 累加“中奖”的投注额
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- 减去“未中奖”的投注额
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- 补货有效金额，不计算打和
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO 退水需要补全所有级别的退水信息
               -- 补货退水（代理佣金*投注额，除了打和，其他的都要退水）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- 打和则不计算佣金（退水）（当做直属会员处理）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER) / 100);
                  commissionStockholder := commissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100);
                  commissionGenAgent := commissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - 0) / 100);

                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionStockholder := winCommissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionGenAgent := winCommissionGenAgent + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_GEN_AGENT - member_pos_replenish.COMMISSION_AGENT) / 100) * (1 - member_pos_replenish.RATE_AGENT/100);

                  -- 实占结果（退水后结果，也即是 退水 + 输赢）*占成%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  rateBranch := rateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * member_pos_replenish.RATE_BRANCH/100;
                  rateStockholder := rateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * member_pos_replenish.RATE_STOCKHOLDER/100;

                  -- 实占注额（有效的投注金额 * 占成%）
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- 各级应收下线
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  subordinateBranch := subordinateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100);
                  subordinateStockholder := subordinateStockholder + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_GEN_AGENT / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- 补货退水后结果（退水 + 输赢）
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. 补货数据插入临时表（处理数据类型）（数据对应的 USER_TYPE 为实际值 + a，即如果实际值为1，则填充值 b，实际值为0，则填充a）
      -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'f', '1', '补货', '补货', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. 累加总额（增加补货数据）
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;
      -- commissionAgent_total := commissionAgent_total + backWater_replenish; -- 增加代理补货退水

      -- 6. 累积补货上线所对应的计算后的佣金、占成（总额）
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

      -- 实占注额
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
      /******** 补货数据 结束 ********/

      -- 4. 总额数据插入临时表（为方便排序，总额数据对应的 USER_TYPE 为实际值 + A，即如果实际值为1，则填充值 B）
      -- C（2总监）、D（3分公司）、E（4股东）、F（5总代理）、G（6代理）、H（7子账号）
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'F', '', '合计：', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. 从临时表中查询数据
      OPEN statReportAgent
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. 设置结果（成功，正常结束）
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_STOCKHOLDER
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Stockholder(
/*==============================================================*/
/*                    股东交收报表存储过程                      */
/*==============================================================*/
     userID IN varchar2,                -- 代理ID
     LOTTERY1688Type IN varchar2,           -- 彩票种类
     playType IN varchar2,              -- 下注类型
     periodsNum IN varchar2,            -- 期数
     startDate IN varchar2,             -- 开始时间
     endDate IN varchar2,               -- 结束时间
     resultFlag OUT varchar2,           -- 存储执行结果值：0-成功；1-userID为空；2-数据为空; 9-未知错误
     statReportGenAgent OUT statReportResult.resultRef         -- 返回结果集
) AS
     subordinate varchar2(50);          -- 下级登陆账号
     userName varchar2(50);             -- 用户名称
     turnover NUMBER;                   -- 成交笔数
     amount NUMBER;                     -- 投注总额
     validAmount NUMBER;                -- 有效金额
     memberAmount NUMBER;               -- 会员输赢
     memberBackWater NUMBER;            -- 会员退水
     subordinateAmount NUMBER;          -- 应收下线
     winBackWater NUMBER;               -- 赚取退水
     realResult NUMBER;                 -- 实占结果
     winBackWaterResult NUMBER;         -- 赚水后结果
     paySuperior NUMBER;                -- 应付上级
     subID NUMBER;                      -- 记录ID
     memberAmount_temp NUMBER;          -- 临时变量，存储会员输赢数据
     memberBackWater_temp NUMBER;       -- 临时变量，会员退水
     recNum NUMBER;                     -- 临时变量，记录数

     -- 定义游标
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     his_cursor  mycursor;
     member_pos TB_HKLHC_HIS%rowtype;

     sql_replenish varchar2(2000);              -- 补货查询 sql
     cursor_replenish mycursor;                 -- 补货游标
     member_pos_replenish TB_REPLENISH%rowtype; -- 补货数据对象
     turnover_replenish NUMBER;                 -- 补货笔数
     amount_replenish NUMBER;                   -- 补货投注总额
     validAmount_replenish NUMBER;              -- 补货有效金额
     amount_win_replenish NUMBER;               -- 补货输赢
     backWater_replenish NUMBER;                -- 补货退水
     backWaterResult_replenish NUMBER;          -- 退水后结果
     backWater_replenish_temp NUMBER;           -- 补货退水（临时）
     amount_win_replenish_temp NUMBER;          -- 补货输赢（临时）

     -- 总额统计值
     turnover_total NUMBER;             -- 成交笔数（总额）
     amount_total NUMBER;               -- 投注总额（总额）
     validAmount_total NUMBER;          -- 有效金额（总额）
     memberAmount_total NUMBER;         -- 会员输赢（总额）
     memberBackWater_total NUMBER;      -- 会员退水（总额）
     subordinateAmount_total NUMBER;    -- 应收下线（总额）
     winBackWater_total NUMBER;         -- 赚取退水（总额）
     realResult_total NUMBER;           -- 实占结果（总额）
     winBackWaterResult_total NUMBER;   -- 赚水后结果（总额）
     paySuperior_total NUMBER;          -- 应付上级（总额）

     -- 存储上线所对应的计算后的佣金、占成、下线应收
     commissionBranch NUMBER;           -- 分公司佣金
     commissionGenAgent NUMBER;         -- 总代理佣金
     commissionStockholder NUMBER;      -- 股东佣金
     commissionAgent NUMBER;            -- 代理佣金
     commissionMember NUMBER;           -- 会员佣金

     -- 赚取佣金
     winCommissionBranch NUMBER;           -- 分公司赚取佣金
     winCommissionGenAgent NUMBER;         -- 总代理赚取佣金
     winCommissionStockholder NUMBER;      -- 股东赚取佣金
     winCommissionAgent NUMBER;            -- 代理赚取佣金
     winCommissionMember NUMBER;           -- 会员赚取佣金

     rateChief NUMBER;                  -- 总监占成
     rateBranch NUMBER;                 -- 分公司占成
     rateGenAgent NUMBER;               -- 总代理占成
     rateStockholder NUMBER;            -- 股东占成
     rateAgent NUMBER;                  -- 代理占成

     moneyRateChief NUMBER;             -- 总监实占注额
     moneyRateBranch NUMBER;            -- 分公司实占注额
     moneyRateGenAgent NUMBER;          -- 总代理实占注额
     moneyRateStockholder NUMBER;       -- 股东实占注额
     moneyRateAgent NUMBER;             -- 代理实占注额

     subordinateChief NUMBER;           -- 下线应收（总监）
     subordinateBranch NUMBER;          -- 下线应收（分公司）
     subordinateStockholder NUMBER;     -- 下线应收（股东）
     subordinateGenAgent NUMBER;        -- 下线应收（总代理）
     subordinateAgent NUMBER;           -- 下线应收（代理）

     rate NUMBER;                       -- 占成设置值
     rateChiefSet NUMBER;               -- 总监占成设置值
     rateBranchSet NUMBER;              -- 分公司占成设置值
     rateStockholderSet NUMBER;         -- 股东占成设置值
     rateGenAgentSet NUMBER;            -- 总代理占成设置值
     rateAgentSet NUMBER;               -- 代理占成设置值

     commissionBranchSet NUMBER;        -- 分公司退水设置值
     commissionStockholderSet NUMBER;   -- 股东退水设置值
     commissionGenAgentSet NUMBER;      -- 总代理退水设置值
     commissionAgentSet NUMBER;         -- 代理退水设置值

     -- 存储上线所对应的计算后的佣金、占成、下线应收（总额）
     commissionBranch_total NUMBER;           -- 分公司佣金（总额）
     commissionGenAgent_total NUMBER;         -- 总代理佣金（总额）
     commissionStockholder_total NUMBER;      -- 股东佣金（总额）
     commissionAgent_total NUMBER;            -- 代理佣金（总额）
     commissionMember_total NUMBER;           -- 会员佣金（总额）

     -- 赚取佣金
     winCommissionBranch_total NUMBER;           -- 分公司赚取佣金（总额）
     winCommissionGenAgent_total NUMBER;         -- 总代理赚取佣金（总额）
     winCommissionStockholder_total NUMBER;      -- 股东赚取佣金（总额）
     winCommissionAgent_total NUMBER;            -- 代理赚取佣金（总额）
     winCommissionMember_total NUMBER;           -- 会员赚取佣金（总额）

     rateChief_total NUMBER;                  -- 总监占成（总额）
     rateBranch_total NUMBER;                 -- 分公司占成（总额）
     rateGenAgent_total NUMBER;               -- 总代理占成（总额）
     rateStockholder_total NUMBER;            -- 股东占成（总额）
     rateAgent_total NUMBER;                  -- 代理占成（总额）

     moneyRateChief_total NUMBER;                  -- 总监实占注额（总额）
     moneyRateBranch_total NUMBER;                 -- 分公司实占注额（总额）
     moneyRateGenAgent_total NUMBER;               -- 总代理实占注额（总额）
     moneyRateStockholder_total NUMBER;            -- 股东实占注额（总额）
     moneyRateAgent_total NUMBER;                  -- 代理实占注额（总额）

     subordinateChief_total NUMBER;           -- 下线应收（总监）
     subordinateBranch_total NUMBER;          -- 下线应收（分公司）
     subordinateStockholder_total NUMBER;     -- 下线应收（股东）
     subordinateGenAgent_total NUMBER;        -- 下线应收（总代理）
     subordinateAgent_total NUMBER;           -- 下线应收（代理）

     -- 占成设置值只取最后一个值，故总和值无效
     recNum_total NUMBER;                     -- 临时变量，有效会员数
     --rate_total NUMBER;                       -- 占成设置值（总和）
     --rateChiefSet_total NUMBER;               -- 总监占成设置值（总和）
     --rateBranchSet_total NUMBER;              -- 分公司占成设置值（总和）
     --rateStockholderSet_total NUMBER;         -- 股东占成设置值（总和）
     --rateGenAgentSet_total NUMBER;            -- 总代理占成设置值（总和）
     --rateAgentSet_total NUMBER;               -- 代理占成设置值（总和）
BEGIN
     -- 初始化返回结果值
     resultFlag := 0;

     -- 1.1 校验输入参数
     dbms_output.put_line('userID：'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 初始化总额
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

     -- 初始化占成设置值相关数据
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 删除临时表中的数据
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 查询股东对应的总代理信息
     declare
     cursor gen_agent_cursor
     IS
     SELECT * FROM
         (TB_GEN_AGENT_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 循环处理所有的总代理信息
          FOR gen_agent_pos IN gen_agent_cursor LOOP
              -- 2.1.2 填充数据记录
              subordinate := gen_agent_pos.ACCOUNT;         -- 下级登陆账号
              userName := gen_agent_pos.CHS_NAME;           -- 用户名称
              subID := gen_agent_pos.ID;                    -- 记录ID
              -- 2.1.3 初始化数据
              turnover := 0;                  -- 成交笔数
              amount := 0;                    -- 投注总额
              validAmount := 0;               -- 有效金额
              memberAmount := 0;              -- 会员输赢
              subordinateAmount := 0;         -- 应收下线
              memberBackWater := 0;           -- 会员退水
              winBackWater := 0;              -- 赚取退水
              realResult := 0;                -- 实占结果
              winBackWaterResult := 0;        -- 赚水后结果
              paySuperior := 0;               -- 应付上级
              rate := 0;                      -- 占成
              recNum := 0;

              -- 3.3 初始化存储上线所对应的计算后的佣金、占成、下级应收
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- 赚取退水
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

              -- 2.1.4 调用总代理交收报表存储过程
              Delivery_Report_Gen_Agent(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportGenAgent);
              -- 读取代理交收报表存储过程所形成的数据
              declare
              cursor report_gen_agent_cursor
              IS
              -- 过滤掉代理对应的补货信息
              -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = gen_agent_pos.ID AND t.USER_TYPE NOT IN ('g','f');

              BEGIN
              FOR report_gen_agent_pos IN report_gen_agent_cursor LOOP

                  -- 会员退水
                  memberBackWater := report_gen_agent_pos.COMMISSION_GEN_AGENT + report_gen_agent_pos.COMMISSION_AGENT + report_gen_agent_pos.COMMISSION_MEMBER;
                  -- 应收下线（直接读取下线所计算的本级及上线占成结果，此处不能计算，因为不同的投注占成值不同）
                  -- subordinateAmount := report_gen_agent_pos.RATE_CHIEF + report_gen_agent_pos.RATE_BRANCH + report_gen_agent_pos.RATE_STOCKHOLDER + report_gen_agent_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_gen_agent_pos.SUBORDINATE_STOCKHOLDER;
                  -- 实占结果（直接读取下线所计算的股东占成结果，此处不能计算，因为不同的投注占成值不同）
                  realResult := report_gen_agent_pos.RATE_STOCKHOLDER;
                  -- 赚取退水
                  winBackWater := report_gen_agent_pos.WIN_COMMISSION_STOCKHOLDER;
                  -- 赚水后结果（实占结果-赚取退水）
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- 应付上线（应收下线－赚水后结果）
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

                  -- 占成设置值
                  rateChiefSet := report_gen_agent_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_gen_agent_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_gen_agent_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_gen_agent_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_gen_agent_pos.RATE_AGENT_SET;

                  -- 退水设置值
                  commissionBranchSet := report_gen_agent_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_gen_agent_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_gen_agent_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_gen_agent_pos.COMMISSION_AGENT_SET;

                  rate := report_gen_agent_pos.RATE_STOCKHOLDER_SET;
                  -- 赋值，TODO 考虑如果补货数据在投注数据之前出现是否会有问题
                  turnover := report_gen_agent_pos.TURNOVER;          -- 成交笔数
                  amount := report_gen_agent_pos.AMOUNT;              -- 投注总额
                  validAmount := report_gen_agent_pos.VALID_AMOUNT;   -- 有效金额
                  memberAmount := report_gen_agent_pos.MEMBER_AMOUNT; -- 会员输赢

                  -- 2.1.4.1 数据插入临时表
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

                   -- 2.1.4.2 累加总额
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

                   -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

                   -- 实占注额
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

                   -- 占成设置值
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 删除无效临时数据
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = gen_agent_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** 股东对应的直属会员数据 开始 ********/
      -- 调用直属会员交收报表存储过程
      Delivery_Report_Dir_Member(userID, '4', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- 查询直属会员统计数据
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- 累加直属会员统计数据
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 累加总额
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

               -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

               -- 占成设置值
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 删除无效临时数据
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;
      /******** 股东对应的直属会员数据 结束 ********/

      /******** 补货数据 开始 ********/
      -- 6.2 查询补货数据（补货后续需要区分玩法类型查询）
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- 只查询结算了的补货数据
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- 判断彩票种类
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- 广东
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- 香港
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- 重庆
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- 初始化
      turnover_replenish := 0;                         -- 补货笔数
      amount_replenish := 0;                           -- 补货投注总额
      validAmount_replenish :=0;                       -- 补货有效金额
      amount_win_replenish := 0;                       -- 补货输赢
      backWater_replenish := 0;                        -- 补货退水
      backWaterResult_replenish := 0;                  -- 退水后结果
      backWater_replenish_temp := 0;                   -- 补货输赢（临时）
      amount_win_replenish_temp := 0;                  -- 补货输赢（临时）

      -- 退水相关数据
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- 实占结果
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- 实占注额
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- 应收下线
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- 执行查询，打开游标
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- 无数据则退出
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- 累加补货总额
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- 累加补货笔数
               turnover_replenish := turnover_replenish + 1;

               -- 补货输赢，对应该代理所有补货的总和(不计退水)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- 累加“中奖”的投注额
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- 减去“未中奖”的投注额
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- 补货有效金额，不计算打和
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO 退水需要补全所有级别的退水信息
               -- 补货退水（代理佣金*投注额，除了打和，其他的都要退水）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- 打和则不计算佣金（退水）（当做直属会员处理）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER) / 100);
                  commissionStockholder := commissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - 0) / 100);

                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);
                  winCommissionStockholder := winCommissionStockholder + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_STOCKHOLDER - member_pos_replenish.COMMISSION_GEN_AGENT) / 100) * (1 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);

                  -- 实占结果（退水后结果，也即是 退水 + 输赢）*占成%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  rateBranch := rateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * member_pos_replenish.RATE_BRANCH/100;

                  -- 实占注额（有效的投注金额 * 占成%）
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- 各级应收下线
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;
                  subordinateBranch := subordinateBranch + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_STOCKHOLDER / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- 补货退水后结果（退水 + 输赢）
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. 补货数据插入临时表（处理数据类型）（数据对应的 USER_TYPE 为实际值 + a，即如果实际值为1，则填充值 b，实际值为0，则填充a）
      -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'e', '1', '补货', '补货', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. 累加总额（增加补货数据）
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;

      -- 6. 累积补货上线所对应的计算后的佣金、占成（总额）
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

      -- 实占注额
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
      /******** 补货数据 结束 ********/

      -- 4. 总额数据插入临时表（为方便排序，总额数据对应的 USER_TYPE 为实际值 + A，即如果实际值为1，则填充值 B）
      -- C（2总监）、D（3分公司）、E（4股东）、F（5总代理）、G（6代理）、H（7子账号）
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'E', '', '合计：', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. 从临时表中查询数据
      OPEN statReportGenAgent
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. 设置结果（成功，正常结束）
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_BRANCH
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Branch(
/*==============================================================*/
/*                    分公司交收报表存储过程                      */
/*==============================================================*/
     userID IN varchar2,                -- 代理ID
     LOTTERY1688Type IN varchar2,           -- 彩票种类
     playType IN varchar2,              -- 下注类型
     periodsNum IN varchar2,            -- 期数
     startDate IN varchar2,             -- 开始时间
     endDate IN varchar2,               -- 结束时间
     resultFlag OUT varchar2,           -- 存储执行结果值：0-成功；1-userID为空；2-数据为空; 9-未知错误
     statReportStockholder OUT statReportResult.resultRef         -- 返回结果集
) AS
     subordinate varchar2(50);          -- 下级登陆账号
     userName varchar2(50);             -- 用户名称
     turnover NUMBER;                   -- 成交笔数
     amount NUMBER;                     -- 投注总额
     validAmount NUMBER;                -- 有效金额
     memberAmount NUMBER;               -- 会员输赢
     memberBackWater NUMBER;            -- 会员退水
     subordinateAmount NUMBER;          -- 应收下线
     winBackWater NUMBER;               -- 赚取退水
     realResult NUMBER;                 -- 实占结果
     winBackWaterResult NUMBER;         -- 赚水后结果
     paySuperior NUMBER;                -- 应付上级
     subID NUMBER;                      -- 记录ID
     memberAmount_temp NUMBER;          -- 临时变量，存储会员输赢数据
     memberBackWater_temp NUMBER;       -- 临时变量，会员退水
     recNum NUMBER;                     -- 临时变量，记录数

     -- 定义游标
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     his_cursor  mycursor;
     member_pos TB_HKLHC_HIS%rowtype;

     sql_replenish varchar2(2000);              -- 补货查询 sql
     cursor_replenish mycursor;                 -- 补货游标
     member_pos_replenish TB_REPLENISH%rowtype; -- 补货数据对象
     turnover_replenish NUMBER;                 -- 补货笔数
     amount_replenish NUMBER;                   -- 补货投注总额
     validAmount_replenish NUMBER;              -- 补货有效金额
     amount_win_replenish NUMBER;               -- 补货输赢
     backWater_replenish NUMBER;                -- 补货退水
     backWaterResult_replenish NUMBER;          -- 退水后结果
     backWater_replenish_temp NUMBER;           -- 补货退水（临时）
     amount_win_replenish_temp NUMBER;          -- 补货输赢（临时）

     -- 总额统计值
     turnover_total NUMBER;             -- 成交笔数（总额）
     amount_total NUMBER;               -- 投注总额（总额）
     validAmount_total NUMBER;          -- 有效金额（总额）
     memberAmount_total NUMBER;         -- 会员输赢（总额）
     memberBackWater_total NUMBER;      -- 会员退水（总额）
     subordinateAmount_total NUMBER;    -- 应收下线（总额）
     winBackWater_total NUMBER;         -- 赚取退水（总额）
     realResult_total NUMBER;           -- 实占结果（总额）
     winBackWaterResult_total NUMBER;   -- 赚水后结果（总额）
     paySuperior_total NUMBER;          -- 应付上级（总额）

     -- 存储上线所对应的计算后的佣金、占成、下线应收
     commissionBranch NUMBER;           -- 分公司佣金
     commissionGenAgent NUMBER;         -- 总代理佣金
     commissionStockholder NUMBER;      -- 股东佣金
     commissionAgent NUMBER;            -- 代理佣金
     commissionMember NUMBER;           -- 会员佣金

     -- 赚取佣金
     winCommissionBranch NUMBER;           -- 分公司赚取佣金
     winCommissionGenAgent NUMBER;         -- 总代理赚取佣金
     winCommissionStockholder NUMBER;      -- 股东赚取佣金
     winCommissionAgent NUMBER;            -- 代理赚取佣金
     winCommissionMember NUMBER;           -- 会员赚取佣金

     rateChief NUMBER;                  -- 总监占成
     rateBranch NUMBER;                 -- 分公司占成
     rateGenAgent NUMBER;               -- 总代理占成
     rateStockholder NUMBER;            -- 股东占成
     rateAgent NUMBER;                  -- 代理占成

     moneyRateChief NUMBER;             -- 总监实占注额
     moneyRateBranch NUMBER;            -- 分公司实占注额
     moneyRateGenAgent NUMBER;          -- 总代理实占注额
     moneyRateStockholder NUMBER;       -- 股东实占注额
     moneyRateAgent NUMBER;             -- 代理实占注额

     subordinateChief NUMBER;           -- 下线应收（总监）
     subordinateBranch NUMBER;          -- 下线应收（分公司）
     subordinateStockholder NUMBER;     -- 下线应收（股东）
     subordinateGenAgent NUMBER;        -- 下线应收（总代理）
     subordinateAgent NUMBER;           -- 下线应收（代理）

     rate NUMBER;                       -- 占成设置值
     rateChiefSet NUMBER;               -- 总监占成设置值
     rateBranchSet NUMBER;              -- 分公司占成设置值
     rateStockholderSet NUMBER;         -- 股东占成设置值
     rateGenAgentSet NUMBER;            -- 总代理占成设置值
     rateAgentSet NUMBER;               -- 代理占成设置值

     commissionBranchSet NUMBER;        -- 分公司退水设置值
     commissionStockholderSet NUMBER;   -- 股东退水设置值
     commissionGenAgentSet NUMBER;      -- 总代理退水设置值
     commissionAgentSet NUMBER;         -- 代理退水设置值

     -- 存储上线所对应的计算后的佣金、占成、下线应收（总额）
     commissionBranch_total NUMBER;           -- 分公司佣金（总额）
     commissionGenAgent_total NUMBER;         -- 总代理佣金（总额）
     commissionStockholder_total NUMBER;      -- 股东佣金（总额）
     commissionAgent_total NUMBER;            -- 代理佣金（总额）
     commissionMember_total NUMBER;           -- 会员佣金（总额）

     -- 赚取佣金
     winCommissionBranch_total NUMBER;           -- 分公司赚取佣金（总额）
     winCommissionGenAgent_total NUMBER;         -- 总代理赚取佣金（总额）
     winCommissionStockholder_total NUMBER;      -- 股东赚取佣金（总额）
     winCommissionAgent_total NUMBER;            -- 代理赚取佣金（总额）
     winCommissionMember_total NUMBER;           -- 会员赚取佣金（总额）

     rateChief_total NUMBER;                  -- 总监占成（总额）
     rateBranch_total NUMBER;                 -- 分公司占成（总额）
     rateGenAgent_total NUMBER;               -- 总代理占成（总额）
     rateStockholder_total NUMBER;            -- 股东占成（总额）
     rateAgent_total NUMBER;                  -- 代理占成（总额）

     moneyRateChief_total NUMBER;                  -- 总监实占注额（总额）
     moneyRateBranch_total NUMBER;                 -- 分公司实占注额（总额）
     moneyRateGenAgent_total NUMBER;               -- 总代理实占注额（总额）
     moneyRateStockholder_total NUMBER;            -- 股东实占注额（总额）
     moneyRateAgent_total NUMBER;                  -- 代理实占注额（总额）

     subordinateChief_total NUMBER;           -- 下线应收（总监）
     subordinateBranch_total NUMBER;          -- 下线应收（分公司）
     subordinateStockholder_total NUMBER;     -- 下线应收（股东）
     subordinateGenAgent_total NUMBER;        -- 下线应收（总代理）
     subordinateAgent_total NUMBER;           -- 下线应收（代理）

     recNum_total NUMBER;                     -- 临时变量，有效会员数
     -- 占成设置值只取最后一个值，故总和值无效
     --rate_total NUMBER;                       -- 占成设置值（总和）
     --rateChiefSet_total NUMBER;               -- 总监占成设置值（总和）
     --rateBranchSet_total NUMBER;              -- 分公司占成设置值（总和）
     --rateStockholderSet_total NUMBER;         -- 股东占成设置值（总和）
     --rateGenAgentSet_total NUMBER;            -- 总代理占成设置值（总和）
     --rateAgentSet_total NUMBER;               -- 代理占成设置值（总和）
BEGIN
     -- 初始化返回结果值
     resultFlag := 0;

     -- 1.1 校验输入参数
     dbms_output.put_line('userID：'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 初始化总额
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

     -- 初始化占成设置值相关数据
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 删除临时表中的数据
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 查询分公司对应的股东信息
     declare
     cursor stockholder_cursor
     IS
     SELECT * FROM
         (TB_STOCKHOLDER_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 循环处理所有的股东信息
          FOR stockholder_pos IN stockholder_cursor LOOP
              -- 2.1.2 填充数据记录
              subordinate := stockholder_pos.ACCOUNT;         -- 下级登陆账号
              userName := stockholder_pos.CHS_NAME;           -- 用户名称
              subID := stockholder_pos.ID;                    -- 记录ID
              -- 2.1.3 初始化数据
              turnover := 0;                  -- 成交笔数
              amount := 0;                    -- 投注总额
              validAmount := 0;               -- 有效金额
              memberAmount := 0;              -- 会员输赢
              subordinateAmount := 0;         -- 应收下线
              memberBackWater := 0;           -- 会员退水
              winBackWater := 0;              -- 赚取退水
              realResult := 0;                -- 实占结果
              winBackWaterResult := 0;        -- 赚水后结果
              paySuperior := 0;               -- 应付上级
              rate := 0;                      -- 占成
              recNum := 0;

              -- 3.3 初始化存储上线所对应的计算后的佣金、占成、下级应收
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- 赚取退水
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

              -- 2.1.4 调用股东交收报表存储过程
              Delivery_Report_Stockholder(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportStockholder);
              -- 读取代理交收报表存储过程所形成的数据
              declare
              cursor report_stockholder_cursor
              IS
              -- 过滤掉下级用户对应的补货信息
              -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = stockholder_pos.ID AND t.USER_TYPE NOT IN ('g','f','e');

              BEGIN
              FOR report_stockholder_pos IN report_stockholder_cursor LOOP

                  -- 会员退水
                  memberBackWater := report_stockholder_pos.COMMISSION_STOCKHOLDER + report_stockholder_pos.COMMISSION_GEN_AGENT + report_stockholder_pos.COMMISSION_AGENT + report_stockholder_pos.COMMISSION_MEMBER;
                  -- 应收下线（直接读取下线所计算的本级及上线占成结果，此处不能计算，因为不同的投注占成值不同）
                  -- subordinateAmount := report_stockholder_pos.RATE_CHIEF + report_stockholder_pos.RATE_BRANCH + report_stockholder_pos.RATE_STOCKHOLDER + report_stockholder_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_stockholder_pos.SUBORDINATE_BRANCH;
                  -- 实占结果（直接读取下线所计算的股东占成结果，此处不能计算，因为不同的投注占成值不同）
                  realResult := report_stockholder_pos.RATE_BRANCH;
                  -- 赚取退水
                  winBackWater := report_stockholder_pos.WIN_COMMISSION_BRANCH;
                  -- 赚水后结果（实占结果-赚取退水）
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- 应付上线（应收下线－赚水后结果）
                  paySuperior := subordinateAmount - winBackWaterResult;

                  -- 实占注额
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

                  -- 占成设置值
                  rateChiefSet := report_stockholder_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_stockholder_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_stockholder_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_stockholder_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_stockholder_pos.RATE_AGENT_SET;

                  -- 退水设置值
                  commissionBranchSet := report_stockholder_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_stockholder_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_stockholder_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_stockholder_pos.COMMISSION_AGENT_SET;

                  rate := report_stockholder_pos.RATE_BRANCH_SET;
                  -- 赋值，TODO 考虑如果补货数据在投注数据之前出现是否会有问题
                  turnover := report_stockholder_pos.TURNOVER;          -- 成交笔数
                  amount := report_stockholder_pos.AMOUNT;              -- 投注总额
                  validAmount := report_stockholder_pos.VALID_AMOUNT;   -- 有效金额
                  memberAmount := report_stockholder_pos.MEMBER_AMOUNT; -- 会员输赢

                  -- 2.1.4.1 数据插入临时表
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

                   -- 2.1.4.2 累加总额
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

                   -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

                   -- 实占注额
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

                   -- 占成设置值
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 删除无效临时数据
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = stockholder_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** 分公司对应的直属会员数据 开始 ********/
      -- 调用直属会员交收报表存储过程
      Delivery_Report_Dir_Member(userID, '3', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- 查询直属会员统计数据
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- 累加直属会员统计数据
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 累加总额
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

               -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

               -- 占成设置值
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 删除无效临时数据
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;
      /******** 分公司对应的直属会员数据 结束 ********/

      /******** 补货数据 开始 ********/
      -- 6.2 查询补货数据（补货后续需要区分玩法类型查询）
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- 只查询结算了的补货数据
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- 判断彩票种类
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- 广东
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- 香港
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- 重庆
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- 初始化
      turnover_replenish := 0;                         -- 补货笔数
      amount_replenish := 0;                           -- 补货投注总额
      validAmount_replenish :=0;                       -- 补货有效金额
      amount_win_replenish := 0;                       -- 补货输赢
      backWater_replenish := 0;                        -- 补货退水
      backWaterResult_replenish := 0;                  -- 退水后结果
      backWater_replenish_temp := 0;                   -- 补货输赢（临时）
      amount_win_replenish_temp := 0;                  -- 补货输赢（临时）

      -- 退水相关数据
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- 实占结果
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- 实占注额
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- 应收下线
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- 执行查询，打开游标
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- 无数据则退出
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- 累加补货总额
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- 累加补货笔数
               turnover_replenish := turnover_replenish + 1;

               -- 补货输赢，对应该代理所有补货的总和(不计退水)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- 累加“中奖”的投注额
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- 减去“未中奖”的投注额
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- 补货有效金额，不计算打和
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO 退水需要补全所有级别的退水信息
               -- 补货退水（代理佣金*投注额，除了打和，其他的都要退水）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;
                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;
               -- 打和则不计算佣金（退水）（当做直属会员处理）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - 0) / 100);

                  winCommissionBranch := winCommissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - member_pos_replenish.COMMISSION_STOCKHOLDER)/ 100) * (1 - member_pos_replenish.RATE_STOCKHOLDER/100 - member_pos_replenish.RATE_GEN_AGENT/100 -  member_pos_replenish.RATE_AGENT/100);

                  -- 实占结果（退水后结果，也即是 退水 + 输赢）*占成%
                  rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;

                  -- 实占注额（有效的投注金额 * 占成%）
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);

                  -- 各级应收下线
                  subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * (1);
               END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- 补货退水后结果（退水 + 输赢）
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. 补货数据插入临时表（处理数据类型）（数据对应的 USER_TYPE 为实际值 + a，即如果实际值为1，则填充值 b，实际值为0，则填充a）
      -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'd', '1', '补货', '补货', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. 累加总额（增加补货数据）
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;

      -- 6. 累积补货上线所对应的计算后的佣金、占成（总额）
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

      -- 实占注额
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
      /******** 补货数据 结束 ********/

      -- 4. 总额数据插入临时表（为方便排序，总额数据对应的 USER_TYPE 为实际值 + A，即如果实际值为1，则填充值 B）
      -- C（2总监）、D（3分公司）、E（4股东）、F（5总代理）、G（6代理）、H（7子账号）
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'D', '', '合计：', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. 从临时表中查询数据
      OPEN statReportStockholder
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. 设置结果（成功，正常结束）
      resultFlag := 0;
END;
/

prompt
prompt Creating procedure DELIVERY_REPORT_CHIEF
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE Delivery_Report_Chief(
/*==============================================================*/
/*                    总监交收报表存储过程                      */
/*==============================================================*/
     userID IN varchar2,                -- 代理ID
     LOTTERY1688Type IN varchar2,           -- 彩票种类
     playType IN varchar2,              -- 下注类型
     periodsNum IN varchar2,            -- 期数
     startDate IN varchar2,             -- 开始时间
     endDate IN varchar2,               -- 结束时间
     resultFlag OUT varchar2,           -- 存储执行结果值：0-成功；1-userID为空；2-数据为空; 9-未知错误
     statReportBranch OUT statReportResult.resultRef         -- 返回结果集
) AS
     subordinate varchar2(50);          -- 下级登陆账号
     userName varchar2(50);             -- 用户名称
     turnover NUMBER;                   -- 成交笔数
     amount NUMBER;                     -- 投注总额
     validAmount NUMBER;                -- 有效金额
     memberAmount NUMBER;               -- 会员输赢
     memberBackWater NUMBER;            -- 会员退水
     subordinateAmount NUMBER;          -- 应收下线
     winBackWater NUMBER;               -- 赚取退水
     realResult NUMBER;                 -- 实占结果
     winBackWaterResult NUMBER;         -- 赚水后结果
     paySuperior NUMBER;                -- 应付上级
     subID NUMBER;                      -- 记录ID
     memberAmount_temp NUMBER;          -- 临时变量，存储会员输赢数据
     memberBackWater_temp NUMBER;       -- 临时变量，会员退水
     recNum NUMBER;                     -- 临时变量，记录数

     -- 定义游标
     sqlStr varchar2(10000);
     type   mycursor   is   ref   cursor;
     his_cursor  mycursor;
     member_pos TB_HKLHC_HIS%rowtype;

     sql_replenish varchar2(2000);              -- 补货查询 sql
     cursor_replenish mycursor;                 -- 补货游标
     member_pos_replenish TB_REPLENISH%rowtype; -- 补货数据对象
     turnover_replenish NUMBER;                 -- 补货笔数
     amount_replenish NUMBER;                   -- 补货投注总额
     validAmount_replenish NUMBER;              -- 补货有效金额
     amount_win_replenish NUMBER;               -- 补货输赢
     backWater_replenish NUMBER;                -- 补货退水
     backWaterResult_replenish NUMBER;          -- 退水后结果
     backWater_replenish_temp NUMBER;           -- 补货退水（临时）
     amount_win_replenish_temp NUMBER;          -- 补货输赢（临时）

     -- 总额统计值
     turnover_total NUMBER;             -- 成交笔数（总额）
     amount_total NUMBER;               -- 投注总额（总额）
     validAmount_total NUMBER;          -- 有效金额（总额）
     memberAmount_total NUMBER;         -- 会员输赢（总额）
     memberBackWater_total NUMBER;      -- 会员退水（总额）
     subordinateAmount_total NUMBER;    -- 应收下线（总额）
     winBackWater_total NUMBER;         -- 赚取退水（总额）
     realResult_total NUMBER;           -- 实占结果（总额）
     winBackWaterResult_total NUMBER;   -- 赚水后结果（总额）
     paySuperior_total NUMBER;          -- 应付上级（总额）

     -- 存储上线所对应的计算后的佣金、占成、下线应收
     commissionBranch NUMBER;           -- 分公司佣金
     commissionGenAgent NUMBER;         -- 总代理佣金
     commissionStockholder NUMBER;      -- 股东佣金
     commissionAgent NUMBER;            -- 代理佣金
     commissionMember NUMBER;           -- 会员佣金

     -- 赚取佣金
     winCommissionBranch NUMBER;           -- 分公司赚取佣金
     winCommissionGenAgent NUMBER;         -- 总代理赚取佣金
     winCommissionStockholder NUMBER;      -- 股东赚取佣金
     winCommissionAgent NUMBER;            -- 代理赚取佣金
     winCommissionMember NUMBER;           -- 会员赚取佣金

     rateChief NUMBER;                  -- 总监占成
     rateBranch NUMBER;                 -- 分公司占成
     rateGenAgent NUMBER;               -- 总代理占成
     rateStockholder NUMBER;            -- 股东占成
     rateAgent NUMBER;                  -- 代理占成

     moneyRateChief NUMBER;             -- 总监实占注额
     moneyRateBranch NUMBER;            -- 分公司实占注额
     moneyRateGenAgent NUMBER;          -- 总代理实占注额
     moneyRateStockholder NUMBER;       -- 股东实占注额
     moneyRateAgent NUMBER;             -- 代理实占注额

     subordinateChief NUMBER;           -- 下线应收（总监）
     subordinateBranch NUMBER;          -- 下线应收（分公司）
     subordinateStockholder NUMBER;     -- 下线应收（股东）
     subordinateGenAgent NUMBER;        -- 下线应收（总代理）
     subordinateAgent NUMBER;           -- 下线应收（代理）

     rate NUMBER;                       -- 占成设置值
     rateChiefSet NUMBER;               -- 总监占成设置值
     rateBranchSet NUMBER;              -- 分公司占成设置值
     rateStockholderSet NUMBER;         -- 股东占成设置值
     rateGenAgentSet NUMBER;            -- 总代理占成设置值
     rateAgentSet NUMBER;               -- 代理占成设置值

     commissionBranchSet NUMBER;        -- 分公司退水设置值
     commissionStockholderSet NUMBER;   -- 股东退水设置值
     commissionGenAgentSet NUMBER;      -- 总代理退水设置值
     commissionAgentSet NUMBER;         -- 代理退水设置值

     -- 存储上线所对应的计算后的佣金、占成、下线应收（总额）
     commissionBranch_total NUMBER;           -- 分公司佣金（总额）
     commissionGenAgent_total NUMBER;         -- 总代理佣金（总额）
     commissionStockholder_total NUMBER;      -- 股东佣金（总额）
     commissionAgent_total NUMBER;            -- 代理佣金（总额）
     commissionMember_total NUMBER;           -- 会员佣金（总额）

     -- 赚取佣金
     winCommissionBranch_total NUMBER;           -- 分公司赚取佣金（总额）
     winCommissionGenAgent_total NUMBER;         -- 总代理赚取佣金（总额）
     winCommissionStockholder_total NUMBER;      -- 股东赚取佣金（总额）
     winCommissionAgent_total NUMBER;            -- 代理赚取佣金（总额）
     winCommissionMember_total NUMBER;           -- 会员赚取佣金（总额）

     rateChief_total NUMBER;                  -- 总监占成（总额）
     rateBranch_total NUMBER;                 -- 分公司占成（总额）
     rateGenAgent_total NUMBER;               -- 总代理占成（总额）
     rateStockholder_total NUMBER;            -- 股东占成（总额）
     rateAgent_total NUMBER;                  -- 代理占成（总额）

     moneyRateChief_total NUMBER;                  -- 总监实占注额（总额）
     moneyRateBranch_total NUMBER;                 -- 分公司实占注额（总额）
     moneyRateGenAgent_total NUMBER;               -- 总代理实占注额（总额）
     moneyRateStockholder_total NUMBER;            -- 股东实占注额（总额）
     moneyRateAgent_total NUMBER;                  -- 代理实占注额（总额）

     subordinateChief_total NUMBER;           -- 下线应收（总监）
     subordinateBranch_total NUMBER;          -- 下线应收（分公司）
     subordinateStockholder_total NUMBER;     -- 下线应收（股东）
     subordinateGenAgent_total NUMBER;        -- 下线应收（总代理）
     subordinateAgent_total NUMBER;           -- 下线应收（代理）

     -- 占成设置值只取最后一个值，故总和值无效
     recNum_total NUMBER;                     -- 临时变量，有效会员数
     --rate_total NUMBER;                       -- 占成设置值（总和）
     --rateChiefSet_total NUMBER;               -- 总监占成设置值（总和）
     --rateBranchSet_total NUMBER;              -- 分公司占成设置值（总和）
     --rateStockholderSet_total NUMBER;         -- 股东占成设置值（总和）
     --rateGenAgentSet_total NUMBER;            -- 总代理占成设置值（总和）
     --rateAgentSet_total NUMBER;               -- 代理占成设置值（总和）
BEGIN
     -- 初始化返回结果值
     resultFlag := 0;

     -- 1.1 校验输入参数
     dbms_output.put_line('userID：'||userID);
     IF(userID IS NULL) THEN
         resultFlag := 1;
         return;
     END IF;

     -- 1.2 初始化总额
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

     -- 初始化占成设置值相关数据
     recNum_total := 0;
     --rate_total := 0;
     --rateChiefSet_total := 0;
     --rateBranchSet_total := 0;
     --rateStockholderSet_total := 0;
     --rateGenAgentSet_total := 0;
     --rateAgentSet_total := 0;

     -- 1.3 删除临时表中的数据
     DELETE FROM TEMP_DELIVERYREPORT WHERE PARENT_ID = userID;

     -- 2.1 查询总监对应的分公司信息
     declare
     cursor branch_cursor
     IS
     SELECT * FROM
         (TB_BRANCH_STAFF_EXT ext INNER JOIN TB_FRAME_MANAGER_STAFF managerStaff ON ext.MANAGER_STAFF_ID = managerStaff.ID)
     WHERE
         ext.PARENT_STAFF = userID;

     BEGIN
          -- 2.1.1 循环处理所有的分公司信息
          FOR branch_pos IN branch_cursor LOOP
              -- 2.1.2 填充数据记录
              subordinate := branch_pos.ACCOUNT;         -- 下级登陆账号
              userName := branch_pos.CHS_NAME;           -- 用户名称
              subID := branch_pos.ID;                    -- 记录ID
              -- 2.1.3 初始化数据
              turnover := 0;                  -- 成交笔数
              amount := 0;                    -- 投注总额
              validAmount := 0;               -- 有效金额
              memberAmount := 0;              -- 会员输赢
              subordinateAmount := 0;         -- 应收下线
              memberBackWater := 0;           -- 会员退水
              winBackWater := 0;              -- 赚取退水
              realResult := 0;                -- 实占结果
              winBackWaterResult := 0;        -- 赚水后结果
              paySuperior := 0;               -- 应付上级
              rate := 0;                      -- 占成
              recNum := 0;

              -- 3.3 初始化存储上线所对应的计算后的佣金、占成、下级应收
              commissionBranch := 0;
              commissionGenAgent := 0;
              commissionStockholder := 0;
              commissionAgent := 0;
              commissionMember := 0;

              -- 赚取退水
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

              -- 2.1.4 调用股东交收报表存储过程
              Delivery_Report_Branch(subID, LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag, statReportBranch);
              -- 读取代理交收报表存储过程所形成的数据
              declare
              cursor report_branch_cursor
              IS
              -- 过滤掉下级用户对应的补货信息
              -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
              SELECT * FROM TEMP_DELIVERYREPORT t WHERE t.USER_ID = branch_pos.ID AND t.USER_TYPE NOT IN ('g','f','e','d');

              BEGIN
              FOR report_branch_pos IN report_branch_cursor LOOP

                  -- 会员退水
                  memberBackWater := report_branch_pos.COMMISSION_BRANCH + report_branch_pos.COMMISSION_STOCKHOLDER + report_branch_pos.COMMISSION_GEN_AGENT + report_branch_pos.COMMISSION_AGENT + report_branch_pos.COMMISSION_MEMBER;
                  -- 应收下线（直接读取下线所计算的本级及上线占成结果，此处不能计算，因为不同的投注占成值不同）
                  -- subordinateAmount := report_branch_pos.RATE_CHIEF + report_branch_pos.RATE_BRANCH + report_branch_pos.RATE_STOCKHOLDER + report_branch_pos.RATE_GEN_AGENT;
                  subordinateAmount := report_branch_pos.SUBORDINATE_CHIEF;
                  -- 实占结果（直接读取下线所计算的股东占成结果，此处不能计算，因为不同的投注占成值不同）
                  realResult := report_branch_pos.RATE_CHIEF;
                  -- 赚取退水
                  winBackWater := 0;
                  -- 赚水后结果（实占结果-赚取退水）
                  winBackWaterResult := winBackWaterResult + realResult - winBackWater;
                  -- 应付上线（应收下线－赚水后结果）
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

                  -- 占成设置值
                  rateChiefSet := report_branch_pos.RATE_CHIEF_SET;
                  rateBranchSet := report_branch_pos.RATE_BRANCH_SET;
                  rateStockholderSet := report_branch_pos.RATE_STOCKHOLDER_SET;
                  rateGenAgentSet := report_branch_pos.RATE_GEN_AGENT_SET;
                  rateAgentSet := report_branch_pos.RATE_AGENT_SET;

                  -- 退水设置值
                  commissionBranchSet := report_branch_pos.COMMISSION_BRANCH_SET;
                  commissionStockholderSet := report_branch_pos.COMMISSION_STOCKHOLDER_SET;
                  commissionGenAgentSet := report_branch_pos.COMMISSION_GEN_AGENT_SET;
                  commissionAgentSet := report_branch_pos.COMMISSION_AGENT_SET;

                  rate := report_branch_pos.RATE_CHIEF_SET;
                  -- 赋值，TODO 考虑如果补货数据在投注数据之前出现是否会有问题
                  turnover := report_branch_pos.TURNOVER;          -- 成交笔数
                  amount := report_branch_pos.AMOUNT;              -- 投注总额
                  validAmount := report_branch_pos.VALID_AMOUNT;   -- 有效金额
                  memberAmount := report_branch_pos.MEMBER_AMOUNT; -- 会员输赢

                  -- 2.1.4.1 数据插入临时表
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

                   -- 2.1.4.2 累加总额
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

                   -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

                   -- 实占注额
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

                   -- 占成设置值
                   recNum_total := recNum_total + 1;
                   --rate_total := rate_total + rate;
                   --rateChiefSet_total := rateChiefSet_total + rateChiefSet;
                   --rateBranchSet_total := rateBranchSet_total + rateBranchSet;
                   --rateStockholderSet_total := rateStockholderSet_total + rateStockholderSet;
                   --rateGenAgentSet_total := rateGenAgentSet_total + rateGenAgentSet;
                   --rateAgentSet_total := rateAgentSet_total + rateAgentSet;

                   -- 2.1.4.3 删除无效临时数据
                   DELETE FROM TEMP_DELIVERYREPORT t WHERE t.PARENT_ID = branch_pos.ID;
              END LOOP;
              END;
          END LOOP;
      END;

      /******** 总监对应的直属会员数据 开始 ********/
      -- 调用直属会员交收报表存储过程
      Delivery_Report_Dir_Member(userID, '2', LOTTERY1688Type, playType, periodsNum, startDate, endDate, resultFlag);
      -- 查询直属会员统计数据
      declare
         cursor dir_total_cursor
         IS
         SELECT * FROM
             TEMP_DELIVERYREPORT report
         WHERE
             report.USER_ID = userID AND report.USER_TYPE = 'Z';
      BEGIN
          -- 累加直属会员统计数据
          FOR dir_total_pos IN dir_total_cursor LOOP
               -- 2.1.4.2 累加总额
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

               -- 2.1.5. 读取上线所对应的计算后的佣金、占成（总额）
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

               -- 占成设置值
               recNum_total := recNum_total + 1;
               --rate_total := rate_total + dir_total_pos.RATE;
               --rateChiefSet_total := rateChiefSet_total + dir_total_pos.RATE_CHIEF_SET;
               --rateBranchSet_total := rateBranchSet_total + dir_total_pos.RATE_BRANCH_SET;
               --rateStockholderSet_total := rateStockholderSet_total + dir_total_pos.RATE_STOCKHOLDER_SET;
               --rateGenAgentSet_total := rateGenAgentSet_total + dir_total_pos.RATE_GEN_AGENT_SET;
               --rateAgentSet_total := rateAgentSet_total + dir_total_pos.RATE_AGENT_SET;

               -- 2.1.4.3 删除无效临时数据
               DELETE FROM TEMP_DELIVERYREPORT report WHERE report.USER_ID = userID AND report.USER_TYPE = 'Z';
          END LOOP;
      END;

      /******** 总监对应的直属会员数据 结束 ********/

      /******** 补货数据 开始 ********/
      -- 6.2 查询补货数据（补货后续需要区分玩法类型查询）
      sql_replenish := 'SELECT * FROM TB_REPLENISH WHERE REPLENISH_USER_ID = ' || userID || ' AND BETTING_DATE BETWEEN to_date(''' || startDate || ''',''yyyy-mm-dd hh24:mi:ss'') AND to_date(''' || endDate || ''',''yyyy-mm-dd hh24:mi:ss'')';
      -- 只查询结算了的补货数据
      sql_replenish := sql_replenish || ' AND WIN_STATE IN (''1'',''2'',''3'') ';

      IF playType IS NOT NULL THEN
         sql_replenish := sql_replenish || ' AND TYPE_CODE IN (' || playType || ')';
      END IF;

      -- 判断彩票种类
      IF LOTTERY1688Type = 'GDKLSF' THEN
         -- 广东
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''GDKLSF_%'' ';
      END IF;
      IF LOTTERY1688Type = 'HKLHC' THEN
         -- 香港
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''HK_%'' ';
      END IF;
      IF LOTTERY1688Type = 'CQSSC' THEN
         -- 重庆
         sql_replenish := sql_replenish || ' AND TYPE_CODE LIKE ''CQSSC_%'' ';
      END IF;

      -- 初始化
      turnover_replenish := 0;                         -- 补货笔数
      amount_replenish := 0;                           -- 补货投注总额
      validAmount_replenish :=0;                       -- 补货有效金额
      amount_win_replenish := 0;                       -- 补货输赢
      backWater_replenish := 0;                        -- 补货退水
      backWaterResult_replenish := 0;                  -- 退水后结果
      backWater_replenish_temp := 0;                   -- 补货输赢（临时）
      amount_win_replenish_temp := 0;                  -- 补货输赢（临时）

      -- 退水相关数据
      commissionBranch := 0;
      commissionStockholder := 0;
      commissionGenAgent := 0;
      commissionAgent := 0;

      winCommissionBranch := 0;
      winCommissionGenAgent := 0;
      winCommissionStockholder := 0;
      winCommissionAgent := 0;

      -- 实占结果
      rateChief := 0;
      rateBranch := 0;
      rateGenAgent := 0;
      rateStockholder := 0;
      rateAgent := 0;

      -- 实占注额
      moneyRateChief := 0;
      moneyRateBranch := 0;
      moneyRateGenAgent := 0;
      moneyRateStockholder := 0;
      moneyRateAgent := 0;

      -- 应收下线
      subordinateChief := 0;
      subordinateBranch := 0;
      subordinateGenAgent := 0;
      subordinateStockholder := 0;
      subordinateAgent := 0;

      -- 执行查询，打开游标
      OPEN cursor_replenish
      FOR
      sql_replenish;

      BEGIN
           LOOP
           FETCH cursor_replenish INTO member_pos_replenish;
               -- 无数据则退出
               IF (cursor_replenish%found = false) THEN
                   EXIT;
               END IF;

               -- 累加补货总额
               amount_replenish := amount_replenish + member_pos_replenish.MONEY;

               -- 累加补货笔数
               turnover_replenish := turnover_replenish + 1;

               -- 补货输赢，对应该代理所有补货的总和(不计退水)
               IF (member_pos_replenish.WIN_STATE = 1) THEN
                  -- 累加“中奖”的投注额
                  amount_win_replenish := amount_win_replenish + member_pos_replenish.WIN_AMOUNT;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_CHIEF / 100;
                  amount_win_replenish_temp := member_pos_replenish.WIN_AMOUNT;
               END IF;
               IF (member_pos_replenish.WIN_STATE = 2) THEN
                  -- 减去“未中奖”的投注额
                  amount_win_replenish := amount_win_replenish - member_pos_replenish.MONEY;
                  backWater_replenish_temp := member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_CHIEF / 100;
                  amount_win_replenish_temp := - member_pos_replenish.MONEY;
               END IF;

               -- 补货有效金额，不计算打和
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  validAmount_replenish := validAmount_replenish + member_pos_replenish.MONEY;
               END IF;
               -- TODO 退水需要补全所有级别的退水信息
               -- 补货退水（代理佣金*投注额，除了打和，其他的都要退水）
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  backWater_replenish := backWater_replenish + backWater_replenish_temp;

                  --rateAgent := rateAgent + (memberAmount_temp + (member_pos_gdklsf.MONEY * member_pos_gdklsf.COMMISSION_MEMBER / 100)) * member_pos_gdklsf.RATE_AGENT/100;
               END IF;

               -- 补货实占注额
               IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  -- 实占注额（有效的投注金额 * 占成%）
                  moneyRateChief := moneyRateChief + (member_pos_replenish.MONEY * member_pos_replenish.RATE_CHIEF / 100);
                  moneyRateBranch := moneyRateBranch + (member_pos_replenish.MONEY * member_pos_replenish.RATE_BRANCH / 100);
                  moneyRateStockholder := moneyRateStockholder + (member_pos_replenish.MONEY * member_pos_replenish.RATE_STOCKHOLDER / 100);
                  moneyRateGenAgent := moneyRateGenAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_GEN_AGENT / 100);
                  moneyRateAgent := moneyRateAgent + (member_pos_replenish.MONEY * member_pos_replenish.RATE_AGENT / 100);
               END IF;

               -- 打和则不计算佣金（退水）（当做直属会员处理）
               -- IF (member_pos_replenish.WIN_STATE = 1 OR member_pos_replenish.WIN_STATE = 2) THEN
                  -- commissionBranch := commissionBranch + (member_pos_replenish.MONEY * (member_pos_replenish.COMMISSION_BRANCH - 0) / 100);

                  -- 实占结果（退水后结果，也即是 退水 + 输赢）*占成%
                  -- rateChief := rateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * member_pos_replenish.RATE_CHIEF/100;

                  -- 各级应收下线
                  -- subordinateChief := subordinateChief + (amount_win_replenish_temp + (member_pos_replenish.MONEY * member_pos_replenish.COMMISSION_BRANCH / 100)) * (1);
               -- END IF;

           END LOOP;
           CLOSE cursor_replenish;
      END;

      -- 补货退水后结果（退水 + 输赢）
      backWaterResult_replenish := backWater_replenish + amount_win_replenish;

      -- 4. 补货数据插入临时表（处理数据类型）（数据对应的 USER_TYPE 为实际值 + a，即如果实际值为1，则填充值 b，实际值为0，则填充a）
      -- c（2总监）、d（3分公司）、e（4股东）、f（5总代理）、g（6代理）、h（7子账号）
      IF (turnover_replenish > 0) THEN
        INSERT INTO TEMP_DELIVERYREPORT
              (PARENT_ID, USER_ID, USER_TYPE, RECORD_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, WIN_BACK_WATER_RESULT)
        VALUES
              (userID, userID, 'c', '1', '补货', '补货', turnover_replenish, amount_replenish, validAmount_replenish, amount_win_replenish, backWater_replenish, backWaterResult_replenish);
      END IF;

      -- 5. 累加总额（增加补货数据）
      turnover_total := turnover_total + turnover_replenish;
      amount_total := amount_total + amount_replenish;
      validAmount_total := validAmount_total + validAmount_replenish;
      memberAmount_total := memberAmount_total + amount_win_replenish;
      memberBackWater_total := memberBackWater_total + backWater_replenish;
      winBackWaterResult_total := winBackWaterResult_total + backWaterResult_replenish;

      -- 6. 累积补货上线所对应的计算后的佣金、占成（总额）
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

      -- 实占注额
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
      /******** 补货数据 结束 ********/

      -- 4. 总额数据插入临时表（为方便排序，总额数据对应的 USER_TYPE 为实际值 + A，即如果实际值为1，则填充值 B）
      -- C（2总监）、D（3分公司）、E（4股东）、F（5总代理）、G（6代理）、H（7子账号）
      IF (turnover_total > 0) THEN
         INSERT INTO TEMP_DELIVERYREPORT
            (PARENT_ID, USER_ID, USER_TYPE, SUBORDINATE, USER_NAME, TURNOVER, AMOUNT, VALID_AMOUNT, MEMBER_AMOUNT, MEMBER_BACK_WATER, SUBORDINATE_AMOUNT, WIN_BACK_WATER, REAL_RESULT, WIN_BACK_WATER_RESULT, PAY_SUPERIOR,
            COMMISSION_BRANCH, COMMISSION_GEN_AGENT, COMMISSION_STOCKHOLDER, COMMISSION_AGENT, COMMISSION_MEMBER, WIN_COMMISSION_BRANCH, WIN_COMMISSION_GEN_AGENT, WIN_COMMISSION_STOCKHOLDER, WIN_COMMISSION_AGENT, WIN_COMMISSION_MEMBER, RATE_CHIEF, RATE_BRANCH, RATE_GEN_AGENT, RATE_STOCKHOLDER, RATE_AGENT, RATE,
            SUBORDINATE_CHIEF, SUBORDINATE_BRANCH, SUBORDINATE_STOCKHOLDER, SUBORDINATE_GEN_AGENT, SUBORDINATE_AGENT,
            RATE_CHIEF_SET, RATE_BRANCH_SET, RATE_STOCKHOLDER_SET, RATE_GEN_AGENT_SET, RATE_AGENT_SET,
            COMMISSION_BRANCH_SET, COMMISSION_STOCKHOLDER_SET, COMMISSION_GEN_AGENT_SET, COMMISSION_AGENT_SET,
            MONEY_RATE_CHIEF, MONEY_RATE_BRANCH, MONEY_RATE_STOCKHOLDER, MONEY_RATE_GEN_AGENT, MONEY_RATE_AGENT)
         VALUES
            (userID, userID, 'C', '', '合计：', turnover_total, amount_total, validAmount_total, memberAmount_total, memberBackWater_total, subordinateAmount_total, winBackWater_total, realResult_total, winBackWaterResult_total, paySuperior_total,
            commissionBranch_total, commissionGenAgent_total, commissionStockholder_total, commissionAgent_total, commissionMember_total, winCommissionBranch_total, winCommissionGenAgent_total, winCommissionStockholder_total, winCommissionAgent_total, winCommissionMember_total, rateChief_total, rateBranch_total, rateGenAgent_total, rateStockholder_total, rateAgent_total, rate,
            subordinateChief_total, subordinateBranch_total, subordinateStockholder_total, subordinateGenAgent_total, subordinateAgent_total,
            rateChiefSet, rateBranchSet, rateStockholderSet, rateGenAgentSet, rateAgentSet,
            commissionBranchSet, commissionStockholderSet, commissionGenAgentSet, commissionAgentSet,
            moneyRateChief_total, moneyRateBranch_total, moneyRateStockholder_total, moneyRateGenAgent_total, moneyRateAgent_total);
      END IF;
      -- 5. 从临时表中查询数据
      OPEN statReportBranch
      FOR
      SELECT * FROM TEMP_DELIVERYREPORT t ORDER BY t.USER_TYPE;

      -- 6. 设置结果（成功，正常结束）
      resultFlag := 0;
END;
/


spool off
