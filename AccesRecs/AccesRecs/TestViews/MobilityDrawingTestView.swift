//
//  MobilityDrawingTestView.swift
//  AccesRecs
//
//  Created by Audrey Jones on 11/17/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit

//Returns true if num2 is within a certain threshold of num1
func isWithinThreshold(num1: Double, num2: Double, threshold: Double) -> Bool {
    let range = (num1 - num1*threshold)...(num1 + num1*threshold)
    return range.contains(num2)
}


// Calculates the distance between two given points
func calcDistance(p1: CGPoint, p2: CGPoint) -> Double {
    let xDist: CGFloat = (p2.x - p1.x);
    let yDist: CGFloat = (p2.y - p1.y);
    return Double(sqrt(xDist * xDist + yDist * yDist))
}

class MobilityDrawingTest : UIViewController {
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var mainImageView : UIImageView = UIImageView()
    var tempImageView : UIImageView = UIImageView()
    var resetButton : UIButton = UIButton()
    var totalDistance: Double = 0.0
    var shapePerimeter: Double = 0.0
    var doneButton: UIButton = UIButton()

    override func viewDidLoad() {
        mainImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tempImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(mainImageView)
        self.view.addSubview(tempImageView)
        resetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor.blue
        resetButton.layer.cornerRadius = 20
        resetButton.frame = CGRect(x: 10, y: self.view.frame.height - 70, width: 120, height:60)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)

