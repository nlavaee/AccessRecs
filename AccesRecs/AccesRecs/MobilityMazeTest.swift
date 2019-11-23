//
//  MobilityMazeTest.swift
//  AccesRecs
//
//  Created by Daniel Haines on 11/22/19.
//  Copyright © 2019 Daniel Haines. All rights reserved.
//

import Foundation
import UIKit

let points: [(Int,Int)] = [(0,0)] //, grid[0][grid[0].count - 1], grid[grid.count - 1][grid[0].count-1], grid[grid.count - 1][0]
//]

class MobilityMazeTest : UIViewController {
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
    var label = UILabel()
    var grid: [[CGPoint]] = []
    var maze: CAShapeLayer = CAShapeLayer()
    var path: UIBezierPath = UIBezierPath()
    
    override func viewDidLoad() {
        mainImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tempImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(mainImageView)
        self.view.addSubview(tempImageView)
        resetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor.blue
        resetButton.layer.cornerRadius = 20
        resetButton.frame = CGRect(x: 10, y: self.view.frame.height - 60, width: 120, height:50)
        
        //let label = UILabel()
        label.frame = CGRect(x: self.view.frame.width / 2 - 100, y: 50, width: 200, height: 75)
        label.text = " Please Connect the dots"
        label.textColor = UIColor.black
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        let radius = 10
        
        let topCircle = CAShapeLayer()
        topCircle.fillColor = nil
        topCircle.strokeColor = UIColor.blue.cgColor
        topCircle.fillColor = UIColor.blue.cgColor
        topCircle.lineWidth = 2
        topCircle.path = UIBezierPath(arcCenter: CGPoint(x:self.view.frame.width/2, y: self.view.frame.height / 4), radius: CGFloat(radius), startAngle: 0, endAngle: 360, clockwise: true).cgPath
        
        let bottomCircle = CAShapeLayer()
        bottomCircle.fillColor = nil
        bottomCircle.strokeColor = UIColor.blue.cgColor
        bottomCircle.fillColor = UIColor.blue.cgColor
        bottomCircle.lineWidth = 2
        bottomCircle.path = UIBezierPath(arcCenter: CGPoint(x:self.view.frame.width/2, y: 3 * self.view.frame.height / 4), radius: CGFloat(radius), startAngle: 0, endAngle: 360, clockwise: true).cgPath
        
        // first count = numCols (width), second count = numRows (height)
        let rows = 10 //Int(self.view.frame.height - 200) / 10
        let cols = 10 //Int(self.view.frame.width - 20) / 30
        
        print("height: \(self.view.frame.height) for \(rows) rows")
        print("width: \(self.view.frame.height) for \(cols) cols")
        
        initGrid(rows, cols)
        drawMaze([])
        print(grid.count) //46 rows
        print(grid[0].count) //35 cols
        path.move(to: grid[0][0])
        path.addLine(to: grid[0][4])
        path.move(to: grid[0][5])
        path.addLine(to: grid[0][9])
        path.addLine(to: grid[9][9])
        path.addLine(to: grid[9][0])
        path.addLine(to: grid[0][0])
        path.move(to:grid[0][1])
        path.addLine(to:grid[1][1])
        path.addLine(to:grid[1][8])
        path.addLine(to:grid[2][8])
        path.move(to: grid[3][4])
        path.addLine(to: grid[3][8])
        path.addLine(to: grid[7][8])
        path.addLine(to: grid[7][9])
        path.move(to: grid[2][8])
        path.addLine(to: grid[2][1])
        path.move(to: grid[4][4])
        path.addLine(to: grid[4][7])
        path.addLine(to: grid[7][7])
        path.move(to: grid[8][9])
        path.addLine(to: grid[8][3])
        maze.path = path.cgPath
        maze.fillColor = nil
        maze.strokeColor = UIColor.black.cgColor
        maze.lineWidth = 2

        //print(grid)
        
        self.view.layer.addSublayer(maze)
        self.view.layer.addSublayer(topCircle)
        self.view.layer.addSublayer(bottomCircle)
        self.view.addSubview(label)
    }
    
    func initGrid(_ rows: Int, _ cols: Int) {
        grid = [[CGPoint]](repeating: [CGPoint](repeating: CGPoint(x:0, y:0), count: cols), count: rows)
        let startX = 10
        let startY = 150
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                grid[r][c] = CGPoint(x:startX + 40 * c, y: startY + 40 * r)
            }
        }
    }
    
    func drawMaze(_ points: [CGPoint]) {
        //path.move(to: grid[points[0][0],points[0][1]])
        
//        for i in 1 ..< points.count {
//            path.addLine(to: points[i])
//        }
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
      context.setStrokeColor(UIColor.cyan.cgColor)
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


//       path.move(to: grid[0][0])
//       path.addLine(to: grid[0][4])
//       path.move(to: grid[0][5])
//       path.addLine(to: grid[0][9])
//       path.addLine(to: grid[9][9])
//       path.addLine(to: grid[9][0])
//       path.addLine(to: grid[0][0])
//       path.move(to:grid[0][1])
//       path.addLine(to:grid[1][1])
//       path.addLine(to:grid[1][8])
//       path.addLine(to:grid[2][8])
//       path.move(to: grid[3][4])
//       path.addLine(to: grid[3][8])
//       path.addLine(to: grid[7][8])
//       path.addLine(to: grid[7][9])
//       path.move(to: grid[2][8])
//       path.addLine(to: grid[2][1])
//       path.move(to: grid[4][4])
//       path.addLine(to: grid[4][7])
//       path.addLine(to: grid[7][7])
//       path.move(to: grid[8][9])
//       path.addLine(to: grid[8][3])
