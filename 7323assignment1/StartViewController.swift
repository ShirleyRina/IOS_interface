//
//  StartViewController.swift
//  7323assignment1
//
//  Created by shirley on 9/19/24.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var fontSizeLabel: UILabel!
    
    @IBOutlet weak var fontSizeStepper: UIStepper!
    
    
    @IBAction func fontSizeStepperChanged(_ sender: UIStepper) {
        let newFontSize = CGFloat(sender.value)
                fontSizeLabel.font = UIFont.systemFont(ofSize: newFontSize)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    var countdownTimer: Timer? // 用于倒计时的定时器
    var countdownValue: Int = 5  // 每次倒计时从 5 开始
    var imageIndex = 0  // 当前展示图片的索引
        
    // 图片列表
    let images: [UIImage] = [
        UIImage(named: "book1")!,
        UIImage(named: "book2")!,
        UIImage(named: "book3")!,
        UIImage(named: "book4")!,
        UIImage(named: "book5")!,
        UIImage(named: "book6")!
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化 Stepper 和 Label
        fontSizeStepper.minimumValue = 10  // 最小字号
        fontSizeStepper.maximumValue = 30  // 最大字号
        fontSizeStepper.stepValue = 1      // 每次增加/减少的字号
        fontSizeStepper.value = 20         // 初始字号
        fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSizeStepper.value))  // 初始化 Label 字体大小
        // 设置初始图片
        imageView.image = images[imageIndex]
        countdownLabel.text = "5"
        
        // 初始化定时器，每隔5秒调用一次 changeImage 方法
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)


    }
    @objc func updateCountdown() {
            countdownValue -= 1
            countdownLabel.text = "\(countdownValue)"  // 更新倒计时 Label
            
            if countdownValue == 0 {
                // 倒计时结束时，切换图片
                changeImage()
                // 重置倒计时
                countdownValue = 5
            }
        }
    @objc func changeImage() {
        // 切换到下一个图片
        imageIndex = (imageIndex + 1) % images.count
        imageView.image = images[imageIndex]
    }
    
    // 在视图消失时停止定时器
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            countdownTimer?.invalidate()  // 停止倒计时定时器
        }




}
