//
//  ShinpuruImage.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
// Thanks to https://github.com/j4nnis/AImageFilters

import UIKit
import Accelerate


/*
*		Reflect -- reflect an image across a  mirror plane at the center of the image in the x or y direction
*		Shear --  shear and rescale an image in the x or y direction
*		Rotate90 -- rotate an image by 0, 90, 180 or 270 degrees
*/

func SIDilateFilter(image: UIImage, #kernel: [UInt8]) -> UIImage
{
    precondition(kernel.count == 9 || kernel.count == 25 || kernel.count == 49, "Kernel size must be 3x3, 5x5 or 7x7.")
    let kernelSide = UInt32(sqrt(Float(kernel.count)))
    
    var imageBuffers = createBuffers(image)
    
    var error = vImageDilate_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, 0, 0, kernel, UInt(kernelSide), UInt(kernelSide), UInt32(kvImageBackgroundColorFill))
    
    let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: image.scale, orientation: .Up)
    
    free(imageBuffers.pixelBuffer)
    
    return outImage!
}

func SIErodeFilter(image: UIImage, #kernel: [UInt8]) -> UIImage
{
    precondition(kernel.count == 9 || kernel.count == 25 || kernel.count == 49, "Kernel size must be 3x3, 5x5 or 7x7.")
    let kernelSide = UInt32(sqrt(Float(kernel.count)))
    
    var imageBuffers = createBuffers(image)
    
    var error = vImageErode_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, 0, 0, kernel, UInt(kernelSide), UInt(kernelSide), UInt32(kvImageBackgroundColorFill))
    
    let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: image.scale, orientation: .Up)
    
    free(imageBuffers.pixelBuffer)
    
    return outImage!
}

func SIScale(image: UIImage, #scaleX: Float, #scaleY: Float) -> UIImage
{
    var imageBuffers = createBuffers(image, outputScaleX: min(scaleX, 1), outputScaleY: min(scaleY, 1))
    
    var error = vImageScale_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, UInt32(kvImageBackgroundColorFill))
    
    let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: image.scale, orientation: .Up)
    
    free(imageBuffers.pixelBuffer)
    
    return outImage!
}

func SIRotate(image: UIImage, #angle: Float, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage
{
    var imageBuffers = createBuffers(image)
    
    var backgroundColor : Array<UInt8> = backgroundColor.getRGB()
    
    var error = vImageRotate_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, angle,  &backgroundColor, UInt32(kvImageBackgroundColorFill))
    
    let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: image.scale, orientation: .Up)
    
    free(imageBuffers.pixelBuffer)
    
    return outImage!
}

func SIConvolutionFilter(image: UIImage, #kernel: [Int16], #divisor: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage
{
    precondition(kernel.count == 9 || kernel.count == 25 || kernel.count == 49, "Kernel size must be 3x3, 5x5 or 7x7.")
    let kernelSide = UInt32(sqrt(Float(kernel.count)))
    
    var backgroundColor : Array<UInt8> = backgroundColor.getRGB()
    
    var imageBuffers = createBuffers(image)
    
    var error = vImageConvolve_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, 0, 0, kernel, kernelSide, kernelSide, Int32(divisor), &backgroundColor, UInt32(kvImageBackgroundColorFill))
    
    let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: image.scale, orientation: .Up)
    
    free(imageBuffers.pixelBuffer)
    
    return outImage!
}

typealias SIImageBuffers = (inBuffer: vImage_Buffer, outBuffer: vImage_Buffer, pixelBuffer: UnsafeMutablePointer<Void>)

private func createBuffers(image: UIImage, outputScaleX: Float = 1, outputScaleY: Float = 1) -> SIImageBuffers
{
    let imageRef = image.CGImage
    
    let inProvider = CGImageGetDataProvider(imageRef)
    let inBitmapData = CGDataProviderCopyData(inProvider)
    
    var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
    
    var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
    
    var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(outputScaleY * Float(CGImageGetHeight(imageRef))), width: UInt(outputScaleX * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
    
    return (inBuffer, outBuffer, pixelBuffer)
}

extension UIImage
{
    convenience init?(fromvImageOutBuffer outBuffer:vImage_Buffer, scale:CGFloat, orientation: UIImageOrientation)
    {
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var context = CGBitmapContextCreate(outBuffer.data, Int(outBuffer.width), Int(outBuffer.height), 8, outBuffer.rowBytes, colorSpace, CGBitmapInfo(CGImageAlphaInfo.NoneSkipLast.rawValue))
        
        var outCGimage = CGBitmapContextCreateImage(context)
        
        self.init(CGImage: outCGimage, scale:scale, orientation:orientation)
    }
}

extension UIColor
{
    func getRGB() -> [UInt8]
    {
        if CGColorGetNumberOfComponents(self.CGColor) == 4
        {
            let colorRef = CGColorGetComponents(self.CGColor);
            
            let redComponent = UInt8(255 * zeroIfDodgy(Float(colorRef[0])))
            let greenComponent = UInt8(255 * zeroIfDodgy(Float(colorRef[1])))
            let blueComponent = UInt8(255 * zeroIfDodgy(Float(colorRef[2])))
            let alphaComponent = UInt8(255 * zeroIfDodgy(Float(colorRef[3])))
            
            return [redComponent, greenComponent, blueComponent, alphaComponent]
        }
        else if CGColorGetNumberOfComponents(self.CGColor) == 2
        {
            let colorRef = CGColorGetComponents(self.CGColor);
            
            let greyComponent = UInt8(255 * zeroIfDodgy(Float(colorRef[0])))
            let alphaComponent = UInt8(255 * zeroIfDodgy(Float(colorRef[1])))
            
            return [greyComponent, greyComponent, greyComponent, alphaComponent]
        }
        else
        {
            return [0,0,0,0]
        }
    }
    
    func zeroIfDodgy(value: Float) ->Float
    {
        return isnan(value) || isinf(value) ? 0 : value
    }
}

