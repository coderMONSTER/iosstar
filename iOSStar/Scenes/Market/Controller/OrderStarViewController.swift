//
//  OrderStarViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class OrderType : UITableViewCell{
    
    // 具体时间
    @IBOutlet weak var orderAccount: UILabel!
    // 约见时间
    @IBOutlet weak var orderType: UILabel!
    // 意见反馈
    @IBOutlet weak var feedBack: UITextView!

    
}

// MRAK: - viewDidLoad
class OrderStarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // @IBOutlet weak var pageControl: UIPageControl!
    // 意见反馈
    var feedBack : UITextView!
    // 约见时间
    var orderTime: UILabel!
    // 约见地址
    var orderPalace: UILabel!
    
    // 假的框为了弹出(Date)键盘
    @IBOutlet weak var inputDateTextField: UITextField!
    // datePickerView
    var datePickerView = UIDatePicker()
    // dateToolBar
    var dateToolBar = UIToolbar()
    
    // 假的框为了弹出(city)键盘
    @IBOutlet weak var inputCityTextField: UITextField!
    // cityPickerView
    var cityPickerView = UIPickerView()
    // cityToolBar
    var cityToolBar = UIToolbar()
    //  cityList
    var dataCity = Array<Dictionary<String, AnyObject>>()
    // cityPickerView选择的row (省份)
    var selectRow = 0
    // cityPickerView选择的Componentow (市)
    var selectComponent = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        tableView.showsVerticalScrollIndicator = false
        
        setupNav()
        
        initCity()
        initCityPickerView()
        
        initDatePickerView()
     
    // 通知
    NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // 键盘显示的通知
    func keyBoardWillShow(_ notification: Notification){
        tableView.scrollToRow(at: NSIndexPath.init(row: 4, section: 0) as IndexPath, at: .bottom, animated: true)
    }
    


  
}
// MARK: - date相关
extension OrderStarViewController {
 
    func initDatePickerView(){
        
        datePickerView =  UIDatePicker.init(frame: CGRect.init(x: 0,
                                                               y: 0,
                                                               width: self.view.frame.size.width,
                                                               height: 120))
        inputDateTextField.inputView = datePickerView
        
        dateToolBar = UIToolbar.init(frame:  CGRect.init(x: 0,
                                                         y: self.view.frame.size.height - self.dateToolBar.frame.size.height - 44.0,
                                                         width: self.view.frame.size.width,
                                                         height: 44))
        
        inputDateTextField.inputAccessoryView = dateToolBar
        
        let local = Locale.init(identifier: "zh_CN")
        datePickerView.locale = local
        datePickerView.datePickerMode = .date
        
        // 确定按钮
        let sure : UIButton = UIButton.init(frame: CGRect.init(x: 0,
                                                               y: 0,
                                                               width: 40,
                                                               height: 44))
        sure.setTitle("确定", for: .normal)
        let sureItem : UIBarButtonItem = UIBarButtonItem.init(customView: sure)
        sure.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        sure.addTarget(self, action: #selector(datesureClick), for: .touchUpInside)
        
        
        let space : UIButton = UIButton.init(frame: CGRect.init(x: 40,
                                                                y: 0,
                                                                width: self.view.frame.size.width-140,
                                                                height: 44))
        space.setTitle("", for: .normal)
        let spaceItem : UIBarButtonItem = UIBarButtonItem.init(customView: space)
        
        // 取消按钮
        let cancel : UIButton = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width-44,
                                                                 y: 0,
                                                                 width: 40,
                                                                 height: 44))
        cancel.setTitle("取消", for: .normal)
        cancel.addTarget(self, action: #selector(datecancelClick), for: .touchUpInside)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        let cancelItem : UIBarButtonItem = UIBarButtonItem.init(customView: cancel)
        
        dateToolBar.setItems([sureItem,spaceItem,cancelItem], animated: true)
        
    }
}

extension OrderStarViewController {
    
    // 确定时间按钮
    func datesureClick() {
        
        // 获取选择时间的字符串
        let time = Date.yt_convertDateToStr(datePickerView.date, format: "yyyy-MM-dd")
        
        let chooseDate = datePickerView.date
        // 只能选择大于今天的时间
        if chooseDate.timeIntervalSince(NSDate() as Date) <= 0 {
            
            /** 最好提示用户,且选择当前的时间*/
            print("不能选择之前的时间")
            let nowTime = Date.yt_convertDateToStr(NSDate() as Date, format: "yyyy-MM-dd")
            orderTime.text = nowTime
            inputDateTextField.resignFirstResponder()
            return
            
        } else {
            orderTime.text = time

            inputDateTextField.resignFirstResponder()
        }
    }
    func datecancelClick() {
        
        inputDateTextField.resignFirstResponder()
    }
}


// MARK: - city相关
extension OrderStarViewController {
    
