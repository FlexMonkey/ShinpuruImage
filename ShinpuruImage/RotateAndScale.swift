//
//  RotateAndScale.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 23/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class RotateAndScale: SLHGroup
{
    let slidersGroup = SLVGroup()
    
    let scaleXslider = LabelledSlider(title: "Scale X", minimumValue: 0.001, maximumValue: 1)
    let scaleYslider = LabelledSlider(title: "Scale Y", minimumValue: 0.001, maximumValue: 1)
    let rotateslider = LabelledSlider(title: "Rotation", minimumValue: 0, maximumValue: Float(2 * M_PI))
    
    let imageView = UIImageView()
    
    let image = UIImage(named: "vegas.jpg")!
    
    required init()
    {
        super.init()
        
        margin = 5
        
        scaleXslider.value = 1
        scaleYslider.value = 1
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        scaleXslider.addTarget(self, action: "scaleRotateChange", forControlEvents: UIControlEvents.ValueChanged)
        scaleYslider.addTarget(self, action: "scaleRotateChange", forControlEvents: UIControlEvents.ValueChanged)
        rotateslider.addTarget(self, action: "scaleRotateChange", forControlEvents: UIControlEvents.ValueChanged)
        
        slidersGroup.children = [scaleXslider, scaleYslider, rotateslider]
        
        children = [slidersGroup, imageView]
        
        scaleRotateChange()
    }

    func scaleRotateChange()
    {
        imageView.image = image
                            .SIScale(scaleX: scaleXslider.value, scaleY: scaleYslider.value)
                            .SIRotate(angle: rotateslider.value, backgroundColor: UIColor.lightGrayColor())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
