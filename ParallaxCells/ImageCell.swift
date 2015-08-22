//
//  ImageCell.swift
//  ParallaxCells
//
//  Created by Krishan Patel on 22/08/2015.
//  Copyright (c) 2015 Rocko Labs. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgBackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBackBottomConstraint: NSLayoutConstraint!

    let imageParallaxFactor: CGFloat = 20

    var initialised = false
    var imgBackTopInitial: CGFloat!
    var imgBackBottomInitial: CGFloat!

    var model: CellModel! {
        didSet {
            self.updateView()
        }
    }

    func updateView() {
        self.initialiseIfNeeded()
        self.imgBack.image = UIImage(named:self.model.imageName)
        self.lblTitle.text = self.model.title
    }

    func initialiseIfNeeded() {
        if (!self.initialised && self.imgBack != nil) {
            self.clipsToBounds = true
            self.imgBackBottomConstraint.constant -= 2 * imageParallaxFactor
            self.imgBackTopInitial = self.imgBackTopConstraint.constant
            self.imgBackBottomInitial = self.imgBackBottomConstraint.constant
            self.initialised = true
        }
    }

    func setBackgroundOffset(offset:CGFloat) {
        var boundOffset = max(0, min(1, offset))
        var pixelOffset = (1-boundOffset)*2*imageParallaxFactor
        self.imgBackTopConstraint.constant = self.imgBackTopInitial - pixelOffset
        self.imgBackBottomConstraint.constant = self.imgBackBottomInitial + pixelOffset
    }

}
