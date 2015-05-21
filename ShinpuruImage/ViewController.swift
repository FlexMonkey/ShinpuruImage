//
//  ViewController.swift
//  ShinpuruImage
//
//  Created by Simon Gladman on 21/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        let imageView = UIImageView(frame: view.bounds.rectByInsetting(dx: 100, dy: 100))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(imageView)
        
        let image = UIImage(named: "image.jpg")!
        // let convolvedImage = SIConvolutionFilter(image, kernel: [0, -1, 0, -1, 7, -1, 0, -1, 0], divisor: 4)
        
        // [10,10,10,10,10,  10,1,1,1,10,  10,1,1,1,10,  10,1,1,1,10,   10,10,10,10,10]
        
        let convolvedImage = SIDilateFilter(image, kernel: [10,10,10,10,10,  10,1,1,1,10,  10,1,0,1,10,  10,1,1,1,10,   10,10,10,10,10])

        let rotatedImage = SIRotate(convolvedImage, angle: 0.3, backgroundColor: UIColor.purpleColor())
        
        let scaledImage = SIScale(rotatedImage, scaleX: 1, scaleY: 0.76)
        
        imageView.image = scaledImage
        
        
    }



}

