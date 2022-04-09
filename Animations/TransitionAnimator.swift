//
//  TransitionAnimator.swift
//  Animations
//
//  Created by Evans Owamoyo on 09.04.2022.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(true)
            return
        }
        guard let loadingView = presenting ? toView : transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(true)
            return
        }
        
        let initialFrame = presenting ? originFrame : loadingView.frame
        let finalFrame = presenting ? loadingView.frame : originFrame
        
        
        
        let dx = pow(initialFrame.width / finalFrame.width, presenting ? 1 : -1)
        let dy = pow(initialFrame.height / finalFrame.height, presenting ? 1 : -1)
        
        let scaleTransform = CGAffineTransform(scaleX: dx, y: dy)
        if presenting {
            loadingView.transform = scaleTransform
            loadingView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            loadingView.clipsToBounds = true
        }
        
        loadingView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(loadingView)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.2,
                       options: [.curveLinear],
                       animations: {
            loadingView.transform = self.presenting ? .identity : scaleTransform
            if self.presenting {
                loadingView.frame.origin.y = 0
            }
            loadingView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        },
                       completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    
}
