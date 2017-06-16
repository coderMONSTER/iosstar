//
//  MarketSBFansCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketSBFansCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        price.textColor = UIColor.init(hexString: AppConst.Color.orange)
        
    }

    
    func setOrderFans(model:OrderFansListModel,isBuy:Bool) {
        var headerUrl = ""
        var name = ""
        if isBuy {
            headerUrl = (model.buy_user!.headUrl)
            name = model.buy_user!.nickname
        } else {
            headerUrl = model.sell_user!.headUrl
            name = model.sell_user!.nickname
        }
        dateLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(model.trades!.closeTime, format: "MM-DD HH:MM:SS")

       iconImageView.kf.setImage(with: URL(string: headerUrl))
        nameLabel.text = name
        price.text = "\(model.trades!.openPrice)元/秒"
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
