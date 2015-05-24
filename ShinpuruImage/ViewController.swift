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
    
    let original = UIImageView()
    let imageView = UIImageView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainGroup.margin = 20
        
        // mainGroup.children = [RotateAndScale(), ColorControls()]
        
        
        
        original.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        view.addSubview(mainGroup)
        
        original.image = UIImage(named: "oculista.jpg")
        
        let historgram = UIImage(named: "oculista.jpg")?.SIHistogramCalculation()
        
        let chart = LineChartView()

        chart.backgroundColor = UIColor.lightGrayColor()

        var redChartData = [ChartDataEntry]()
        var greenChartData = [ChartDataEntry]()
        var blueChartData = [ChartDataEntry]()
        
        for (i: Int, value: UInt) in enumerate(historgram!.alpha)
        {
            redChartData.append( ChartDataEntry(value: Float(min(value, 19000)), xIndex: i) )
        }
        for (i: Int, value: UInt) in enumerate(historgram!.red)
        {
            greenChartData.append( ChartDataEntry(value: Float(min(value, 19000)), xIndex: i) )
        }
        for (i: Int, value: UInt) in enumerate(historgram!.green)
        {
            blueChartData.append( ChartDataEntry(value: Float(min(value, 19000)), xIndex: i) )
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
        
        let foo = [String](count: 256, repeatedValue: "")
        chart.data = LineChartData(xVals: foo, dataSets: [redChartDataSet, greenChartDataSet, blueChartDataSet])
 
        mainGroup.children = [original, chart]
    }

    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 5, dy: 10)
    }

}

