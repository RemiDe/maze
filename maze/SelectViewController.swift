//
//  SelectViewController.swift
//  maze
//
//  Created by Ryu I on 2015/06/27.
//  Copyright (c) 2015年 Remi. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {
    let saveData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let saveData2:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let saveData3:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var count: Float = 0.0
    var count2: Float = 0.0
    var count3: Float = 0.0
    
    @IBOutlet var time: UILabel!
    @IBOutlet var time2: UILabel!
    @IBOutlet var time3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if saveData.objectForKey("count") != nil {
            count = saveData.objectForKey("count") as! Float
        }
        time.text = String(format: "%.2f",count)
        
        if saveData2.objectForKey("count2") != nil {
            count2 = saveData.objectForKey("count2") as! Float
        }
        time2.text = String(format: "%.2f",count2)
        
        if saveData3.objectForKey("count3") != nil {
            count3 = saveData.objectForKey("count3") as! Float
        }
        time3.text = String(format: "%.2f",count3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modoru(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
