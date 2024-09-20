//
//  SettingsViewController.swift
//  7323assignment1
//
//  Created by Tong Li on 9/19/24.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var brightnessSlider: UISlider!
    
    // 创建 IBOutlet 以访问 Storyboard 中的 UIDatePicker 和 UILabel
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBAction func brightnessSliderChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
                    let brightness = slider.value  // 获取Slider的值
                    UIScreen.main.brightness = CGFloat(brightness)  // 设置屏幕亮度
                }
    }
    
    
    
    @IBOutlet weak var darkModelSwitch: UISwitch!
   
    @IBAction func darkModelSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
                // 启用暗夜模式
                overrideUserInterfaceStyle = .dark
                UserDefaults.standard.set(true, forKey: "isDarkMode")
            } else {
                // 禁用暗夜模式
                overrideUserInterfaceStyle = .light
                UserDefaults.standard.set(false, forKey: "isDarkMode")
            }

            // 广播通知其他视图控制器更新界面风格
            NotificationCenter.default.post(name: NSNotification.Name("DarkModeChanged"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brightnessSlider.value = Float(UIScreen.main.brightness)
        // Do any additional setup after loading the view.
        // 从 UserDefaults 中读取暗夜模式设置
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        darkModelSwitch.isOn = isDarkMode
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        
        // 检查是否保存了用户的生日
        if let savedDate = UserDefaults.standard.object(forKey: "userBirthday") as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none

            // 更新 UIDatePicker 和 UILabel 显示已保存的生日
            datePicker.date = savedDate
            birthdayLabel.text = "My Birthday: \(dateFormatter.string(from: savedDate))"
        } else {
            birthdayLabel.text = "My Birthday: Not set"
        }
        
        // 设置初始生日显示
        // birthdayLabel.text = "My Birthday: Not set"
                
        // 设置 DatePicker 的默认值为当前日期
        datePicker.date = Date()

        // 监听 DatePicker 的值变化事件
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
           
    }
    
    // 定义 IBAction，当日期改变时调用
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        // 获取选中的日期并格式化为字符串
        let selectedDate = dateFormatter.string(from: sender.date)
            
        // 更新 UILabel 显示生日
        birthdayLabel.text = "My Birthday: \(selectedDate)"
        
        // 保存选中的日期到 UserDefaults
        UserDefaults.standard.set(sender.date, forKey: "userBirthday")
    }
    


}
