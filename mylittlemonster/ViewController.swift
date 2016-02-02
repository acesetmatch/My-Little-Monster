//
//  ViewController.swift
//  mylittlemonster
//
//  Created by Shawn on 1/2/16.
//  Copyright © 2016 Shawn. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var PenaltyStack: UIStackView!
    @IBOutlet weak var CharacterStackView: UIStackView!
    @IBOutlet weak var FoodStack: UIStackView!
    @IBOutlet weak var HeartFoodStackViewImg: UIStackView!
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var RestartBtn: UIButton!
    
    @IBOutlet weak var livespanelImg: UIImageView!
    @IBOutlet weak var BrownBGImg: UIImageView!
    
    @IBOutlet weak var BlackBGImg: UIImageView!
    

    @IBOutlet weak var ChooseCharacterImg: UIImageView!
    @IBOutlet weak var CharacterLbl: UILabel!
    let DIM_ALPHA: CGFloat = 0.2 //1.0 is full for opacity in graphics
    let OPAQUE: CGFloat = 1.0 //all caps means constants
    let MAX_Penalties = 3
    
    var penalties = 0
    var timer: NSTimer! //we know we're gonna have these for sure
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var isBigMonster = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
                
    }
    
    func animation() {
        CharacterStackView.hidden = true
        ChooseCharacterImg.hidden = true
        CharacterLbl.hidden = true
        monsterImg.hidden = false
        monsterImg.playIdleAnimation(isBigMonster)
        
    }
    
    @IBAction func smallmonsterOnPressed(sender: AnyObject) {
        isBigMonster = false
        BlackBGImg.hidden = false
        animation()
        RestartGame()

        
        
    }
    
    
    @IBAction func bigmonsterOnPressed(sender: AnyObject) {
        isBigMonster = true
        BlackBGImg.hidden = true
        BrownBGImg.hidden = false
        animation()
        RestartGame()

        
        
    }
    
    
    
    
    @IBAction func RestartBtnPressed(sender: AnyObject) {
        RestartBtn.hidden = true
        BlackBGImg.hidden = false
        BrownBGImg.hidden = true
        monsterImg.hidden = true
        livespanelImg.hidden = true
        FoodStack.hidden = true
        CharacterStackView.hidden = false
        ChooseCharacterImg.hidden = false
        CharacterLbl.hidden = false
       
        
        
    }
    

    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate() //stops existing timer
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    func changeGameState() {
        
        if !monsterHappy {
            penalties++
            
            sfxSkull.play()
            
            if penalties == 1{
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
            } else if penalties == 2{
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_Penalties {
                gameOver()
            }
            
        }
        
        let rand = arc4random_uniform(2) //0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimations(isBigMonster)
        sfxDeath.play()
        RestartBtn.hidden = false
        HeartFoodStackViewImg.hidden = true

    }
    
    func RestartGame() {
        RestartBtn.hidden = true
        FoodStack.hidden = false
        PenaltyStack.hidden = false
        livespanelImg.hidden = false
        HeartFoodStackViewImg.hidden = false
        monsterImg.playIdleAnimation(isBigMonster)
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        penalties = 0
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil) //listening for notification
        startTimer()

        
    }


}

