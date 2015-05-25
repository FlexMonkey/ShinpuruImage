//
//  ViewController.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    let histogram = Histogram()
    
    override func viewDidLoad()
    {
        view.addSubview(histogram)
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        histogram.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 50, dy: 50)
    }

}

