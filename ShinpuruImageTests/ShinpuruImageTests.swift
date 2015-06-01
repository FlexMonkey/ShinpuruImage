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
    var imageView: UIImageView!

    override func setUp()
    {
        super.setUp()
        
        image = UIImage(named: "oculista.jpg")!
        imageView = UIImageView()
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        image = nil
        imageView = nil
    }
    
    func testUIImageChaining()
    {
        self.measureBlock()
        {
            let chained = self.image
                .SIPhotoEffectFade()
                .SIGaussianBlur(radius: 5)
                .SIPhotoEffectInstant()
                .SIPhotoEffectNoir()
                .SIGaussianBlur(radius: 5)
                .SIPhotoEffectProcess()
                .SIPhotoEffectTonal()
                .SIPhotoEffectProcess()
                .SIPhotoEffectTonal()
                .SIGaussianBlur(radius: 6)
                .SIBloom(radius: 20, intensity: 20)
                .SIColorControls(saturation: 0.5, brightness: 1, contrast: 2)
                .SIWhitePointAdjust(color: UIColor.yellowColor())
                .SIFalseColor(color0: UIColor.blueColor(), color1: UIColor.redColor())
                .SIPixellate(scale: 5)
            
            self.imageView.image = chained
        }
    }
    
    func testCIImageChaining()
    {
        self.measureBlock()
        {
            let chained = SIChainableImage(image: self.image)
                .SIPhotoEffectFade()
                .SIGaussianBlur(radius: 5)
                .SIPhotoEffectInstant()
                .SIPhotoEffectNoir()
                .SIGaussianBlur(radius: 5)
                .SIPhotoEffectProcess()
                .SIPhotoEffectTonal()
                .SIPhotoEffectProcess()
                .SIPhotoEffectTonal()
                .SIGaussianBlur(radius: 6)
                .SIBloom(radius: 20, intensity: 20)
                .SIColorControls(saturation: 0.5, brightness: 1, contrast: 2)
                .SIWhitePointAdjust(color: UIColor.yellowColor())
                .SIFalseColor(color0: UIColor.blueColor(), color1: UIColor.redColor())
                .SIPixellate(scale: 5)
                .toUIImage()
            
            self.imageView.image = chained
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
