//
//  ShinpuruImage_CoreImage.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit
import CoreImage

// MARK: Photo Effects

extension UIImage
{
    func SIPhotoEffectNoir() -> UIImage
    {
        let filterName = "CIPhotoEffectNoir"
        
        return applyFilter(self, filterName, [])
    }
    
    // CIPhotoEffectChrome
    // CIPhotoEffectFade
    // CIPhotoEffectInstant
    // CIPhotoEffectMono
    // CIPhotoEffectProcess
    // CIPhotoEffectTonal
    // CIPhotoEffectTransfer
    
    // MARK: CICategoryColorEffect
    
    // CIFalseColor
    // CIColorPosterize
    
    func SIMonochrome(#color: UIColor, intensity: Float) -> UIImage
    {
        let inputColor = KeyValuePair(key: "inputColor", value: CIColor(color: color)!)
        let inputIntensity = KeyValuePair(key: "inputIntensity", value: intensity)
        
        let filterName = "CIColorMonochrome"
        
        return applyFilter(self, filterName, [inputColor, inputIntensity])
    }
    
    // MARK: CICategoryStylize
    
    // CIBloom
    // CIGloom
    // CIPixellate
    
    // MARK: CICategoryBlur
    
    // CIGaussianBlur
    
    // MARK: CICategoryColorAdjustment
    
    // CIColorControls
    // CIExposureAdjust
    // CIGammaAdjust
    // CIVibrance
    // CIWhitePointAdjust
}

// MARK: Utilities
// func imageByApplyingFilter(filterName: String!, withInputParameters params: [NSObject : AnyObject]!) -> CIImage! ??

func applyFilter(image: UIImage, filterName: String, keyValuePairs: [KeyValuePair]) -> UIImage
{
    let ciContext = CIContext(options: nil)
    let ciFilter = CIFilter(name: filterName)
    
    let inputImage = KeyValuePair(key: kCIInputImageKey, value: CIImage(image: image))
    ciFilter.setValue(inputImage.value, forKey: inputImage.key)
    
    for keyValuePair in keyValuePairs
    {
        ciFilter.setValue(keyValuePair.value, forKey: keyValuePair.key)
    }
    
    var filteredImageData = ciFilter.valueForKey(kCIOutputImageKey) as! CIImage!
    var filteredImageRef: CGImage!
    
    filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
    
    var filteredImage = UIImage(CGImage: filteredImageRef)!
    
    filteredImageData = nil
    filteredImageRef = nil
    
    return filteredImage
}

typealias KeyValuePair = (key:String, value: AnyObject)
