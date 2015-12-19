//
//  tableViewCellViewController.swift
//  Marymount iGraduate
//
//  Created by Mahmood on 11/6/15.
//  Copyright (c) 2015 Mahmood. All rights reserved.
//
import Parse
import ParseUI
import Foundation
import UIKit

class tableViewCellViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView! = UIImageView()
    var resultimageView = [PFObject]()
    var resultarticleView = [PFFile]()
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testParseSaveIssue()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testParseSaveIssue() {
        
        let str = "Working at Parse is great!"
        let data = str.dataUsingEncoding(NSUTF8StringEncoding)
        let file = PFFile(name:"I made it into Parse.txt", data:data!)
        
        file.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) -> Void in
            // Handle success or failure here ...
            if succeeded {
                println("Save successful")
            } else {
                println("Save unsuccessful: \(error?.userInfo)")
            }
            
            }, progressBlock: { (percentDone: Int32) -> Void in
                // Update your progress spinner here. percentDone will be between 0 and 100.
        })
        
        var jobApplication = PFObject(className:"User")
        if let jobApplication = PFUser.currentUser()?["file"] as? PFFile {
            
        }
      
    }
  */
    override func viewDidAppear(animated: Bool) {
        
   
     
        var query = PFQuery(className:"_User")
        
       // query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
    
        
      //  query.findObjectsInBackgroundWithBlock { ( objects: [AnyObject]?, error: NSError?) -> Void in
      
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
        
  
      if let objects = objects {
        for object in objects {
  
            if let resultView = PFUser.currentUser()?["file"] as? PFFile {
   //  if let resultView = object.valueForKey("file") as? PFFile {
            
              
            
            //Thats NOT unwrapped ? Need to use !
            resultView.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                
                 // let data = object.dataUsingEncoding(NSUTF8StringEncoding)
                    let image = UIImage(data: data!)
                     self.imageView.image = UIImage(data: data!)
                   // self.resultarticleView.append(object.objectForKey("file") as! PFFile)
                    
                    println(data)
                    
                    
                            }
                        }
                }
                }
            }
        
       
        })


    }

}


