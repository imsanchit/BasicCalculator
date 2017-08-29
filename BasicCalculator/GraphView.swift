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
    
    
    var sineCoff: CGFloat! { didSet { setNeedsDisplay() } }
    var sineOff: CGFloat! { didSet { setNeedsDisplay() } }
    var eqnCoff: CGFloat! { didSet { setNeedsDisplay() } }
    var eqnOff: CGFloat! { didSet { setNeedsDisplay() } }
    
    
    
    
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

    public func drawSineGraph(_ boundary: CGFloat ,_ cofficient: CGFloat , _ offset: CGFloat) -> UIBezierPath{
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        let width: CGFloat = (boundary*scale)/2
        let height: CGFloat = (boundary*scale)/2
                
        path.move(to: CGPoint(x:graphCenterX , y:graphCenterY+offset))
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = graphCenterX + (CGFloat(angle/360.0) * width * 0.8)
            let y = graphCenterY - (CGFloat(sin(angle/180.0 * Double.pi)) * height * 0.3*cofficient)+offset
            path.addLine(to: CGPoint(x: x, y: y))
        }
        return path
    }
    
    public func drawEquation(_ boundary: CGFloat ,_ cofficient: CGFloat , _ offset: CGFloat) -> UIBezierPath{
        let path = UIBezierPath()
        path.lineWidth = lineWidth
     
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
        if sineCoff != nil &&  sineOff != nil {
            drawSineGraph(boundary,sineCoff,sineOff).stroke()

        }
        if eqnCoff != nil &&  eqnOff != nil {
            drawEquation(boundary,eqnCoff,eqnOff).stroke()
        }
    }
}
