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
    
    
    var countdownTimer: Timer? // Timer for the countdown
    var countdownValue: Int = 5  // Countdown starts from 5 each time
    var imageIndex = 0  // Current image index to display
        
    // Image list
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
        // Initialize Stepper and Label
        fontSizeStepper.minimumValue = 10  // Minimum font size
        fontSizeStepper.maximumValue = 30  // Maximum font size
        fontSizeStepper.stepValue = 1      // Step size for increasing/decreasing font
        fontSizeStepper.value = 20         // Initial font size
        fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSizeStepper.value))  // Initialize label font size
        // Set initial image
        imageView.image = images[imageIndex]
        countdownLabel.text = "5"
        
        // Initialize timer, call changeImage method every 5 seconds
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)

    }
    
    @objc func updateCountdown() {
            countdownValue -= 1
            countdownLabel.text = "\(countdownValue)"  // Update countdown label
            
            if countdownValue == 0 {
                // When countdown ends, switch the image
                changeImage()
                // Reset countdown
                countdownValue = 5
            }
        }
    
    @objc func changeImage() {
        // Switch to the next image
        imageIndex = (imageIndex + 1) % images.count
        imageView.image = images[imageIndex]
    }
    
    // Stop the timer when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            countdownTimer?.invalidate()  // Stop the countdown timer
        }

}

