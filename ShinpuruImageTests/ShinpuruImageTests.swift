//
//  ShinpuruImageTests.swift
//  ShinpuruImageTests
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit
import XCTest

class ShinpuruImageTests: XCTestCase
{
    var image: UIImage!

    override func setUp()
    {
        super.setUp()
        
        image = UIImage(named: "oculista.jpg")!
    }
    
    func testUIImageChaining()
    {
        super.setUp()
        
        self.measureBlock()
        {
                println("testUIImageChaining")
            
                let chained = self.image.SIWhitePointAdjust(color: UIColor.blueColor())
                    .SIGaussianBlur(radius: 5)
                    .SIPixellate(scale: 5)
                    .SIBloom(radius: 1, intensity: 5)
                    .SIColorControls(saturation: 5, brightness: 1, contrast: 2)
        }
    }
    
    func testCIImageChaining()
    {
        super.setUp()
        
        self.measureBlock()
            {
                
                
                let chained = SIChainableImage(image: self.image).SIWhitePointAdjust(color: UIColor.blueColor())
                    .SIGaussianBlur(radius: 5)
                    .SIPixellate(scale: 5)
                    .SIBloom(radius: 1, intensity: 5)
                    .SIColorControls(saturation: 5, brightness: 1, contrast: 2)
                    .toUIImage()
        }
    }
    
    /*
    // 0.311 sec on iPad Air 2
    // 0.348 sec on iPhone 6
    func testPerformanceSIFastBlur()
    {
        self.measureBlock()
        {
            for i in 0 ... 10
            {
                let blurred = self.image.SIFastBlur(width: i * 5, height: i * 5)
            }
        }
    }
    
    // 0.330 sec on iPad Air 2
    // 0.417 sec on iPhone 6
    func testPerformanceSIGaussianBlur()
    {
        self.measureBlock()
        {
            for i in 0 ... 10
            {
                let blurred = self.image.SIGaussianBlur(radius: Float(i) * 2.5)
            }
        }
    }
    
    // 0.271 sec on iPad Air 2
    // 0.294 on iPhone 6
    func testPerformanceSIBoxBlur()
    {
        self.measureBlock()
        {
            for i in 0 ... 10
            {
                let blurred = self.image.SIBoxBlur(width: i * 5, height: i * 5)
            }
        }
    }
    */
}