        let prompt = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 100, y: 75, width: 200, height: 100))
        prompt.textColor = UIColor.black
        prompt.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
        prompt.text = "Please trace the shape below one time:"
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true


        doneButton.addTarget(self, action: #selector(calcResults), for: .touchUpInside)
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = UIColor.red
        doneButton.layer.cornerRadius = 20
        doneButton.frame = CGRect(x: self.view.frame.width - 130, y: self.view.frame.height - 70, width: 120, height:60)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)

        shapePerimeter = createTestShape()

        self.view.bringSubviewToFront(tempImageView)
        self.view.bringSubviewToFront(mainImageView)
        self.view.addSubview(resetButton)
        self.view.addSubview(prompt)
        self.view.addSubview(doneButton)
    }

    @objc func resetPressed(sender: UIButton!) {
      mainImageView.image = nil
      totalDistance = 0.0
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

    @objc func calcResults() {
        let resultView = ResultView()
        var result = ""

        if(isWithinThreshold(num1: shapePerimeter, num2: totalDistance, threshold: 0.05)) {
            result = "Perfect!!"
        } else {
            result = "We have recommendations for you:"
            let recsRequest = RecsRequest(featid:24)
            recsRequest.displayRecs(resultView: resultView)
           // // resultView.steps = Resultdata[3]
       }

       resultView.result = result
       resultView.resultType = "Motion"

        navigationController?.popViewController(animated: false)

       self.present(resultView, animated: true, completion: nil)
    }

// Generates a shape of random size to trace, displays it, and returns its perimeter
    func createTestShape() -> Double {
        let id = Int.random(in: 0 ... 7)
        let layer = CAShapeLayer()
        layer.fillColor = nil
        layer.strokeColor = UIColor.gray.cgColor
        layer.lineWidth = 2

        var perimeter: Double = 0.0
        let shapeHeight: Int = Int.random(in: 100 ..< 350)
        let shapeLength: Int = Int.random(in: 100 ..< 250)

        switch id {
        // Rounded Rectangle
        case 0:
            layer.path = UIBezierPath(roundedRect: CGRect(x: self.view.frame.width/2 - CGFloat(shapeLength / 2), y: self.view.frame.height/2 - CGFloat(shapeHeight / 2), width: CGFloat(shapeLength), height: CGFloat(shapeHeight)), cornerRadius: 50).cgPath
            perimeter = calcRoundedRectanglePerimeter(height: shapeHeight, length: shapeLength, radius:50)

        // Circle
        case 1:
            let radius: Double = Double.random(in: 50 ..< 100)
            layer.path = UIBezierPath(arcCenter: CGPoint(x:self.view.frame.width/2, y: self.view.frame.height/2), radius: CGFloat(radius), startAngle: 0, endAngle: 360, clockwise: true).cgPath
            perimeter = 2.0 * Double.pi * radius

        //Rectangle
        case 2:
            layer.path = UIBezierPath(roundedRect: CGRect(x: self.view.frame.width/2 - CGFloat(shapeLength / 2), y: self.view.frame.height/2 - CGFloat(shapeHeight / 2), width: CGFloat(shapeLength), height: CGFloat(shapeHeight)), cornerRadius: 0).cgPath
                perimeter = Double (2 * shapeLength + 2 * shapeHeight)

        // Triangle
        case 3:
            let path = UIBezierPath()
            let pointOne = CGPoint(x:self.view.frame.width / 2 - CGFloat(shapeLength / 2), y: self.view.frame.height / 2 + CGFloat(shapeHeight/2))
            let pointTwo = CGPoint(x: pointOne.x + CGFloat(shapeLength), y: pointOne.y)
            let pointThree = CGPoint(x: self.view.frame.width / 2, y: pointOne.y - CGFloat(shapeHeight))
            path.move(to: pointOne)
            path.addLine(to:pointTwo)
            path.addLine(to:pointThree)
            path.addLine(to:pointOne)

            layer.path = path.cgPath
            perimeter = calcDistance(p1: pointOne, p2: pointTwo) + calcDistance(p1: pointTwo, p2: pointThree) + calcDistance(p1: pointThree, p2: pointOne)

        // Square
        case 4: layer.path = UIBezierPath(rect: CGRect(x: self.view.frame.width/2 - CGFloat(shapeLength / 2), y: self.view.frame.height/2 - CGFloat(shapeLength / 2), width: CGFloat(shapeLength), height: CGFloat(shapeLength))).cgPath
            perimeter = Double(4 * shapeLength)

        // Hourglass
        case 5:
            let path = UIBezierPath()
            let pointOne = CGPoint(x:self.view.frame.width / 2 - CGFloat(shapeLength / 2), y: self.view.frame.height / 2 + CGFloat(shapeHeight/2))
            let pointTwo = CGPoint(x: pointOne.x + CGFloat(shapeLength), y: pointOne.y)
            let pointThree = CGPoint(x: pointTwo.x, y: pointOne.y - CGFloat(shapeHeight))
            let pointFour = CGPoint(x: pointOne.x, y: pointThree.y)
            path.move(to: pointOne)
            path.addLine(to:pointTwo)
            path.addLine(to:pointFour)
            path.addLine(to:pointThree)

            path.addLine(to:pointOne)

            layer.path = path.cgPath
            perimeter = calcDistance(p1: pointOne, p2: pointTwo) + calcDistance(p1: pointTwo, p2: pointFour) + calcDistance(p1: pointFour, p2: pointThree) + calcDistance(p1: pointThree, p2: pointOne)

        // Trapezoid
        case 6:
            let path = UIBezierPath()
            let pointOne = CGPoint(x:self.view.frame.width / 2 - CGFloat(shapeLength / 2) - 15, y: self.view.frame.height / 2 + CGFloat(shapeHeight/2))
            let pointTwo = CGPoint(x: pointOne.x + CGFloat(shapeLength) + 30, y: pointOne.y)
            let pointThree = CGPoint(x: pointTwo.x - 40, y: pointOne.y - CGFloat(shapeHeight))
            let pointFour = CGPoint(x: pointOne.x + 40, y: pointThree.y)

            path.move(to: pointOne)
            path.addLine(to:pointTwo)
            path.addLine(to:pointThree)
            path.addLine(to:pointFour)
            path.addLine(to:pointOne)

            layer.path = path.cgPath
            perimeter = calcDistance(p1: pointOne, p2: pointTwo) + calcDistance(p1: pointTwo, p2: pointThree) + calcDistance(p1: pointFour, p2: pointThree) + calcDistance(p1: pointFour, p2: pointOne)

        // Ellipse
        default:
            layer.path = UIBezierPath(ovalIn: CGRect(x: self.view.frame.width/2 - CGFloat(shapeLength / 2), y: self.view.frame.height/2 - CGFloat(shapeHeight / 2), width: CGFloat(shapeLength), height: CGFloat(shapeHeight))).cgPath
            perimeter = calcEllipsePerimeter(height: shapeHeight, length: shapeLength)
        }

        view.layer.addSublayer(layer)
        return perimeter
    }

    // Calculates the perimeter of a rounded rectangle
    func calcRoundedRectanglePerimeter(height: Int, length: Int, radius: Int) -> Double {
        var perimeter: Double =  Double(2 * height + 2 * length)
        perimeter -= Double(8 * radius)
        perimeter += 2.0 * Double(radius) * Double.pi
        return perimeter
    }

    // Approximates the circumference of an ellipse
    func calcEllipsePerimeter(height: Int, length: Int) -> Double {
        let temp = Double(Double(height * height) / 4.0 + Double(length * length) / 4.0)
        return 2 * Double.pi * Double(sqrt(temp/2.0))
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

      //context.setLineWidth(4)
        context.setStrokeColor(UIColor.systemPurple.cgColor)
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
        
      let xDist = CGFloat(currentPoint.x - lastPoint.x)
      let yDist = CGFloat(currentPoint.y - lastPoint.y)
      let distance = sqrt(xDist * xDist + yDist * yDist)
        
      totalDistance = totalDistance + Double(distance)
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
