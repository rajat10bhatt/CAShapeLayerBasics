//
//  ViewController.swift
//  CAShapeLayerDemo
//
//  Created by Rajat on 8/17/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let shapeLayer = CAShapeLayer()
    let squareCenter = CGPoint(x: 200, y: 200)

    override func viewDidLoad() {
        super.viewDidLoad()
        let square = squarePathWithCenter(center: squareCenter, side: 100)
        shapeLayer.path = square.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.imageView.layer.addSublayer(shapeLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self.view)
        if (shapeLayer.path?.contains(point!))! {
            print("Square tapped")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            CALayer.performWithoutAnimation {
                
                let xPosition = (squareCenter.x - 50) - point.x
                let yPosition = (squareCenter.y - 50) - point.y
                shapeLayer.position = CGPoint(x: (0-xPosition)-50, y: (0-yPosition)-50)
            }
        }
    }
    
    func squarePathWithCenter(center: CGPoint, side: CGFloat) -> UIBezierPath {
        let squarePath = UIBezierPath()
        let startX = center.x - side/2
        let startY = center.y - side/2
        squarePath.move(to: CGPoint(x: startX, y: startY))
        squarePath.addLine(to: CGPoint(x: startX+side, y: startY))
        squarePath.addLine(to: CGPoint(x: startX+side, y: startY+side))
        squarePath.addLine(to: CGPoint(x: startX, y: startY+side))
        squarePath.close()
        return squarePath
    }
    
    
}

extension CALayer {
    class func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void){
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        actionsWithoutAnimation()
        CATransaction.commit()
    }
}
