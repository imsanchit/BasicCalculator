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
                drawSine(coff, off)
            }
            else if eqn {
                drawEquation(coff , off)
            }
        }
    }
    
    public func drawEquation(_ cofficient: CGFloat,_ offset: CGFloat) {
        
        sine = false
        eqn = true
        coff = cofficient
        off = offset
        if graphView != nil {
            graphView.eqnCoff = cofficient
            graphView.eqnOff = offset
        }
    }

    public func drawSine(_ cofficient: CGFloat,_ offset: CGFloat) {
        
        sine = true
        eqn = false
        coff = cofficient
        off = offset
        if graphView != nil {
            graphView.sineCoff = cofficient
            graphView.sineOff = offset
        }
    }

    func moveGraph(byReactingTo panRecogniser : UIPanGestureRecognizer){
        let newPoint = panRecogniser.translation(in: graphView)
        graphView?.changeOrigin(newPoint , true)
        print(newPoint.x)
        print(newPoint.y)
    }
    
    func moveOrigin(byReactingTo tapRecogniser : UITapGestureRecognizer){
        if tapRecogniser.state == .ended {
            let pointOfTouch = tapRecogniser.location(ofTouch: 0, in: graphView)
            graphView?.changeOrigin(pointOfTouch , false)
            print(pointOfTouch.x)
            print(pointOfTouch.y)
        }
    }
}
