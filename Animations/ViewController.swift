//
//  ViewController.swift
//  Animations
//
//  Created by Evans Owamoyo on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var manualAnimateSlider: UISlider!
    
    // gesture recognizer
    lazy var recognizer: UITapGestureRecognizer = {
        let rec = UITapGestureRecognizer(target: self,
                                         action: #selector(self.onImageTapped))
        return rec
    }()
    
    // property animator
    let animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
    let transitionAnimator = TransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialSetup()
        configureAnimations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(recognizer)
    }
    
    func configureInitialSetup() {
        
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
        
        self.animator.addAnimations ({ [weak self] in
            self?.hintLabel.text = "Click the Image"
        }, delayFactor: 0.3)
        
        
        self.animator.addAnimations({
            self.image.frame.origin.y -= 100
        }, delayFactor: 0.5)
        
    }
    
    @IBAction func onManualSliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func onImageTapped() {
        UIView.animate(withDuration: 1) {
            self.animator.fractionComplete = 1.0
            self.manualAnimateSlider.value = 1.0
        } completion: { _ in
            self.performSegue(withIdentifier: "navigate", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsViewController {
            detailsVC.transitioningDelegate = self
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.originFrame = image.frame
        transitionAnimator.presenting = true
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.presenting = false
        return transitionAnimator
    }
}

