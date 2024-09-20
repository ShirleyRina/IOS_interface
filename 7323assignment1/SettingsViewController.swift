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
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
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
        
        // 从 UserDefaults 中读取已保存的性别
        if let savedGender = UserDefaults.standard.string(forKey: "userGender") {
                selectedGender = savedGender

            // 更新 Segmented Control 的选择
            switch savedGender {
            case "male":
                genderSegmentedControl.selectedSegmentIndex = 0
            case "female":
                genderSegmentedControl.selectedSegmentIndex = 1
            case "non-binary":
                genderSegmentedControl.selectedSegmentIndex = 2
            default:
                genderSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
            }
        } else {
            genderLabel.text = "My gender is __"
        }
        genderSegmentedControl.isHidden = true // 初始隐藏 Segmented Control

        // 添加点击手势识别器
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        genderLabel.isUserInteractionEnabled = true
        genderLabel.addGestureRecognizer(tapGesture)
        updateGenderLabel()
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
    
    // 当前性别，默认未选择
    var selectedGender: String? {
        didSet {
            if let gender = selectedGender {
                genderLabel.text = "My gender is \(gender)"
                updateGenderLabel()
                genderSegmentedControl.isHidden = true // 隐藏选择控件
            }
        }
    }
    
    // 点击性别标签时显示 Segmented Control
    @objc func labelTapped() {
        genderSegmentedControl.isHidden = false
    }
    
    // 当用户在 Segmented Control 中选择性别时更新 label
    @IBAction func genderSelectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedGender = "male"
            UserDefaults.standard.set("male", forKey: "userGender")
        case 1:
            selectedGender = "female"
            UserDefaults.standard.set("female", forKey: "userGender")
        case 2:
            selectedGender = "non-binary"
            UserDefaults.standard.set("non-binary", forKey: "userGender")
        default:
            break
        }
        // 确保数据保存到 UserDefaults 中
        UserDefaults.standard.synchronize()
    }

    
    // 更新 UILabel 并为选中的性别或 "__" 设置背景色
    func updateGenderLabel() {
        let genderText = selectedGender ?? "__"
        let fullText = "My gender is \(genderText)"

        // 创建一个可变的富文本
        let attributedString = NSMutableAttributedString(string: fullText)

        // 找到需要高亮的部分 (即 "__" 或选中的性别)
        let range = (fullText as NSString).range(of: genderText)

        // 设置背景颜色为浅蓝色
        attributedString.addAttribute(.backgroundColor, value: UIColor.systemBlue.withAlphaComponent(0.3), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: range)

        // 设置富文本到 UILabel
        genderLabel.attributedText = attributedString
    }

}
