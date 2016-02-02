//
//  MonsterImg.swift
//  mylittlemonster
//
//  Created by Shawn on 1/2/16.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func playIdleAnimation(isBigMonster: Bool) {
        
        if (isBigMonster == false) {
            self.image = UIImage(named: "blue_idle1.png")
            
            self.animationImages = nil
            
            var imgArray = [UIImage]()
            for var x = 1; x <= 4; x++ { //starts at idle1 to loops to idle4
                let img = UIImage(named: "blue_idle\(x).png") //make a constant
                imgArray.append(img!) //! can trust can this specific choice since we know img is there
                
            }
            
            self.animationImages = imgArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 0 //going to animate infinitely
            self.startAnimating()
        } else {
        
            self.image = UIImage(named: "pink_idle1.png")
            
            self.animationImages = nil //clears the array
            
            var imgArray = [UIImage]()
            for var x = 1; x <= 4; x++ { //starts at idle1 to loops to idle4
                let img = UIImage(named: "pink_idle\(x).png") //make a constant
                imgArray.append(img!) //! can trust can this specific choice since we know img is there
                
            }
            
            self.animationImages = imgArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 0 //going to animate infinitely
            self.startAnimating()
        }
        
    }

    func playDeathAnimations(isBigMonster: Bool) {
        if (isBigMonster == false) {
            self.image = UIImage(named: "blue_dead1.png")
            
            self.animationImages = nil
            
            var imgArray = [UIImage]()
            for var x = 1; x <= 3; x++ { //starts at idle1 to loops to idle4
                let img = UIImage(named: "blue_dead\(x).png") //make a constant
                imgArray.append(img!) //! can trust can this specific choice since we know img is there
                
            }
            
            self.animationImages = imgArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 1 //going to animate infinitely
            self.startAnimating()
        } else {
            
            self.image = UIImage(named: "pink_dead1.png")
            
            self.animationImages = nil //clears the array
            
            var imgArray = [UIImage]()
            for var x = 1; x <= 3; x++ { //starts at idle1 to loops to idle4
                let img = UIImage(named: "pink_dead\(x).png") //make a constant
                imgArray.append(img!) //! can trust can this specific choice since we know img is there
                
            }
            
            self.animationImages = imgArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 1 //going to animate infinitely
            self.startAnimating()
        }
    }
    
}

