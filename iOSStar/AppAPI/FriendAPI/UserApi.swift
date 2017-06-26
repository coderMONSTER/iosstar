//
//  UserApi.swift
//  iOSStar
//
//  Created by sum on 2017/5/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol UserApi {
    
      //获取好友列表
    func requestStarMailList(requestModel:StarMailListRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
      //发送时间少一秒
    func reduceTime(requestModel:ReduceTimeModel, complete: CompleteBlock?, error: ErrorBlock?)
      //预约的明细
    func requestOrderStars(requestModel:OrderStarsRequetsModel, complete: CompleteBlock?, error: ErrorBlock?)
     // 微信支付
    func wechatPay(requestModel:WeChatPayModel , complete: CompleteBlock?, error: ErrorBlock?)
     // 我的资产接口
    func accountMoney(requestModel:AccountMoneyRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
     // 资金明细列表
    func requestCreditList(requestModel:CreditListRequetModel, complete:CompleteBlock?, error:ErrorBlock?)
    
    // 设置交易密码
    func resetPassWd(requestModel:ResetPassWdModel, complete: CompleteBlock?, error: ErrorBlock?)
    //    func ResetPassWd(timestamp : Int64,vCode : String,vToken : String,pwd: String,type : Int, phone :String, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 重置支付密码
    func ResetPayPwd(requestModel:ResetPayPwdRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
     // 实名认证
    func authentication(requestModel:AuthenticationRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    // 获取实名认证信息
    func requestAuthentication(requestModel:GetAuthenticationRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
     // 获取用户信息
    
    func requestUserInfo(requestModel:UserInfoRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    // tokenLogin token登录
    func tokenLogin(requestModel:TokenLoginRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func weichattokenLogin( id:Int64,token:String,complete: CompleteBlock?, error: ErrorBlock?)
    // 修改nickname 
    func modfyNickname(requestModel:ModifyNicknameModel,complete: CompleteBlock?, error: ErrorBlock? )
    
    // 获取已购明星数量
    
    func requestBuyStarCount(complete: CompleteBlock?, error: ErrorBlock?)
    
    func requestAllStarInfo(requestModel:GetAllStarInfoModel, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 支付宝支付
    func alipay(requestModel:AliPayRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    //获取版本更新信息
    func update(type: Int, complete: CompleteBlock?, error: ErrorBlock?)

    //更新devicetoken
    func updateDeviceToken(requestModel:UpdateDeviceTokenModel, complete: CompleteBlock?, error: ErrorBlock?)
    
}
