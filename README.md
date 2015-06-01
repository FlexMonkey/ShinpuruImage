# ShinpuruImage

## Syntactic Sugar for Accelerate/vImage and Core Image Filters

![Screenshot](/ShinpuruImage/shinpuruImageScreenShot.PNG)

*ShinpuruImage* offers developers a consistent and strongly typed interface to Apple's Core Image and vImage/Accelerate image filters without the need for boilerplate code.

*ShinpuruImage* filters are implemented as extensions to `UIImage` and can be chained together with a super easy syntax:

```
        let image = UIImage(named: "vegas.jpg")!
            .SIFastBlur(width: 10, height: 10, backgroundColor: UIColor.redColor())
            .SIMonochrome(color: UIColor.yellowColor(), intensity: 1)
            .SIRotate(angle: 0.3, backgroundColor: UIColor.purpleColor())
```

## Installation

*ShinpuruImage* consists of two Swift files and to use *ShinpuruImage* in your own project, you simply need to copy:

* [ShinpuruImage_vImage.swift](https://github.com/FlexMonkey/ShinpuruImage/blob/master/ShinpuruImage/ShinpuruImage_vImage.swift)
* [ShinpuruImage_CoreImage.swift](https://github.com/FlexMonkey/ShinpuruImage/blob/master/ShinpuruImage/ShinpuruImage_CoreImage.swift)

## Filters

### Photo Effects

* `func SIPhotoEffectNoir() -> UIImage` Applies a preconfigured set of effects that imitate black-and-white photography film with exaggerated contrast.
* `func SIPhotoEffectChrome() -> UIImage` Applies a preconfigured set of effects that imitate vintage photography film with exaggerated color.
* `func SIPhotoEffectFade() -> UIImage` Applies a preconfigured set of effects that imitate vintage photography film with diminished color.
* `func SIPhotoEffectInstant() -> UIImage` Applies a preconfigured set of effects that imitate vintage photography film with distorted colors.
* `func SIPhotoEffectMono() -> UIImage` Applies a preconfigured set of effects that imitate black-and-white photography film with low contrast.
* `func SIPhotoEffectProcess() -> UIImage` Applies a preconfigured set of effects that imitate vintage photography film with emphasized cool colors.
* `func SIPhotoEffectTonal() -> UIImage` Applies a preconfigured set of effects that imitate black-and-white photography film without significantly altering contrast.
* `func SIPhotoEffectTransfer() -> UIImage` Applies a preconfigured set of effects that imitate vintage photography film with emphasized warm colors.

### Color Effects

* `func SIFalseColor(#color0: UIColor, color1: UIColor) -> UIImage` Maps luminance to a color ramp of two colors.
* `func SIPosterize(#levels: Int) -> UIImage` Remaps red, green, and blue color components to the number of brightness values you specify for each color component.
* `func SIMonochrome(#color: UIColor, intensity: Float) -> UIImage` Remaps colors so they fall within shades of a single color.

### Stylize

* `func SIBloom(#radius: Float, intensity: Float) -> UIImage` Softens edges and applies a pleasant glow to an image.
* `func SIGloom(#radius: Float, intensity: Float) -> UIImage` Dulls the highlights of an image.
* `func SIPixellate(#scale: Float) -> UIImage` Makes an image blocky by mapping the image to colored squares whose color is defined by the replaced pixels.

### Blur

* `func SIGaussianBlur(#radius: Float) -> UIImage` Spreads source pixels by an amount specified by a Gaussian distribution.

### Color Adjustment

* `func SIColorControls(#saturation: Float, brightness: Float, contrast: Float) -> UIImage` Adjusts saturation, brightness, and contrast values.
* `func SIExposureAdjust(#ev: Float) -> UIImage` Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop.
* `func SIGammaAdjust(#power: Float) -> UIImage` Adjusts midtone brightness.
* `func SIVibrance(#amount: Float) -> UIImage` Adjusts the saturation of an image while keeping pleasing skin tones.
* `func SIWhitePointAdjust(#color: UIColor) -> UIImage` Adjusts the reference white point for an image and maps all colors in the source using the new reference.

### Morphology functions

* `func SIDilateFilter(#kernel: [UInt8]) -> UIImage` [Dilates an object](https://developer.apple.com/library/mac/documentation/Performance/Reference/vImage_morphological/#//apple_ref/doc/uid/TP40005492-CH210-DontLinkElementID_1)
* `func SIErodeFilter(#kernel: [UInt8]) -> UIImage` [Erodes an object](https://developer.apple.com/library/mac/documentation/Performance/Reference/vImage_morphological/#//apple_ref/doc/uid/TP40005492-CH210-DontLinkElementID_2)
* `func SIMaxFilter(#width: Int, height: Int) -> UIImage` The morphological operation Max is a special case of the dilation operation whereby all the elements of the kernel have the same value. 
*  `func SIMinFilter(#width: Int, height: Int) -> UIImage` The morphological operation Min is a special case of the erosion operation whereby all the elements of the kernel have the same value.

### High Level Geometry Functions

* `func SIScale(#scaleX: Float, scaleY: Float) -> UIImage` Resize the input image
* `func SIRotate(#angle: Float, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage` Rotate the input image around a center point by any amount
* `func SIRotateNinety(rotation: RotateNinety, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage` Rotate an image by 0, 90, 180 or 270 degrees
* `func SIHorizontalReflect() -> UIImage` Reflect an image across a  mirror plane at the center of the image 
* `func SIVerticalReflect() -> UIImage` Reflect an image across a  mirror plane at the center of the image 

### Convolution

* `func SIBoxBlur(#width: Int, height: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage` Apply a mean filter to the image.
* `func SIFastBlur(#width: Int, height: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage` Apply a tent filter to the image.
* `func SIConvolutionFilter(#kernel: [Int16], divisor: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage` All four channel convolution function

### Histogram

<img src="/ShinpuruImage/assets/HistogramScreenShot.jpg" align="center" width="300" >

* `func SIHistogramCalculation() -> (alpha: [UInt], red: [UInt], green: [UInt], blue: [UInt])` Returns a tuple containing four arrays of 256 `UInt` representing the histogram of the supplied image

## Demo Application

The demo app contains three components:

* *[RotateAndScale](https://github.com/FlexMonkey/ShinpuruImage/blob/master/ShinpuruImage/RotateAndScale.swift)* - demonstrates chained `SIScale()` and `SIRotate()` controlled by three numeric sliders
* *[ColorControls](https://github.com/FlexMonkey/ShinpuruImage/blob/master/ShinpuruImage/ColorControls.swift)* - demonstrates `SIColorControls` controlled by three numeric sliders
* *[Histogram](https://github.com/FlexMonkey/ShinpuruImage/blob/master/ShinpuruImage/Histogram.swift)* - uses [ios-charts](https://github.com/danielgindi/ios-charts) to demonstrate the use of `SIHistogramCalculation` and the performance benefits of using fast filter chaining. 

## Filter Chaining 

For the best perfomance when chaining image filters together, *Shinpuru Image* includes a `SIFastChainableImage` type that prevents the chain from converting to `UIImage` between individual chained filters. The syntax is slightly different and requires the source `UIImage` to be cast to a `SIFastChainableImage` and the final output to be converted back to a `UIImage`:

```
            let chained = SIFastChainableImage, ,(image: self.image)
                .SIPhotoEffectFade()
                .SIGaussianBlur(radius: 5)
                .SIFalseColor(color0: UIColor.blueColor(), color1: UIColor.redColor())
                .SIPixellate(scale: 5)
                .toUIImage()
```

For complex chains of filters, using `SIFastChainableImage` can be four or fives times faster. However, in this mode, color management is turned off.

## Blurring Images

To blur an image you have three options: a true Gaussian blur (`SIGaussianBlur`), a box blur (`SIBoxBlur`) and *ShinpuruImage* fast blur (`SIFastBlur`) which is based on `vImageTentConvolve`. Of the three, I've found `SIBoxBlur` to be the fastest and `SIGaussianBlur` to be the slowest. It's worth using `measureBlock()` to do your own performance testing. 
