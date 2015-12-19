//
//  WallPostTableViewCell.swift
//  Marymount iGraduate
//
//  Created by Mahmood on 10/2/15.
//  Copyright (c) 2015 Mahmood. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class WallPostTableViewCell: PFTableViewCell {
  @IBOutlet weak var postImage: PFImageView!
  @IBOutlet weak var createdByLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
}
