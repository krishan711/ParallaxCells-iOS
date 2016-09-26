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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.models.count * 100
        }
        return 0
    }
    func modelAtIndexPath(_ indexPath: IndexPath) -> CellModel {
        return self.models[(indexPath as NSIndexPath).row % self.models.count]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
        cell.model = self.modelAtIndexPath(indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == self.tblMain) {
            for indexPath in self.tblMain.indexPathsForVisibleRows! {
                self.setCellImageOffset(self.tblMain.cellForRow(at: indexPath) as! ImageCell, indexPath: indexPath)
            }
        }
    }

    func setCellImageOffset(_ cell: ImageCell, indexPath: IndexPath) {
        let cellFrame = self.tblMain.rectForRow(at: indexPath)
        let cellFrameInTable = self.tblMain.convert(cellFrame, to:self.tblMain.superview)
        let cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
        let tableHeight = self.tblMain.bounds.size.height + cellFrameInTable.size.height
        let cellOffsetFactor = cellOffset / tableHeight
        cell.setBackgroundOffset(cellOffsetFactor)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let imageCell = cell as! ImageCell
        self.setCellImageOffset(imageCell, indexPath: indexPath)
    }

}

