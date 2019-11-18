//
//  MobilityDrawingTestView.swift
//  AccesRecs
//
//  Created by Audrey Jones on 11/17/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit

class MobilityDrawingTest : UIViewController {
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var mainImageView : UIImageView = UIImageView()
    var tempImageView : UIImageView = UIImageView()
    var resetButton : UIButton = UIButton()
    override func viewDidLoad() {
        mainImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tempImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(mainImageView)
        self.view.addSubview(tempImageView)
        resetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor.blue
        resetButton.layer.cornerRadius = 20
        resetButton.frame = CGRect(x: 200 - (100), y: self.view.frame.height - 100, width: 200, height:50)
        self.view.addSubview(resetButton)
        

    }
    
    @objc func resetPressed(sender: UIButton!) {
      mainImageView.image = nil
    }
    
    @IBAction func sharePressed(_ sender: Any) {
      guard let image = mainImageView.image else {
        return
      }
      let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
      present(activity, animated: true)
    }
    
    @IBAction func pencilPressed(_ sender: UIButton) {
      guard let pencil = Pencil(tag: sender.tag) else {
        return
      }
      color = pencil.color
      if pencil == .eraser {
        opacity = 1.0
      }
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
      UIGraphicsBeginImageContext(view.frame.size)
      guard let context = UIGraphicsGetCurrentContext() else {
        return
      }
      tempImageView.image?.draw(in: view.bounds)
      
      context.move(to: fromPoint)
      context.addLine(to: toPoint)
      
      context.setLineCap(.round)
      context.setBlendMode(.normal)
      context.setLineWidth(brushWidth)
      context.setStrokeColor(color.cgColor)
      
      context.strokePath()
      
      tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      tempImageView.alpha = opacity
      
      UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first else {
        return
      }
      swiped = false
      lastPoint = touch.location(in: view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first else {
        return
      }
      swiped = true
      let currentPoint = touch.location(in: view)
      drawLine(from: lastPoint, to: currentPoint)
      
      lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      if !swiped {
        // draw a single point
        drawLine(from: lastPoint, to: lastPoint)
      }
      
      // Merge tempImageView into mainImageView
      UIGraphicsBeginImageContext(mainImageView.frame.size)
      mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
      mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      tempImageView.image = nil
    }

}
