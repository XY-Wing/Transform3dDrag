//
//  ViewController.swift
//  Transform3DDrag
//
//  Created by Xue Yang on 2017/6/26.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var testV: UIView = {
        let testV = UIView()
        testV.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        testV.backgroundColor = .clear
        
        let subView = UIView.init(frame: testV.bounds)
        subView.backgroundColor = .red
        testV.addSubview(subView)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(viewTransform(_:)))
        testV.addGestureRecognizer(pan)
        
        return testV
    }()
    
    fileprivate var angle: CGPoint = CGPoint.init(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testV)
    }
    
    
    @objc private func viewTransform(_ sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: testV)
        let angleX = angle.x + (point.x/30)
        let angleY = angle.y - (point.y/30)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        testV.layer.sublayerTransform = transform
        //        print(String(format: "%.2f", angleY))
        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
    }
    
}
