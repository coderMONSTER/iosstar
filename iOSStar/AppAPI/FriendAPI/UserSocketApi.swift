
//  UserSocketApi.swift
//  iOSStar
//
//  Created by sum on 2017/5/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class UserSocketApi: BaseSocketAPI, UserApi  {


    func requestStarMailList(requestModel:StarMailListRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .getlist, model: requestModel)
        startModelRequest(packet, modelClass: StarListModel.self, complete: complete, error: error)
    }

    
    //聊天减时间
    func reduceTime(requestModel:ReduceTimeModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .reducetime, model: requestModel)
        startRequest(packet, complete: complete, error: error)
    }

    func requestOrderStars(requestModel:OrderStarsRequetsModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .getorderstars, model: requestModel)
        startRequest(packet, complete: complete, error: error)

    }

    //微信支付
    func wechatPay(requestModel:WeChatPayModel , complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .weixinpay, model: requestModel)
        startRequest(packet, complete: complete, error: error)
    }

    //我的资产
    func accountMoney(requestModel: AccountMoneyRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
    let packet = SocketDataPacket(opcode: .accountMoney, model: requestModel)
        
        startRequest(packet, complete: complete, error: error)
    }

    //资金明细列表
    func requestCreditList(requestModel:CreditListRequetModel, complete:CompleteBlock?, error:ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .creditlist, model: requestModel)
        startModelRequest(packet, modelClass: RechargeListModel.self, complete: complete, error: error)

    }

    
    
    // MARK: - 设置支付密码
    
    func resetPassWd(requestModel:ResetPassWdModel , complete: CompleteBlock?, error: ErrorBlock?)
     {
        let packet = SocketDataPacket(opcode: .restPwd, model: requestModel)
         startRequest(packet, complete: complete, error: error)
    }
     // MARK: 重置支付密码
    func ResetPayPwd(requestModel: ResetPayPwdRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .restPwd, model: requestModel)
        
        startRequest(packet, complete: complete, error: error)
        
    }
    // MARK: - 实名认证接口
    func authentication(requestModel:AuthenticationRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .authentication, model: requestModel)
        startRequest(packet, complete: complete, error: error)
    }

    // MARK: - 获取实名认证信息
    func requestAuthentication(requestModel:GetAuthenticationRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .getRealm, model: requestModel)
        startRequest(packet, complete: complete, error: error)
    }

    //  MARK: -  获取用户信息
    func requestUserInfo(requestModel:UserInfoRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .userinfo, model: requestModel)
        startModelRequest(packet, modelClass: UserInfoModel.self, complete: complete, error: error)
    }

    // MARK: -  tokenLogin token登录
    func tokenLogin(requestModel:TokenLoginRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .tokenLogin, model: requestModel)
        startModelRequest(packet, modelClass: UserModel.self, complete: complete, error: error)

    }

    // MARK: -  tokenLogin token登录
    func weichattokenLogin( id:Int64,token:String,complete: CompleteBlock?, error: ErrorBlock?){
        
        let param: [String: Any] = [SocketConst.Key.uid: id,
                                    SocketConst.Key.token : token,]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .tokenLogin, dict: param as [String : AnyObject])
        //startRequest(packet, complete: complete, error: error)
        startModelRequest(packet, modelClass: UserModel.self, complete: complete, error: error)
    }

    
    
    
    func modfyNickname(requestModel: ModifyNicknameModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .modifyNickname, model: requestModel)
        startRequest(packet, complete: complete, error: error)

    }

    
    // MARK: 已购明星接口
    func requestBuyStarCount(complete: CompleteBlock?, error: ErrorBlock?) {
        
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .buyStarCount, dict: param  as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)

    }
    // MARK: 获取明星名称
    func requestAllStarInfo(requestModel: GetAllStarInfoModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .newsStarInfo, model: requestModel)
        startModelsRequest(packet, listName: "list", modelClass: StartModel.self, complete: complete, error: error)
    }

     // MARK: 支付宝支付
    func alipay(requestModel: AliPayRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .alipay, model: requestModel)
        startRequest(packet, complete: complete, error: error)
    }

    //版本更新提醒
    func update(type: Int, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .update, dict: ["ttype": type as AnyObject], type: .user)
        startModelRequest(packet, modelClass: UpdateParam.self, complete: complete, error: error)
    }
    //更新devicetoken
    func updateDeviceToken(requestModel:UpdateDeviceTokenModel, complete: CompleteBlock?, error: ErrorBlock?){
        let packet = SocketDataPacket(opcode: .updateDeviceToken, model: requestModel)
        startResultIntRequest(packet, complete: complete, error: error)
    }
}
