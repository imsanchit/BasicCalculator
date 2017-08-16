//
//  GraphView.swift
//  BasicCalculator
//
//  Created by Sanchit Mittal on 03/08/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import UIKit


@IBDesignable
class GraphView: UIView {
    
    private var oldGraphCenterX : CGFloat!
    private var oldGraphCenterY : CGFloat!
    private var graphCenterX : CGFloat! { didSet { setNeedsDisplay() } }
    private var graphCenterY : CGFloat! { didSet { setNeedsDisplay() } }
    private var shouldChangeOrigin = true
    
    @IBInspectable
    var scale : CGFloat = 0.9 { didSet { setNeedsDisplay() } }

    @IBInspectable
    var axisColor : UIColor = UIColor.black  { didSet { setNeedsDisplay() } }

    @IBInspectable
    var equationColor : UIColor = UIColor.blue  { didSet { setNeedsDisplay()
        setNeedsLayout()} }
    
    @IBInspectable
    var lineWidth : CGFloat = 5.0  { didSet { setNeedsDisplay() } }
    
    func changeScale(byReactingTo pinchRecogniser : UIPinchGestureRecognizer){
        print("Zooming starts")
        switch pinchRecogniser.state {
        case .changed , .ended:
            print(pinchRecogniser.scale)
            scale*=pinchRecogniser.scale
            print("Scale \(scale)")
            pinchRecogniser.scale=1
        default:
            break
        }
    }

    private func pathForXAxis(_ graphCenterX : CGFloat , _ graphCenterY : CGFloat) -> UIBezierPath{
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x:0 , y:graphCenterY))
        path.addLine(to: CGPoint(x:self.bounds.width , y: graphCenterY))
        return path
    }

    private func pathForYAxis(_ graphCenterX : CGFloat , _ graphCenterY : CGFloat) -> UIBezierPath{
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            path.move(to: CGPoint(x:graphCenterX , y:0))
            path.addLine(to: CGPoint(x:graphCenterX , y:self.bounds.height))
            return path
    }

    private func drawEquation(_ boundary: CGFloat ,_ cofficient: CGFloat , _ offset: CGFloat) -> UIBezierPath{
        let path = UIBezierPath()
        path.lineWidth = lineWidth

        path.move(to: CGPoint(x:graphCenterX+(boundary*scale)/4 , y:graphCenterY-(boundary*scale)/4))
        path.addLine(to: CGPoint(x:graphCenterX-(boundary*scale)/4 , y:graphCenterY+(boundary*scale)/4))
        
        path.move(to: CGPoint(x:graphCenterX+(boundary*scale/4) , y:graphCenterY-((boundary*cofficient*scale)/4)+offset))
        path.addLine(to: CGPoint(x:graphCenterX-(boundary*scale/4) , y:graphCenterY+((boundary*cofficient*scale)/4)+offset))

        return path
    }
    
    public func changeOrigin(_ origin : CGPoint ,_ changeOrigin : Bool){
        graphCenterX = origin.x
        graphCenterY = origin.y
        shouldChangeOrigin = changeOrigin
    }
    
    func drawAxes() {
        if graphCenterX == nil || graphCenterY == nil {
            graphCenterX = bounds.width/2
            graphCenterY = bounds.height/2
            oldGraphCenterX = graphCenterX
            oldGraphCenterY = graphCenterY
        }
        axisColor.set()
        if(!shouldChangeOrigin){
            pathForXAxis(oldGraphCenterX , oldGraphCenterY).stroke()
            pathForYAxis(oldGraphCenterX , oldGraphCenterY).stroke()
        }
        else {
            pathForXAxis(graphCenterX , graphCenterY).stroke()
            pathForYAxis(graphCenterX , graphCenterY).stroke()
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawAxes()
        equationColor.set()
        var boundary: CGFloat
        if(self.bounds.height<self.bounds.width) {
            boundary = self.bounds.height
        }
        else {
            boundary = self.bounds.width
        }
        drawEquation(boundary,1/3,50).stroke()
    }
}
