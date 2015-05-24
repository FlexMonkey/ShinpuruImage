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

    let mainGroup = SLHGroup()
    let leftGroup = SLVGroup()
    let rightGroup = SLVGroup()
    
    let original = UIImageView()
    let imageView = UIImageView()
    
    let foo = [String](count: 256, repeatedValue: "")
    var redChartData = [ChartDataEntry](count: 256, repeatedValue: ChartDataEntry())
    var greenChartData = [ChartDataEntry](count: 256, repeatedValue: ChartDataEntry())
    var blueChartData = [ChartDataEntry](count: 256, repeatedValue: ChartDataEntry())
    
    let redSlider = LabelledSlider(title: "Red")
    let greenSlider = LabelledSlider(title: "Green")
    let blueSlider = LabelledSlider(title: "Blue")

    let saturationSlider = LabelledSlider(title: "Saturation", minimumValue: 0, maximumValue: 2)
    let brightnessSlider = LabelledSlider(title: "Brightness", minimumValue: -1, maximumValue: 1)
    let contrastSlider = LabelledSlider(title: "Contrast", minimumValue: 0, maximumValue: 2)
    
    let chart = LineChartView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainGroup.margin = 20
        leftGroup.margin = 10
 
        original.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        view.addSubview(mainGroup)

        chart.backgroundColor = UIColor.lightGrayColor()

        redSlider.value = 1
        greenSlider.value = 1
        blueSlider.value = 1
        
        saturationSlider.value = 2
        brightnessSlider.value = 0
        contrastSlider.value = 1
        
        redSlider.addTarget(self, action: "updateImage", forControlEvents: UIControlEvents.ValueChanged)
        greenSlider.addTarget(self, action: "updateImage", forControlEvents: UIControlEvents.ValueChanged)
        blueSlider.addTarget(self, action: "updateImage", forControlEvents: UIControlEvents.ValueChanged)

        saturationSlider.addTarget(self, action: "updateImage", forControlEvents: UIControlEvents.ValueChanged)
        brightnessSlider.addTarget(self, action: "updateImage", forControlEvents: UIControlEvents.ValueChanged)
        contrastSlider.addTarget(self, action: "updateImage", forControlEvents: UIControlEvents.ValueChanged)
        
        rightGroup.children = [original, chart]
        leftGroup.children = [redSlider, greenSlider, blueSlider, saturationSlider, brightnessSlider, contrastSlider]
        mainGroup.children = [leftGroup, rightGroup]
        
        updateImage()
    }

    func updateImage()
    {
        let targetColor = UIColor(red: CGFloat(redSlider.value),
                                    green: CGFloat(greenSlider.value),
                                    blue: CGFloat(blueSlider.value),
                                    alpha: CGFloat(1.0))
        
        let image = UIImage(named: "vegas.jpg")?
                            .SIWhitePointAdjust(color: targetColor)
                            .SIColorControls(saturation: saturationSlider.value, brightness: brightnessSlider.value, contrast: contrastSlider.value)
        
        let histogram = image?.SIHistogramCalculation()
        
        original.image = image
        
        for i: Int in 0 ... 255
        {
            redChartData[i] = ( ChartDataEntry(value: Float(min(histogram!.red[i], 19000)), xIndex: i) )
            greenChartData[i] = ( ChartDataEntry(value: Float(min(histogram!.green[i], 19000)), xIndex: i) )
            blueChartData[i] = ( ChartDataEntry(value: Float(min(histogram!.blue[i], 19000)), xIndex: i) )
        }
        
        let redChartDataSet = LineChartDataSet(yVals: redChartData, label: "red")
        let greenChartDataSet = LineChartDataSet(yVals: greenChartData, label: "green")
        let blueChartDataSet = LineChartDataSet(yVals: blueChartData, label: "blue")
        
        redChartDataSet.setColor(UIColor.redColor())
        redChartDataSet.lineWidth = 2
        redChartDataSet.drawCirclesEnabled = false
        
        greenChartDataSet.setColor(UIColor.greenColor())
        greenChartDataSet.lineWidth = 2
        greenChartDataSet.drawCirclesEnabled = false
        
        blueChartDataSet.setColor(UIColor.blueColor())
        blueChartDataSet.lineWidth = 2
        blueChartDataSet.drawCirclesEnabled = false
        
        chart.data = LineChartData(xVals: foo, dataSets: [redChartDataSet, greenChartDataSet, blueChartDataSet])
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 5, dy: 10)
    }

}

