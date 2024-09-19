//
//  SettingsViewController.swift
//  7323assignment1
//
//  Created by Tong Li on 9/19/24.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var brightnessSlider: UISlider!
    
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
    }
    


}
