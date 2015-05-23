//
//  ShinpuruImage_CoreImage.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

// MARK: Photo Effects

extension UIImage
{
    func SIPhotoEffectNoir() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectNoir", keyValuePairs: [])
    }

    func SIPhotoEffectChrome() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectChrome", keyValuePairs: [])
    }

    func SIPhotoEffectFade() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectFade", keyValuePairs: [])
    }

    func SIPhotoEffectInstant() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectInstant", keyValuePairs: [])
    }

    func SIPhotoEffectMono() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectMono", keyValuePairs: [])
    }

    func SIPhotoEffectProcess() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectProcess", keyValuePairs: [])
    }

    func SIPhotoEffectTonal() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectTonal", keyValuePairs: [])
    }

    func SIPhotoEffectTransfer() -> UIImage
    {
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: "CIPhotoEffectTransfer", keyValuePairs: [])
    }
    
    // MARK: CICategoryColorEffect
    
    func SIFalseColor(#color0: UIColor, color1: UIColor) -> UIImage
    {
        let inputColor0 = KeyValuePair(key: "inputColor0", value: CIColor(color: color0)!)
        let inputColor1 = KeyValuePair(key: "inputColor1", value: CIColor(color: color1)!)
        
        let filterName = "CIFalseColor"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputColor0, inputColor1])
    }
    
    func SIPosterize(#levels: Int) -> UIImage
    {
        let inputLevels = KeyValuePair(key: "inputLevels", value: levels)
        
        let filterName = "CIColorPosterize"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputLevels])
    }
    
    func SIMonochrome(#color: UIColor, intensity: Float) -> UIImage
    {
        let inputColor = KeyValuePair(key: "inputColor", value: CIColor(color: color)!)
        let inputIntensity = KeyValuePair(key: "inputIntensity", value: intensity)
        
        let filterName = "CIColorMonochrome"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputColor, inputIntensity])
    }
    
    // MARK: CICategoryStylize
    
    func SIBloom(#radius: Float, intensity: Float) -> UIImage
    {
        let inputRadius = KeyValuePair(key: "inputRadius", value: radius)
        let inputIntensity = KeyValuePair(key: "inputIntensity", value: intensity)
        
        let filterName = "CIBloom"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputRadius, inputIntensity])
    }

    func SIGloom(#radius: Float, intensity: Float) -> UIImage
    {
        let inputRadius = KeyValuePair(key: "inputRadius", value: radius)
        let inputIntensity = KeyValuePair(key: "inputIntensity", value: intensity)
        
        let filterName = "CIGloom"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputRadius, inputIntensity])
    }
    
    func SIPixellate(#scale: Float) -> UIImage
    {
        let inputScale = KeyValuePair(key: "inputScale", value: scale)
        
        let filterName = "CIPixellate"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputScale])
    }
    
    // MARK: CICategoryBlur
    
    func SIGaussianBlur(#radius: Float) -> UIImage
    {
        let inputRadius = KeyValuePair(key: "inputRadius", value: radius)
        
        let filterName = "CIGaussianBlur"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputRadius])
    }
    
    // MARK: CICategoryColorAdjustment
    
    func SIColorControls(#saturation: Float, brightness: Float, contrast: Float) -> UIImage
    {
        let inputSaturation = KeyValuePair(key: "inputSaturation", value: saturation)
        let inputBrightness = KeyValuePair(key: "inputBrightness", value: brightness)
        let inputContrast = KeyValuePair(key: "inputContrast", value: contrast)
        
        let filterName = "CIColorControls"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputSaturation, inputBrightness, inputContrast])
    }
    
    func SIExposureAdjust(#ev: Float) -> UIImage
    {
        let inputEV = KeyValuePair(key: "inputEV", value: ev)
        
        let filterName = "CIExposureAdjust"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputEV])
    }

    func SIGammaAdjust(#power: Float) -> UIImage
    {
        let inputPower = KeyValuePair(key: "inputPower", value: power)
        
        let filterName = "CIGammaAdjust"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputPower])
    }

    func SIVibrance(#amount: Float) -> UIImage
    {
        let inputAmount = KeyValuePair(key: "inputAmount", value: amount)
        
        let filterName = "CIVibrance"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputAmount])
    }
    
    func SIWhitePointAdjust(#color: UIColor) -> UIImage
    {
        let inputColor = KeyValuePair(key: "inputColor", value: CIColor(color: color)!)
        
        let filterName = "CIWhitePointAdjust"
        
        return ShinpuruCoreImageHelper.applyFilter(self, filterName: filterName, keyValuePairs: [inputColor])
    }
}

// MARK: Utilities

class ShinpuruCoreImageHelper
{
    static let ciContext = CIContext(options: nil)
    
    static func applyFilter(image: UIImage, filterName: String, keyValuePairs: [KeyValuePair]) -> UIImage
    {
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
}

typealias KeyValuePair = (key:String, value: AnyObject)
