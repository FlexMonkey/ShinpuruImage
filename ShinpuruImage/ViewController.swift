//
//  ViewController.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let mainGroup = SLVGroup()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        mainGroup.margin = 20
        
        mainGroup.children = [RotateAndScale(), ColorControls()]
        
        view.addSubview(mainGroup)
    }

    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 5, dy: 0)
    }

}

