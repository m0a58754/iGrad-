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
import WebKit

class tableViewCellViewController: UIViewController {
    @IBOutlet weak var loadindicator: UIActivityIndicatorView!


 @IBOutlet weak var documentWebView: UIWebView?

    var urlpath = String()
    
    func loadAddressUrl(){
        
        
        let requestURL = NSURL (string:urlpath)
        let request = NSURLRequest(URL: requestURL!)
        documentWebView!.loadRequest(request)
        
        alaCarteUpdate()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        clearPDFBackground(self.documentWebView!)
        
        
        
    }
    
    func clearPDFBackground(webView: UIWebView) {
        var view :UIView?
        view = webView as UIView
        
        while view != nil {
            if NSStringFromClass((view?.dynamicType)!) == "UIWebPDFView" {
                view?.backgroundColor = UIColor.clearColor()
                
            }
            
            view = view?.subviews.first 
            
        }
    }
    
    func alaCarteUpdate() {
        let query = PFQuery(className: "_User")
        query.findObjectsInBackgroundWithBlock {(objects : [AnyObject]?, error: NSError?) -> Void in
        
            if error == nil && objects != nil {
            let pdfFile = PFUser.currentUser()?["file"] as? PFFile
                    if let currentPDF = pdfFile {
                        if currentPDF.url != nil {
                            let urlFromParse = NSURL(string: currentPDF.url!)
                            let request = NSURLRequest(URL: urlFromParse!)
                            self.documentWebView?.loadRequest(request)
                        }
                }
                
            
            } else {
                print("Did not load \(objects)")
            }
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAddressUrl()

    func webViewDidStartLoad(webView: UIWebView!) {
        loadindicator.hidden = false
        loadindicator.startAnimating()
        print("Webview started Loading", terminator: "")
    }
    
    func webViewDidFinishLoad(webView: UIWebView!) {
        loadindicator.hidden = true
        loadindicator.stopAnimating()
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
 /*   var object = nil as PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if let object = self.object {
            let title = object["title"] as? String
            self.navigationItem.title = title
            
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            var documentsDir = paths.firstObject as! String
            if documentsDir.hasSuffix("/") == false {
                documentsDir = documentsDir + "/"
            }
            let filePath = documentsDir + title! + ".pdf"
            print(filePath)
            
            let fileManager = NSFileManager.defaultManager() as NSFileManager
            if fileManager.fileExistsAtPath(filePath) {
                let fileUrl = NSURL.fileURLWithPath(filePath) as NSURL?
                self.documentWebView?.loadRequest(NSURLRequest(URL: fileUrl!))
            }
            else {
                
                let pdfFile = PFUser.currentUser()?["file"] as? PFFile
                if let pdfFile = pdfFile {
                    pdfFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                        if let pdfData = data as NSData? {
                            pdfData.writeToFile(filePath, atomically: true)
                            
                            let fileUrl = NSURL.fileURLWithPath(filePath) as NSURL?
                            self.documentWebView?.loadRequest(NSURLRequest(URL: fileUrl!))
                        }
                    }
                }
            }
        }
    
  
    }

}

  let currentObjects = PFObject?()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseUpdate()
        
    }
    func parseUpdate() {
        
        if let object = self.currentObjects {
            let pdfOutput = object["file"] as! PFFile!
            if let currentPDF = pdfOutput {
                if currentPDF.url != nil {
                    let urlFromParse = NSURL(string: currentPDF.url!)
                    let request = NSURLRequest(URL: urlFromParse!)
                    self.documentWebView?.loadRequest(request)
                }
            }
            
        
        }
       
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

var currentObject = PFObject?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let object = currentObject {
            
            let pdfResults:PFFile! = object.objectForKey("file") as! PFFile
            if let currentPDF = pdfResults {
                if currentPDF.url != nil {
                    let urlFromParse = NSURL(string: currentPDF.url!)
                    let request = NSURLRequest(URL: urlFromParse!)
                    self.documentWebView?.loadRequest(request)
                }
                
            }
        }
        
    }

    func webViewDidStartLoad(webView: UIWebView) {
        loadIndicator.hidden = false
        loadIndicator.startAnimating()
        print("Webview started Loading", terminator: "")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadIndicator.hidden = true
        loadIndicator.stopAnimating()
    }

}


    var object = nil as PFObject?
    var resultimageView = [PFObject]()
    var resultarticleView = [PFFile]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
        self.view.backgroundColor = UIColor.whiteColor()
        
        if let object = self.object {
            
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            var documentsDir = paths.firstObject as! String
            if documentsDir.hasSuffix("/") == false {
                documentsDir = documentsDir + "/"
            }
            let filePath = documentsDir + title! + ".pdf"
            println(filePath)
            
            let fileManager = NSFileManager.defaultManager() as NSFileManager
            if fileManager.fileExistsAtPath(filePath) {
                let fileUrl = NSURL.fileURLWithPath(filePath) as NSURL?
                self.documentWebView?.loadRequest(NSURLRequest(URL: fileUrl!))
            }
            else {
            //converting pfObject into PFFile. if let statement to finish converting into pffile now it is useable as PFFile
            let pdfFile = object["file"] as? PFFile
            if let pdfFile = pdfFile {
                
                //add bracket
                pdfFile.getDataInBackgroundWithBlock {(data, error) -> Void in
                    if let pdfData = data as NSData? {
                       
                        pdfData.writeToFile(filePath, atomically: true)
                        
                        let fileUrl = NSURL.fileURLWithPath(filePath) as NSURL?
                        self.documentWebView?.loadRequest(NSURLRequest(URL: fileUrl!))
                       
                    }
                    
                
                }
                
            }
            
        }
        
    }
      
}
    
}

    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
        view.backgroundColor = UIColor.whiteColor()
        documentWebView.backgroundColor = UIColor.whiteColor()
        
        loadDocument()
        
        
    }
  
    override func viewDidAppear(animated: Bool) {
      
        var query = PFQuery(className:"_User")
        
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if let objects = objects {
                
            if let resultView = PFUser.currentUser()?["file"] as? PFFile {
                    
                //Thats NOT unwrapped ? Need to use !
                    resultView.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                        
                            if (error == nil) {
                            
                            let image = UIImage(data: data!)
                            
                            self.imageView.image = UIImage(data: data!)
                            
                            // self.resultarticleView.append(object.objectForKey("file") as! PFFile)
                            
                            //  println(data)
                            
                            
                        }
                    }
                }
            }
            
        })

       
    }
    var data: PFObject? {
        didSet{
            
        loadDocument()
        }
    }
    
 func loadDocument() {
        if data != nil {
            if let file: PFFile? = data!.objectForKey("file") as? PFFile {
                if let url = NSURL(string: file!.url!) {
                    let request = NSURLRequest(URL: url)
                    documentWebView?.loadRequest(request)

                }
           }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
*/



    
 


*/
