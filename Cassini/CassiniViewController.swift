//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Andriy Krupych on 4/26/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    
    let images = [
        "Cassini" : "https://saturn.jpl.nasa.gov/system/resources/detail_files/7657_Cassini-GF-BTN.png",
        "Earth" : "https://www.nasa.gov/sites/default/files/thumbnails/image/187_1003705_americas_dxm.png",
        "Saturn" : "https://saturn.jpl.nasa.gov/system/resources/detail_files/7504_PIA21046_MAIN.jpg"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if primaryViewController.contents == self, let imageVC = secondaryViewController.contents as? ImageViewController, imageVC.image == nil {
            return true
        }
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let image = images[(sender as! UIButton).currentTitle!]
        let navigationVC = segue.destination as! UINavigationController
        let imageVC = navigationVC.visibleViewController as! ImageViewController
        imageVC.image = image!
    }

}

extension UIViewController {
    var contents: UIViewController {
        if let navVC = self as? UINavigationController {
            return navVC.visibleViewController ?? self
        } else {
            return self
        }
    }
}
