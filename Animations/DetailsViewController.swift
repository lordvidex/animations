//
//  DetailsViewController.swift
//  Animations
//
//  Created by Evans Owamoyo on 09.04.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageLarge: UIImageView!
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLarge.transform = CGAffineTransform(rotationAngle: Double.pi)
    }
    
    @IBAction func onTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .curveEaseIn) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    @IBAction func onTouchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: .curveEaseIn) {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in
            self.dismiss(animated: true)
        }
        
        
        
        
    }
}
