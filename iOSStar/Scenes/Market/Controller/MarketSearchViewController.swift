//
//  MarketSearchViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class MarketSearchViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.cornerRadius = 1
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = "搜索"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(hexString: AppConst.Color.main)
        navigationItem.titleView = label

    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        SVProgressHUD.showInfo(withStatus: "完善中")
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MarketSearchViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
