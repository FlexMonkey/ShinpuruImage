# ShinpuruImage

## Syntactic Sugar for Accelerate/vImage and Core Image Filters

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

* `func SIPhotoEffectNoir() -> UIImage`
* `func SIPhotoEffectChrome() -> UIImage`
* `func SIPhotoEffectFade() -> UIImage`
* `func SIPhotoEffectInstant() -> UIImage`
* `func SIPhotoEffectMono() -> UIImage`
* `func SIPhotoEffectProcess() -> UIImage`
* `func SIPhotoEffectTonal() -> UIImage`
* `func SIPhotoEffectTransfer() -> UIImage`

### Color Effects

* `func SIFalseColor(#color0: UIColor, color1: UIColor) -> UIImage`
* `func SIPosterize(#levels: Int) -> UIImage`
* `func SIMonochrome(#color: UIColor, intensity: Float) -> UIImage`

### Stylize

* `func SIBloom(#radius: Float, intensity: Float) -> UIImage`
* `func SIGloom(#radius: Float, intensity: Float) -> UIImage`
* `func SIPixellate(#scale: Float) -> UIImage`

### Blur

* `func SIGaussianBlur(#radius: Float) -> UIImage`

### Color Adjustment

* `func SIColorControls(#saturation: Float, brightness: Float, contrast: Float) -> UIImage`
* `func SIExposureAdjust(#ev: Float) -> UIImage`
* `func SIGammaAdjust(#power: Float) -> UIImage`
* `func SIVibrance(#amount: Float) -> UIImage`
* `func SIWhitePointAdjust(#color: UIColor) -> UIImage`

### Morphology functions

* `func SIDilateFilter(#kernel: [UInt8]) -> UIImage`
* `func SIErodeFilter(#kernel: [UInt8]) -> UIImage`

### High Level Geometry Functions

* `func SIScale(#scaleX: Float, scaleY: Float) -> UIImage`
* `func SIRotate(#angle: Float, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage`
* `func SIRotateNinety(rotation: RotateNinety, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage`
* `func SIHorizontalReflect() -> UIImage`
* `func SIVerticalReflect() -> UIImage`

### Convolution

* `func SIBoxBlur(#width: Int, height: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage`
* `func SIFastBlur(#width: Int, height: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage`
* `func SIConvolutionFilter(#kernel: [Int16], divisor: Int, backgroundColor: UIColor = UIColor.blackColor()) -> UIImage`
