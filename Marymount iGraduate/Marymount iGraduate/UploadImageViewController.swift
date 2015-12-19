//
//  UploadImageViewController.swift
//  Marymount iGraduate
//
//  Created by Mahmood on 10/2/15.
//  Copyright (c) 2015 Mahmood. All rights reserved.
//.
//

import UIKit
import Parse
import MobileCoreServices

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate {
  
  @IBOutlet weak var imageToUpload: UIImageView!
  @IBOutlet weak var commentTextField: UITextField!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
  
  var username: String?
    var newMedia: Bool?
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Actions
   

    @IBAction func selectedCameraPressed(sender: AnyObject) {
      
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage]
            imagePicker.editing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            newMedia = true 
        }
        
        
    }
    
  @IBAction func selectPicturePressed(sender: AnyObject) {
    //Open a UIImagePickerController to select the picture
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    presentViewController(imagePicker, animated: true, completion: nil)
  }
  

 
  @IBAction func sendPressed(sender: AnyObject) {
    commentTextField.resignFirstResponder()
    
    //Disable the send button until we are ready
    navigationItem.rightBarButtonItem?.enabled = false
    
    loadingSpinner.startAnimating()
    
    //TODO: Upload a new picture
    let pictureData = UIImagePNGRepresentation(imageToUpload.image)
    
    //1
    let file = PFFile(name: "image", data: pictureData)
    file.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
      if succeeded {
        //2
        self.saveWallPost(file)
      } else if let error = error {
        //3
        self.showErrorView(error)
      }
      }, progressBlock: { percent in
        //4
        println("Uploaded: \(percent)%")
    })
  }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        var orginalImage:UIImage?, editedImage:UIImage?, imageToSave: UIImage
        let compResult:CFComparisonResult = CFStringCompare(mediaType as NSString!, kUTTypeImage, CFStringCompareFlags.CompareCaseInsensitive)
        if ( compResult == CFComparisonResult.CompareEqualTo ) {
            
            editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
            orginalImage = info[UIImagePickerControllerOriginalImage]as! UIImage?
            
            if ( editedImage != nil ) {
                imageToSave = editedImage!
            } else {
                imageToSave = orginalImage!
            }
            imageToUpload.image = imageToSave
            imageToUpload.reloadInputViews()
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
       
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    
  func saveWallPost(file: PFFile)
  {
    //1
    let wallPost = WallPost(image: file, user: PFUser.currentUser()!, comment: self.commentTextField.text)
    //2
    wallPost.saveInBackgroundWithBlock{ succeeded, error in
      if succeeded {
        //3
        self.navigationController?.popViewControllerAnimated(true)
      } else {
        //4
        if let errorMessage = error?.userInfo?["error"] as? String {
          self.showErrorView(error!)
        }
      }
    }
  }
  
}

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    //Place the image in the imageview
    imageToUpload.image = image
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}
