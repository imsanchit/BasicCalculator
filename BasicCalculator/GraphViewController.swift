//
//  GraphViewController.swift
//  BasicCalculator
//
//  Created by Sanchit Mittal on 02/08/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import UIKit
import Foundation

class GraphViewController: UIViewController {
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
