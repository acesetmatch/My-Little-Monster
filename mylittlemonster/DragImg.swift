//
//  DragImg.swift
//  mylittlemonster
//
//  Created by Shawn on 1/2/16.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView {
    
    var originalPosition: CGPoint! //x,y coordinate
    var dropTarget: UIView? //can drop over the image or over the view
    
    override init(frame:CGRect) {
        super.init(frame:frame) //calling parent initializer
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center //self image view. need to place here rather than initalizer to guarantee the center view
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y) //moves the object or sets the x and y position of the object that is moved
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview)
            
            if CGRectContainsPoint(target.frame, position) {
                
                //var notif = NSNotification(name: "ontTargetDropped", object: nil) same as below code
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil)) //creating a new notifiaction
            }
        }
        self.center = originalPosition
    }
}