//
//  LabelledSlider.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 23/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class LabelledSlider: UIControl
{
    let slider = UISlider(frame: CGRectZero)
    let label = UILabel(frame: CGRectZero)
    
    required init(title: String, minimumValue: Float = 0, maximumValue: Float = 1)
    {
        super.init(frame: CGRectZero)
        
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue
        
        self.title = title
        updateLabel()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String = ""
    {
        didSet
        {
            updateLabel()
        }
    }
    
    var value: Float = 0
    {
        didSet
        {
            slider.value = Float(value)
            updateLabel()
        }
    }
    
    override func didMoveToSuperview()
    {
        slider.addTarget(self, action: "sliderChangeHandler", forControlEvents: .ValueChanged)
        
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 1
        
        addSubview(slider)
        addSubview(label)
    }
    
    func sliderChangeHandler()
    {
        value = slider.value
        
        sendActionsForControlEvents(.ValueChanged)
    }
    
    func updateLabel()
    {
        label.text = title + ": " + (NSString(format: "%.3f", Float(value)) as String)
    }
    
    override func layoutSubviews()
    {
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2).rectByInsetting(dx: 5, dy: 5)
        slider.frame = CGRect(x: 0, y: frame.height / 2, width: frame.width, height: frame.height / 2).rectByInsetting(dx: 5, dy: 5)
    }
}
