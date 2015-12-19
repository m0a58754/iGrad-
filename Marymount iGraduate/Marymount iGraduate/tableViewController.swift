//
//  tableViewController.swift
//  Marymount iGraduate
//
//  Created by Mahmood on 10/19/15.
//  Copyright (c) 2015 Mahmood. All rights reserved.
//

import Foundation
import Parse
import ParseUI

class tableViewController: PFQueryTableViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    
    @IBAction func AddItem(sender: AnyObject) {
    }
    var resultimageView = [PFObject]()
    var resultarticleView = [PFFile]()
    var searchObjects: NSMutableArray! = NSMutableArray()
    
    @IBOutlet weak var mySeachbar: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       fetchAllObjectsFromLocalDatastore()
      
        
    }
    
    //Init the PFQueryTable tableView
    override init(style: UITableViewStyle, className: String!){
        super.init(style: style, className: className)
        self.parseClassName = "_User"
        self.imageKey = "file"
        self.imageKey = "images"
        self.textKey = "title"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    //required code
    required init!(coder aDecoder: NSCoder!) {
    super.init(coder: aDecoder)
    
        //Inside req code. Configure the PFQueryTableView
    self.parseClassName = "_User"
    self.imageKey = "file"
     self.imageKey = "images"
    self.textKey = "title"
    self.pullToRefreshEnabled = true
    self.paginationEnabled = false
  
    }
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        query.orderByDescending("updatedAt")
        return query
    }
    
    //Define the query parameters that will provide the data for the tableview queryForTable
    func fetchAllObjectsFromLocalDatastore() {
        
            
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return objects!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? PFTableViewCell
        if cell == nil {
          //  cell = tableViewCellViewController(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        
        if let object = object {
         
            

            cell?.textLabel?.text = object["title"] as? String
            
           
            var initialThumbnail = UIImage(named: "one.jpg")
            
            if let thumbnail = object["image"] as? PFFile {
                
                thumbnail.getDataInBackgroundWithBlock{
                    (imageData, error) -> Void in
                    if error == nil {
                        let image = UIImage(data: imageData!)
                        cell?.imageView!.image = image
                    }}
            }
        }
        return cell
        

       
    }
    
    
    
        // Update - replace as with as!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//    self.performSegueWithIdentifier("tableviewcellshow", sender: self)
    }

    

}


