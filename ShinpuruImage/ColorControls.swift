//
//  ColorControls.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 23/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ColorControls: SLHGroup
{
    let slidersGroup = SLVGroup()
    
    let saturationSlider = LabelledSlider(title: "Saturation", minimumValue: 0, maximumValue: 2)
    let brightnessSlider = LabelledSlider(title: "Brightness", minimumValue: -1, maximumValue: 1)
    let contrastSlider = LabelledSlider(title: "Contrast", minimumValue: 0, maximumValue: 2)
    
    let imageView = UIImageView()
    
    let image = UIImage(named: "oculista.jpg")!
    
    required init()
    {
        super.init()
        
        margin = 5
        slidersGroup.margin = 5
        
        saturationSlider.value = 2
        brightnessSlider.value = 0
        contrastSlider.value = 1
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        saturationSlider.addTarget(self, action: "colorControlsChange", forControlEvents: UIControlEvents.ValueChanged)
        brightnessSlider.addTarget(self, action: "colorControlsChange", forControlEvents: UIControlEvents.ValueChanged)
        contrastSlider.addTarget(self, action: "colorControlsChange", forControlEvents: UIControlEvents.ValueChanged)
        
        slidersGroup.children = [saturationSlider, brightnessSlider, contrastSlider]
        
        children = [slidersGroup, imageView]
        
        colorControlsChange()
    }
    
    func colorControlsChange()
    {
        imageView.image = image.SIColorControls(saturation: 0.5, brightness: 0.76, contrast: 1.2)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
