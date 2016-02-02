//
//  smallMonsterImg.swift
//  mylittlemonster
//
//  Created by Shawn on 1/3/16.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit

class smallmonsterImg: MonsterImg {

    override func playIdleAnimation() {
        
            self.image = UIImage(named: "smallidle1.png")
            
            self.animationImages = nil
            
            var imgArray = [UIImage]()
            for var x = 1; x <= 4; x++ { //starts at idle1 to loops to idle4
                let img = UIImage(named: "smallidle\(x).png") //make a constant
                imgArray.append(img!) //! can trust can this specific choice since we know img is there
                
            }
            
            self.animationImages = imgArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 0 //going to animate infinitely
            self.startAnimating()
        
    }


    override func playDeathAnimations() {
        
        self.image = UIImage(named: "smalldead5.png")
        
        self.animationImages = nil //clears the array
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 5; x++ { //starts at idle1 to loops to idle4
            let img = UIImage(named: "smalldead\(x).png") //make a constant
            imgArray.append(img!) //! can trust can this specific choice since we know img is there
            
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //going to animate infinitely
        self.startAnimating()
    }

}

