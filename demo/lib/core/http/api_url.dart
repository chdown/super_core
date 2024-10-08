class ApiUrl {
  static String userAgreement = "https://mgr.zhui8taiqiu.com/customerUserAgreement.html"; // 用户协议
  static String privacyPolicy = "https://mgr.zhui8taiqiu.com/customerPrivacyPolicy.html"; // 隐私协议
  static String gov = "https://beian.miit.gov.cn/"; // 备案网站

  static String getDictByType = 'system/dict/data/type';
  static String findByConfig = 'system/config/findByConfig';
  static String fileUpload = 'file/upload'; // 上传文件
  static String getCode = 'message/sms/sendSmsMsg'; // 发送短信验证码

  static String checkPhone = 'customer/checkPhone'; // 检查有没有绑定手机号
  static String bindPhone = 'customer/bindPhone'; // 绑定手机号
  static String customerLogin = 'customer/login'; // 登录
  static String customerLogout = 'customer/logout'; // 登出
  static String Wxlogin = 'customer/wxlogin'; // 微信登录
  static String addUserGt = 'message/userGt/add'; // 保存用户信息
  static String getWxAuthInfo = 'customer/getWxAuthInfo'; // 获取微信授权
  static String getSlideshow = 'customer/index/getSlideshow'; // 获取首页轮播图
  static String searchShopList = 'customer/index/searchShopList'; // 搜索附近球房列表
  static String shopShopDetail = 'customer/shop/shopInfo'; // 获取店铺详情
  static String shopTables = 'customer/shop/tables'; // 获取桌台详情
  static String tablesCard = 'customer/shop/tablesCard'; // 获取桌台详情 - 卡片
  static String getTableBillingRuleDescription = '/customer/shop/getTableBillingRuleDescrption'; // 查询桌台计价规则说明
  static String shopTablesNum = 'customer/shop/shopTablesNum'; // 查询桌台列表对应参数数量
  static String tableQueryInfo = 'customer/table/queryInfo'; // 获取开台详情
  static String mineInfo = 'customer/club/mineInfo'; // 获取个人ID
  static String userInfo = 'customer/club/info'; // 获取个人信息
  static String wxpay = 'customer/wxpay/pay'; // 微信支付
  static String collectShop = 'customer/collect/addCollectShop'; // 收藏店铺
  static String cancelCollectShop = 'customer/collect/cancelCollectShop'; // 取消收藏店铺
  static String collectShops = 'customer/collect/getCollectShops'; // 收藏列表
  static String memberCardDetail = 'customer/member/getMemberCardDetail'; // 获取门店会员卡详情
  static String getMemberCard = 'customer/member/getMemberCard'; // 领取门店会员
  static String getMemberShops = 'customer/member/getMemberShops'; // 门店会员列表
  static String memberCardInfo = 'customer/member/memberCardInfo'; // 会员门店详情
  static String getClubCardRecharge = 'customer/member/getClubCardRecharge'; // 会员卡充值赠送
  static String tableDepositOpen = 'customer/table/depositOpen'; // 押金开台
  static String memberOpenTable = 'customer/table/openTable'; // 会员开台
  static String tableDualGameOpen = 'customer/table/dualGameOpen'; // 对抗赛开台
  static String replacePay = 'customer/table/replacePay'; // 他人代支付
  static String definitionSelect = 'customer/table/definitionSelect'; // 对抗赛类型选择
  // static String getTimeLimits = 'customer/table/getTimeLimits'; // 查询限时优惠列表
  static String getTimeLimit = 'customer/table/getTimeLimit'; // 查询限时优惠
  static String limitTimeOpen = 'customer/table/limitTimeOpen'; // 显示开台
  static String joinDualGame = 'customer/table/joinDualGame'; // 扫码加入对抗赛
  static String mineTableGames = 'customer/club/mineTableGames'; // 查询我的球局
  static String getDualGame = 'customer/table/getDualGame'; // 查询我开启的对抗赛
  static String closeTable = 'customer/table/closeTable'; // 结束对局
  static String cancelDualGame = 'customer/table/cancelDualGame'; // 取消我开启的对抗赛
  static String confireScore = 'customer/table/confireScore'; // 确认对抗赛比分
  static String openTableLight = '/customer/OrderCom/openTableLight'; // 桌台开灯操作
  static String clubRecharge = 'customer/club/recharge'; // 会员充值
  static String queryByMobile = 'customer/table/meituan/queryByMobile'; // 根据手机号查询美团券
  static String groupOpen = 'customer/table/groupOpen'; // 美团券开台
  static String orderClose = 'customer/OrderCom/orderClose'; // 关闭订单
  static String orderContinuePay = 'customer/OrderCom/orderContinuePay'; // 继续支付
  static String queryOrderHasPayed = 'customer/OrderCom/queryOrderHasPayed'; // 查询订单是否已支付
  static String getTableBillList = 'customer/club/getTableBillList'; // 查询台费账单
  static String getRechargeBillList = '/customer/club/getRechargeBillList'; // 查询账单充值列表
  static String getRanking = 'customer/index/getRanking'; // 查询排行榜
  static String getTableBillDetail = 'customer/club/getTableBillDetail'; // 查询账单详情
  static String orderSettlementAmount = 'customer/OrderCom/orderSettlementAmount'; // 计算订单金额
  static String orderSettlement = 'customer/OrderCom/orderSettlement'; // 订单结算
  static String checkTableFinished = '/customer/table/checkTableFinished'; // 查询桌台是否未结束状态
  static String getShopTableInfo = 'customer/shop/getShopTableInfo'; // 查询门店球桌详情
  static String rechargeBillDetail = 'customer/club/rechargeBillDetail'; // 查询账单
  static String getCompetitionGames = 'customer/club/getCompetitionGames'; // 查询我的战绩
  static String editCustomerInfo = 'customer/club/editCustomerInfo'; // 修改个人信息
  static String getMineDualGame = 'customer/table/getDualGame'; //查看我开启的对抗赛二维码
  static String selectShopByShopId = 'merchant/shop/selectShopByShopId'; //查询门店信息及轮播图信息
  static String getNewVersion = 'customer/index/getNewVersion'; //查询最新客户端版本
  static String noticePage = 'customer/notice/page'; //公告通知
  static String noticeDel = 'customer/notice/del'; //删除公告通知
  static String questionAdd = '/customer/question/add'; // 问题反馈
  static String getCustomerOrderCount = '/customer/club/getCustomerOrderCount'; // 问题反馈
  static String lockOpenOrClose = '/customer/OrderCom/lockOpenOrClose'; // 开锁关锁
  static String checkPayQrcode = '/merchant/reckonTimeOpen/checkPayQrcode'; // 校验二维码是否过期+计时开台归属人验证
  static String usingHelpList = '/merchant/usingHelp/list'; // 使用帮助
  static String meituanReceiptCodeInfo = 'merchant/tuangou/meituan/getReceiptCodeInfo'; // 查询美团团购信息
  static String douyinReceiptCodeInfo = '/merchant/tuangou/douyin/getReceiptCodeInfo'; // 查询抖音团购信息
  static String getClubCardRechargeDaliog = '/customer/member/getClubCardRechargeDaliog'; // 查询-会员卡充值弹框
  static String checkDualGameJoin = '/customer/table/checkDualGameJoin'; // 校验对抗赛加入状态
  static String buyTimeLimit = '/customer/table/buyTimeLimit'; // 购买限时卷
  static String checkPopUp = '/customer/table/checkPopUp'; // 优惠券弹窗使用校验
  static String mineTimeLimitList = '/customer/table/mineTimeLimitList'; // 我的优惠卷列表
  static String usableBilliardsList = '/customer/table/usableBilliardsList'; // 可用桌台列表
  static String getShopRechargeGroups = '/customer/rechargeGroup/getShopRechargeGroups'; // 查询门店充值秒杀信息列表
  static String getShopRechargeGroupsTipMsg = '/customer/rechargeGroup/getShopRechargeGroupsTipMsg'; // 查询门店充值秒杀滚动信息
  static String rechargeGroup = '/customer/club/rechargeGroup'; // 秒杀充值
  static String getLimitBadges = '/customer/club/getCouponUnReadCount'; // 获取角标个数
  static String updateLimitBadges = '/customer/club/updateCouponReadStatus'; // 更新优惠券为已读状态
  static String getShopMiniQrCode = '/customer/shop/getShopMiniQrCode'; // 查询门店小程序二维码
  static String checkOpen = '/customer/club/checkOpen'; // 校验是否允许开台
  static String getCommodityBillDetail = '/customer/club/getCommodityBillDetail'; // 查询商品账单详情
  static String getCommodityBillList = '/customer/club/getCommodityBillList'; // 查询商品账单详情列表
  static String checkPole = '/customer/pole/checkPole'; // 二维码跳转存杆柜校验
  static String openPoleLock = '/customer/pole/openPoleLock'; // 开柜操作
  static String getShopMyPoles = '/customer/pole/getShopMyPoles'; // 查询门店我的存杆柜
  static String getShopPoles = '/customer/pole/getShopPoles'; // 查询门店存杆柜
  static String getChangeTableDetail = '/merchant/billiards/getChangeTableDetail'; // 查询换台明细
  static String changeTableList = '/merchant/billiards/changeTableList'; // 查询换台列表
  static String billiardsTableChange = 'merchant/billiards/tableChange'; // 换台
  static String checkTableRefresh = '/merchant/billiards/checkTableRefresh'; // 校验桌台信息刷新
  static String rankPayMoney = '/customer/rank/payMoney'; //豪值榜
  static String rankDual = '/customer/rank/dual'; //战神榜
  static String rankTotalTime = '/customer/rank/totalTime'; //时长榜
  static String areaList = '/customer/rank/areaList'; //排行榜

  static String dualCancelGame = '/customer/dualGame/cancelDualGame'; //根据自定义开台时长计算保证金
  static String dualCheckDualGameJoin = '/customer/dualGame/checkDualGameJoin'; //校验对抗赛加入状态
  static String dualGetEarnestByTime = '/customer/dualGame/getEarnestByTime'; //根据自定义开台时长计算保证金
  static String dualGetStageDetail = '/customer/dualGame/getStageDetail'; //查询阶段胜负确认信息(包含球局已结束后的胜负确认)
  static String dualPayEarnestAndJoinDual = '/customer/dualGame/payEarnestAndJoinDual'; //缴纳保证金加入对抗赛
  static String dualPayEarnestAndOpenDual = '/customer/dualGame/payEarnestAndOpenDual'; //缴纳保证发起对抗赛
  static String dualQueryDualGameInfo = '/customer/dualGame/queryDualGameInfo'; //查询对抗赛信息
  static String dualScanDualGameQrcode = '/customer/dualGame/scanDualGameQrcode'; //扫描对抗赛二维码
  static String dualSubmitStageDetail = '/customer/dualGame/submitStageDetail'; //阶段胜负提交或结束球局
  static String dualGetGameStageDetail = '/customer/dualGame/getGameStageDetail'; //对抗赛胜败记录详情
  static String dualCheckSubmit = '/customer/dualGame/checkSubmit'; //阶段提交校验
  static String getClubInfo = '/customer/club/getClubInfo'; //查询我的会员卡信息

  static String contestList = '/customer/contest/contestList'; //查询赛事列表
  static String cancleEnroll = '/customer/contest/cancleEnroll'; //取消报名
  static String enroll = '/customer/contest/enroll'; //报名
  static String getContestDetali = '/customer/contest/getContestDetali'; //查询赛事详情
}
