//
//  UIExtensions.swift
//  Rapptr iOS Test
//
//  Created by Sebastian Banks on 5/8/22.
//

import Foundation
import UIKit

extension UIColor {
    static var appBlue = UIColor(named: "appBlue")
    static var viewBackground = UIColor(named: "viewBackground")
    static var chatBubbleBackground = UIColor(named: "chatBubble")
}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.2, delay: TimeInterval = 0.2, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.3
        }, completion: completion)
    }
}

