//
//  FirstViewController.swift
//  maze
//
//  Created by Ryu I on 2015/06/27.
//  Copyright (c) 2015年 Remi. All rights reserved.
//

import UIKit
import CoreMotion

class FirstViewController: UIViewController {
    let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
    
    let saveData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var motionManager: CMMotionManager!
    var imageView: UIImageView!
    var speedX: Double = 0.0
    var speedY: Double = 0.0
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    
    var score: Float = 0.0
    var count: Float = 0.0
    
    var timer: NSTimer = NSTimer()
    @IBOutlet var label: UILabel!
    
    @IBOutlet var overView1: UIImageView!
    @IBOutlet var overView2: UIImageView!
    @IBOutlet var overView3: UIImageView!
    @IBOutlet var clearView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var backBt: UIButton!
    
    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if saveData.objectForKey("count") != nil {
            count = saveData.objectForKey("count") as! Float
        }
        
        statusLabel.text = ""
        backBt.enabled = false
        backBt.hidden = true
        
        var image = UIImage(named: "dot_green")!
        imageView = UIImageView(frame: CGRect(x: self.view.center.x, y: 500, width: 30, height: 30))
        imageView.image = image
        
        self.view.addSubview(imageView)
        
        //MotionManagerを生成
        motionManager = CMMotionManager()
        
        //更新周期を設定
        motionManager.accelerometerUpdateInterval = 0.02
        
        
        self.startMotionManager()
        
        //タイマー
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01,
            target: self,
            selector: Selector("up"),
            userInfo: nil,
            repeats: true
        )

        // Do any additional setup after loading the view.
    }
    
    func startMotionManager() {
        //加速度の取得を開始
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:
            {(accelerometerData:CMAccelerometerData!, error:NSError!) -> Void in
                if (self.posX < 0 || self.posX > self.myBoundSize.width) {
                    
                    self.speedX = (-1)*self.speedX
                    
                }else if self.posY < 0 || self.posY > self.myBoundSize.height  {
                    
                    self.speedY = (-1)*self.speedY
                    
                } else {
                    
                    self.speedX += accelerometerData.acceleration.x
                    self.speedY += accelerometerData.acceleration.y
                }
                self.posX = self.imageView.center.x + CGFloat(self.speedX)
                self.posY = self.imageView.center.y - CGFloat(self.speedY)
                //NSLog("posX : %f",posX)
                //NSLog("posY : %f",posY)
                
                self.imageView.center = CGPointMake(self.posX, self.posY)
                self.gameOver()
                self.clear()
        })
    }
    
    //タイマーのやつ
    func up(){
        score = score + 0.01
        label.text = String(format: "%.2f", score)
    }
    
    //ふれたら終わるやつ
    func gameOver() {
        if CGRectContainsPoint(overView1.frame, imageView.center) {
            statusLabel.text = "Game Over!"
            backBt.enabled = true
            backBt.hidden = false
            if (motionManager.accelerometerActive) {
                motionManager.stopAccelerometerUpdates()
                timer.invalidate()
            }
        }
        if CGRectContainsPoint(overView2.frame, imageView.center) {
            statusLabel.text = "Game Over!"
            backBt.enabled = true
            backBt.hidden = false
            if (motionManager.accelerometerActive) {
                motionManager.stopAccelerometerUpdates()
                timer.invalidate()
            }
        }
        if CGRectContainsPoint(overView3.frame, imageView.center) {
            statusLabel.text = "Game Over!"
            backBt.enabled = true
            backBt.hidden = false
            if (motionManager.accelerometerActive) {
                motionManager.stopAccelerometerUpdates()
                timer.invalidate()
            }
        }
    }
    
    //ふれたらクリア
    func clear() {
        if CGRectContainsPoint(clearView.frame, imageView.center) {
            statusLabel.text = "Clear!"
            statusLabel.textColor = UIColor.blueColor()
            backBt.enabled = true
            backBt.hidden = false
            if (motionManager.accelerometerActive) {
                motionManager.stopAccelerometerUpdates()
                timer.invalidate()
            }
            if(count == 0 || score < count){
                count = score
                saveData.setObject(count, forKey: "count")
                saveData.synchronize()
            }
        }
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
