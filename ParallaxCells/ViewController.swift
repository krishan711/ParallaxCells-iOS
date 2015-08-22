//
//  ViewController.swift
//  ParallaxCells
//
//  Created by Krishan Patel on 22/08/2015.
//  Copyright (c) 2015 Rocko Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblMain: UITableView!

    var models: [CellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblMain.delegate = self
        self.tblMain.dataSource = self
        self.tblMain.rowHeight = 250

        self.models.append(CellModel(title: "Title 0", imageName: "image0"))
        self.models.append(CellModel(title: "Title 1", imageName: "image1"))
        self.models.append(CellModel(title: "Title 2", imageName: "image2"))
        self.models.append(CellModel(title: "Title 3", imageName: "image3"))
        self.models.append(CellModel(title: "Title 4", imageName: "image4"))
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.models.count * 100
        }
        return 0
    }
    func modelAtIndexPath(indexPath: NSIndexPath) -> CellModel {
        return self.models[indexPath.row % self.models.count]
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ImageCell") as! ImageCell
        cell.model = self.modelAtIndexPath(indexPath)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == self.tblMain) {
            for indexPath in self.tblMain.indexPathsForVisibleRows() as! [NSIndexPath] {
                self.setCellImageOffset(self.tblMain.cellForRowAtIndexPath(indexPath) as! ImageCell, indexPath: indexPath)
            }
        }
    }

    func setCellImageOffset(cell: ImageCell, indexPath: NSIndexPath) {
        var cellFrame = self.tblMain.rectForRowAtIndexPath(indexPath)
        var cellFrameInTable = self.tblMain.convertRect(cellFrame, toView:self.tblMain.superview)
        var cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
        var tableHeight = self.tblMain.bounds.size.height + cellFrameInTable.size.height
        var cellOffsetFactor = cellOffset / tableHeight
        cell.setBackgroundOffset(cellOffsetFactor)
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        var imageCell = cell as! ImageCell
        self.setCellImageOffset(imageCell, indexPath: indexPath)
    }

}