    // 获取cityData
    fileprivate func initCity() {
        
        let address : String =  Bundle.main.path(forResource: "City", ofType: "plist")!
        
        let dic =  NSDictionary.init(contentsOfFile: address) as! [String : Array<Any>]

        dataCity = dic["city"]! as! Array<Dictionary<String, AnyObject>> as Array<Dictionary<String, AnyObject>>
    
        // print(dataCity)
    }
    
    
    // cityPickerView
    fileprivate func initCityPickerView(){
        
        cityPickerView = UIPickerView.init()
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        
        cityToolBar = UIToolbar.init(frame:  CGRect.init(x: 0,
                                                       y: self.view.frame.size.height - self.cityToolBar.frame.size.height - 44.0,
                                                       width: self.view.frame.size.width,
                                                       height: 44))
        
        inputCityTextField.inputView = cityPickerView
        inputCityTextField.inputAccessoryView = cityToolBar
        
        // 确定按钮
        let sure : UIButton = UIButton.init(frame: CGRect.init(x: 0,
                                                               y: 0,
                                                               width: 40,
                                                               height: 44))
        sure.setTitle("确定", for: .normal)
        sure.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        sure.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        let sureItem : UIBarButtonItem = UIBarButtonItem.init(customView: sure)
        
        let space : UIButton = UIButton.init(frame: CGRect.init(x: 40, y: 0, width: self.view.frame.size.width-140, height: 44))
        space.setTitle("", for: .normal)
        let spaceItem : UIBarButtonItem = UIBarButtonItem.init(customView: space)
        
        // 取消按钮
        let cancel : UIButton = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width-44,
                                                                 y: 0,
                                                                 width: 40,
                                                                 height: 44))
        cancel.setTitle("取消", for: .normal)
        cancel.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        let cancelItem : UIBarButtonItem = UIBarButtonItem.init(customView: cancel)
        
        cityToolBar.setItems([sureItem,spaceItem,cancelItem], animated: true)
    }
}

extension OrderStarViewController {
    
    // city确定按钮事件
    func sureClick(){
        
        let dic : Dictionary = dataCity[selectComponent]
        let name = dic["name"] as! String
        let arr : Array = (dic[name] as AnyObject) as! Array<AnyObject>
        let nameDic = arr[selectRow]["name"]
        
        if nameDic != nil {
            orderPalace.text = nameDic as? String
        }
        inputCityTextField.resignFirstResponder()
        selectRow = 0
        selectComponent = 0
        cityPickerView.selectRow(selectComponent, inComponent: 0, animated: true)
        cityPickerView.selectRow(0, inComponent: 1, animated: true)
        
    }
    
    func cancelClick(){
        selectRow = 0
        selectComponent = 0
        cityPickerView.selectRow(0
            , inComponent: 0, animated: true)
        cityPickerView.selectRow(0
            , inComponent: 1, animated: true)
        
        
        inputCityTextField.resignFirstResponder()
        
    }
}

// MARK: - cityPickerView [DataSource -- Delegate]
extension OrderStarViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return dataCity.count
            
        }else{
            
            let dic : Dictionary = dataCity[selectComponent]
            let name = dic["name"] as! String
            let arr : Array = dic[name] as! Array<AnyObject>
            return  arr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            
            return  dataCity[row]["name"] as? String
            
        }else{
            
            let dic : Dictionary = dataCity[selectComponent]
            let name = dic["name"] as! String
            let arr : Array = (dic[name] as AnyObject) as! Array<AnyObject>
            let nameDic = arr[row]["name"]
            return nameDic as? String
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0{
            
            selectComponent = row
            pickerView.reloadComponent(1)
            
        }else{
            
            selectRow = row
        }
    }
}

// MARK: - 设置UI
extension OrderStarViewController {
    
    fileprivate func setupNav() {
        setCustomTitle(title: "约见名人")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "record_selected"), style: .done, target: self, action: #selector(rightButtonItemClick(_ :)))
    }
}

// MARK: - 导航点击事件
extension OrderStarViewController {
    
    // 右边导航栏点击事件
    @objc fileprivate func rightButtonItemClick(_ sender : Any) {
        
        print("点击了右边按钮");
    }
}

// MARK: - tableView [DataSource -- Delegate]
extension OrderStarViewController :UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 181
        }
        
        if indexPath.row == 1 {
            return 197
        }
        
        if indexPath.row == 2 {
            return 45
        }
        
        if indexPath.row == 3 {
            return 45
        }
        
        if indexPath.row == 4 {
            return 200
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell")
        
        if indexPath.row == 0 {
            cell?.selectionStyle = .none
            return cell!
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell")
            cell?.selectionStyle = .none
            return cell!
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTime") as! OrderType
            orderTime = cell.orderAccount
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCity") as! OrderType
            cell.selectionStyle = .none
            orderPalace = cell.orderAccount
            return cell
        }
        if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell") as! OrderType
            feedBack = cell.feedBack
            cell.selectionStyle = .none
            return cell
        }
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            
            inputDateTextField.becomeFirstResponder()
        }
        
        if indexPath.row == 3 {
            
            inputCityTextField.becomeFirstResponder()
        }
    }
    
}




