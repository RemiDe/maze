//
//  ThirdViewController.swift
//  maze
//
//  Created by Ryu I on 2015/04/18.
//  Copyright (c) 2015年 Remi. All rights reserved.
//

import UIKit
import CoreMotion

class ThirdViewController: UIViewController {
    
    var motionManager: CMMotionManager!
    var speedX: Double = 0.0
    var speedY: Double = 0.0
    private var dot: UIImageView!
    
    @IBOutlet var overView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIImageViewを作成する.
        dot = UIImageView(frame: CGRectMake(0,0,30,30))
        // 表示する画像を設定する.
        let myImage = UIImage(named: "dot_green.png")
        // 画像をUIImageViewに設定する.
        dot.image = myImage
        // 画像の表示する座標を指定する.
        dot.layer.position = CGPoint(x: self.view.bounds.width/2, y: 500.0)
        // UIImageViewをViewに追加する.
        self.view.addSubview(dot)
        
        //MotionManagerを生成
        motionManager = CMMotionManager()
        
        //更新周期を設定
        motionManager.accelerometerUpdateInterval = 0.02
        
        
        self.startMotionManager()
    }
    
        func startMotionManager() {
            //加速度の取得を開始
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler:
                {(accelerometerData:CMAccelerometerData!, error:NSError!) -> Void in
                    
                self.speedX += accelerometerData.acceleration.x
                self.speedY += accelerometerData.acceleration.y
                    
                var posX = self.dot.center.x + CGFloat(self.speedX)
                var posY = self.dot.center.y + CGFloat(self.speedY)
                    
                self.dot.center = CGPointMake(posX, posY)
                //self.checkGameOver()
            })
        }
    
    //ふれたら終わるやつ
    func gameOver(){
        if CGRectContainsPoint(overView.frame, dot.center){
            if (motionManager.accelerometerActive){
                motionManager.stopAccelerometerUpdates()
            }
        }
    }
    
            // Do any additional setup after loading the view.
    
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
