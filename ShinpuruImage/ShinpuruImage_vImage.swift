//
//  ShinpuruImage.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//
//  Thanks to https://github.com/j4nnis/AImageFilters

import UIKit
import Accelerate

extension UIImage
{
    // MARK: Morphology functions
    
    func SIDilateFilter(#kernel: [UInt8]) -> UIImage
    {
        precondition(kernel.count == 9 || kernel.count == 25 || kernel.count == 49, "Kernel size must be 3x3, 5x5 or 7x7.")
        let kernelSide = UInt32(sqrt(Float(kernel.count)))
        
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageDilate_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, 0, 0, kernel, UInt(kernelSide), UInt(kernelSide), UInt32(kvImageNoFlags))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    func SIErodeFilter(#kernel: [UInt8]) -> UIImage
    {
        precondition(kernel.count == 9 || kernel.count == 25 || kernel.count == 49, "Kernel size must be 3x3, 5x5 or 7x7.")
        let kernelSide = UInt32(sqrt(Float(kernel.count)))
        
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageErode_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, 0, 0, kernel, UInt(kernelSide), UInt(kernelSide), UInt32(kvImageNoFlags))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    // MARK: High Level Geometry Functions
    
    func SIScale(#scaleX: Float, scaleY: Float) -> UIImage
    {
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(min(scaleY, 1) * Float(CGImageGetHeight(imageRef))), width: UInt(min(scaleX, 1) * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageScale_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, UInt32(kvImageBackgroundColorFill))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    func SIRotate(#angle: Float, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage
    {
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var backgroundColor : Array<UInt8> = backgroundColor.getRGB()
        
        var error = vImageRotate_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, angle,  &backgroundColor, UInt32(kvImageBackgroundColorFill))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    func SIRotateNinety(rotation: RotateNinety, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage
    {
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var backgroundColor : Array<UInt8> = backgroundColor.getRGB()
        
        var error = vImageRotate90_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, rotation.rawValue,  &backgroundColor, UInt32(kvImageBackgroundColorFill))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    func SIHorizontalReflect() -> UIImage
    {
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageHorizontalReflect_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, UInt32(kvImageNoFlags))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    func SIVerticalReflect() -> UIImage
    {
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageVerticalReflect_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, UInt32(kvImageNoFlags))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    // MARK: Convolution
    
    func SIBoxBlur(#width: Int, height: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage
    {
        let oddWidth = UInt32(width % 2 == 0 ? width + 1 : width)
        let oddHeight = UInt32(height % 2 == 0 ? height + 1 : height)
        
        var backgroundColor : Array<UInt8> = backgroundColor.getRGB()
        
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageBoxConvolve_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, 0, 0, oddHeight, oddWidth, &backgroundColor, UInt32(kvImageBackgroundColorFill))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }

    func SIFastBlur(#width: Int, height: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage
    {
        let oddWidth = UInt32(width % 2 == 0 ? width + 1 : width)
        let oddHeight = UInt32(height % 2 == 0 ? height + 1 : height)
        
        var backgroundColor : Array<UInt8> = backgroundColor.getRGB()
        
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageTentConvolve_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, 0, 0, oddHeight, oddWidth, &backgroundColor, UInt32(kvImageBackgroundColorFill))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    func SIConvolutionFilter(#kernel: [Int16], divisor: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage
    {
        precondition(kernel.count == 9 || kernel.count == 25 || kernel.count == 49, "Kernel size must be 3x3, 5x5 or 7x7.")
        let kernelSide = UInt32(sqrt(Float(kernel.count)))
        
        var backgroundColor : Array<UInt8> = backgroundColor.getRGB()
        
        let imageRef = self.CGImage
        
        let inProvider = CGImageGetDataProvider(imageRef)
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer(CFDataGetBytePtr(inBitmapData)), height: UInt(CGImageGetHeight(imageRef)), width: UInt(CGImageGetWidth(imageRef)), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef))
        
        var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(1 * Float(CGImageGetHeight(imageRef))), width: UInt(1 * Float(CGImageGetWidth(imageRef))), rowBytes: CGImageGetBytesPerRow(imageRef))
        
        var imageBuffers = SIImageBuffers(inBuffer: inBuffer, outBuffer: outBuffer, pixelBuffer: pixelBuffer)
        
        var error = vImageConvolve_ARGB8888(&imageBuffers.inBuffer, &imageBuffers.outBuffer, nil, 0, 0, kernel, kernelSide, kernelSide, Int32(divisor), &backgroundColor, UInt32(kvImageBackgroundColorFill))
        
        let outImage = UIImage(fromvImageOutBuffer: imageBuffers.outBuffer, scale: self.scale, orientation: .Up)
        
        free(imageBuffers.pixelBuffer)
        
        return outImage!
    }
    
    convenience init?(fromvImageOutBuffer outBuffer:vImage_Buffer, scale:CGFloat, orientation: UIImageOrientation)
    {
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var context = CGBitmapContextCreate(outBuffer.data, Int(outBuffer.width), Int(outBuffer.height), 8, outBuffer.rowBytes, colorSpace, CGBitmapInfo(CGImageAlphaInfo.NoneSkipLast.rawValue))
        
        var outCGimage = CGBitmapContextCreateImage(context)
        
        self.init(CGImage: outCGimage, scale:scale, orientation:orientation)
    }
    

}


// MARK: Utilities

typealias SIImageBuffers = (inBuffer: vImage_Buffer, outBuffer: vImage_Buffer, pixelBuffer: UnsafeMutablePointer<Void>)

struct SIConvolutionKernels
{
    // Sample kernels for use with SIConvolutionFilter. Use a divisor of 1
    
    static let edgeDetectionOne:[Int16]  = [-1,-1,-1, -1,8,-1, -1,-1,-1]
    static let edgeDetectionTwo:[Int16]  = [0,1,0, 1,-4,1, 0,1,0]
    static let edgeDetectionThree:[Int16]  = [-1,-1,-1, -1,8,-1, -1,-1,-1]
    static let sharpen:[Int16] = [0,-1,0, -1,5,-1, 0,-1,0]
}

enum RotateNinety: UInt8
{
    case Zero = 0
    case Ninety = 1
    case OneEighty = 2
    case TwoSeventy = 3
}

extension UIColor
{
    func getRGB() -> [UInt8]
    {
        func zeroIfDodgy(value: Float) ->Float
        {
            return isnan(value) || isinf(value) ? 0 : value
        }
        
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
}

