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
    let simpleDemo = SimpleDemo()
    
    let mainGroup = SLVGroup()
    
    let segmentedControl = SLSegmentedControl(items: ["Simple Demo", "Histogram / Fast Chaining Demo"])
    
    override func viewDidLoad()
    {
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.explicitSize = 60
        segmentedControl.addTarget(self, action: "selectionChange", forControlEvents: UIControlEvents.ValueChanged)
        
        mainGroup.margin = 20
        mainGroup.children = [segmentedControl, histogram]
        
        view.addSubview(mainGroup)
    }
    
    func selectionChange()
    {
        mainGroup.removeChild(atIndex: 1)
        
        let newChild = segmentedControl.selectedSegmentIndex == 0 ? simpleDemo : histogram
        
        mainGroup.addChild(newChild, atIndex: 1)
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).insetBy(dx: 20, dy: 20)
    }

}


class SimpleDemo: SLVGroup
{
    required init()
    {
        super.init()
        
        children = [RotateAndScale(), ColorControls()]
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
