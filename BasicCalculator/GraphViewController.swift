//
//  GraphViewController.swift
//  BasicCalculator
//
//  Created by Sanchit Mittal on 02/08/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import UIKit
import Foundation


//change origin and draw axis.

class GraphViewController: UIViewController {
    
    var eqn = false
    var sine = false
    var coff: CGFloat!
    var off: CGFloat!
    
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var graphView: GraphView! {
        didSet{
            let handler = #selector(GraphView.changeScale(byReactingTo:))
            let pinchRecogniser = UIPinchGestureRecognizer(target: graphView, action: handler)
            graphView.addGestureRecognizer(pinchRecogniser)

            let panRecogniser = UIPanGestureRecognizer(target: self, action: #selector(moveGraph(byReactingTo:)))
            graphView.addGestureRecognizer(panRecogniser)
            
            let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(moveOrigin(byReactingTo:)))
            tapRecogniser.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tapRecogniser)
            
            if sine {
                print("Calling sine")
                drawSine(coff, off)
            }
            else if eqn {
                print("calling eqn")
                drawEquation(coff , off)
            }
        }
    }
    
    public func drawEquation(_ cofficient: CGFloat,_ offset: CGFloat) {
        
        print("calling eqn 1")
        sine = false
        eqn = true
        coff = cofficient
        off = offset
        if graphView != nil {
            print("calling eqn 2")
            graphView.drawAxes()
            graphView.equationColor.set()
            var boundary: CGFloat
            if(graphView.bounds.height < graphView.bounds.width) {
                boundary = graphView.bounds.height
            }
            else {
                boundary = graphView.bounds.width
            }
            graphView.drawEquation(boundary,cofficient,offset).stroke()
        }
    }

    public func drawSine(_ cofficient: CGFloat,_ offset: CGFloat) {
        sine = true
        eqn = false
        coff = cofficient
        off = offset
        if graphView != nil {
            graphView.drawAxes()
            graphView.equationColor.set()
            var boundary: CGFloat
            if(graphView.bounds.height < graphView.bounds.width) {
                boundary = graphView.bounds.height
            }
            else {
                boundary = graphView.bounds.width
            }
            graphView.drawSineGraph(boundary,cofficient,offset).stroke()
        }
    }

    func moveGraph(byReactingTo panRecogniser : UIPanGestureRecognizer){
        print("Pan pressed")
        let newPoint = panRecogniser.translation(in: graphView)
        graphView?.changeOrigin(newPoint , true)
        print(newPoint.x)
        print(newPoint.y)
    }
    
    func moveOrigin(byReactingTo tapRecogniser : UITapGestureRecognizer){
        print("Tap pressed")
        if tapRecogniser.state == .ended {
            let pointOfTouch = tapRecogniser.location(ofTouch: 0, in: graphView)
            graphView?.changeOrigin(pointOfTouch , false)
            print(pointOfTouch.x)
            print(pointOfTouch.y)
        }
    }
}
