//
//  SSExtension.swift
//  swiftGame
//
//  Created by xiaobei on 2018/5/28.
//  Copyright © 2018年 xiaobei. All rights reserved.
//

import UIKit

extension UIColor {
    
    var toImage: UIImage {
        
        let bounds = CGRect(origin: .zero, size: CGSize(width: 1.0, height: 1.0))
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { (context) in
            self.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1.0, height: 1.0))
        })
    }
}

extension Int {
    
    /// 随机值
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
