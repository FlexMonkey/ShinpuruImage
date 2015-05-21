//
//  ShinpuruImage_CoreImage.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

// MARK: Photo Effects

func SIPhotoEffectNoir(image: UIImage) -> UIImage
{
    let inputImage = KeyValuePair(key: kCIInputImageKey, value: CIImage(image: image))
    
    let filterName = "CIPhotoEffectNoir"
    
    return applyFilter(filterName, [inputImage])
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

func SIMonochrome(image: UIImage, #color: UIColor, #intensity: Float) -> UIImage
{
    let inputImage = KeyValuePair(key: kCIInputImageKey, value: CIImage(image: image))
    let inputColor = KeyValuePair(key: "inputColor", value: CIColor(color: color)!)
    let inputIntensity = KeyValuePair(key: "inputIntensity", value: intensity)
    
    let filterName = "CIColorMonochrome"
    
    return applyFilter(filterName, [inputImage, inputColor, inputIntensity])
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

// MARK: Utilities

func applyFilter(filterName: String, keyValuePairs: [KeyValuePair]) -> UIImage
{
    let ciContext = CIContext(options: nil)
    
    let ciFilter = CIFilter(name: filterName)
    
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
