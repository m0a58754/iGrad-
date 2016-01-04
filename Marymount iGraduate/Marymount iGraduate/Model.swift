//
//  Model.swift
//  Marymount iGraduate
//
//  Created by Mahmood on 11/20/15.
//  Copyright (c) 2015 Mahmood. All rights reserved.
//


import UIKit

class DocumentView {
    
    var name: String
    var description: String
    var thumbnail: UIImage?
    var fileData: NSData?
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
        
    }
    
}
