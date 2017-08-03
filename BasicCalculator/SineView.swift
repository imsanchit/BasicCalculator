//
//  SineView.swift
//  BasicCalculator
//
//  Created by Sanchit Mittal on 02/08/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import Foundation
import UIKit

class SineView: UIView {
    
    override func draw(_ rect: CGRect) {
        print("called")
        let graphWidth: CGFloat = 0.8
        let amplitude: CGFloat = 0.3
 
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let width = rect.width
        let height = rect.height
        
        let origin = CGPoint(x: width * (1 - graphWidth) / 2, y: height * 0.50)
        
        let path = UIBezierPath()
        path.move(to: origin)
        
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * width * graphWidth
            let y = origin.y - CGFloat(cos(angle/180.0 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        UIColor.black.setStroke()
        path.stroke()
    }
    
}
