//
//  ViewController.swift
//  Animations
//
//  Created by Evans Owamoyo on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var manualAnimateSlider: UISlider!
    @IBOutlet weak var autoAnimateSwitch: UISwitch!
    
    // gesture recognizer
    lazy var recognizer: UITapGestureRecognizer = {
        let rec = UITapGestureRecognizer(target: self, action: #selector(self.onImageTapped))
        return rec
    }()
    
    // property animator
    let animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(recognizer)
        configureInitialSetup()
        configureAnimations()
//        animator.startAnimation()
    }
    
    func configureInitialSetup() {
        manualAnimateSlider.isEnabled = false
        autoAnimateSwitch.isOn = false
        
        manualAnimateSlider.value = 0
        image.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        image.alpha = 0
        
    }
    
    func configureAnimations() {
        self.animator.addAnimations {
            self.image.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.image.transform = CGAffineTransform(rotationAngle: Double.pi)
            self.image.alpha = 1.0
        }
        
        
        self.animator.addAnimations({
            self.image.frame.origin.y -= 100
        }, delayFactor: 0.5)
        
    }
    
    @IBAction func onManualAnimate(_ sender: UISwitch) {
        manualAnimateSlider.isEnabled = sender.isOn
        if !sender.isOn {
            animator.stopAnimation(true)
        }
    }
    
    @IBAction func onManualSliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func onImageTapped() {
        print("Handled")
    }
    
    
    
}

