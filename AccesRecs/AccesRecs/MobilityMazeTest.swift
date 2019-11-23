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

func printPoint(_ point: CGPoint) {
    //print("(\(point.x), \(point.y))")
}

class MobilityMazeTest : UIViewController {
    var hitTop = false
    var hitBottom = false
    var hitWall = false
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
    var edges: [UIBezierPath] = []
    
    override func viewDidLoad() {
        mainImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tempImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(mainImageView)
        self.view.addSubview(tempImageView)
        
        let radius = 15
        let rows = 6 //Int(self.view.frame.height - 200) / 10
        let cols = 6 //Int(self.view.frame.width - 20) / 30
        initGrid(rows, cols)
        drawMaze([])
        
        resetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor.blue
        resetButton.layer.cornerRadius = 20
        resetButton.frame = CGRect(x: 10, y: self.view.frame.height - 60, width: 120, height:50)
        
        doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = UIColor.red
        doneButton.layer.cornerRadius = 20
        doneButton.frame = CGRect(x: self.view.frame.width - 130, y: self.view.frame.height - 60, width: 120, height:50)
        
        //let label = UILabel()
        label.frame = CGRect(x: self.view.frame.width / 2 - 150, y: grid[0][0].y - 100, width: 300, height: 50)
        label.text = " Please connect the dots"
        label.textColor = UIColor.black
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        let topCircle = CAShapeLayer()
        topCircle.fillColor = nil
        topCircle.strokeColor = UIColor.black.cgColor
        topCircle.fillColor = UIColor.black.cgColor
        topCircle.lineWidth = 2
        topCircle.path = UIBezierPath(arcCenter: CGPoint(x:self.view.frame.width/2, y: grid[0][0].y - 40), radius: CGFloat(radius), startAngle: 0, endAngle: 360, clockwise: true).cgPath
        
        let bottomCircle = CAShapeLayer()
        bottomCircle.fillColor = nil
        bottomCircle.strokeColor = UIColor.black.cgColor
        bottomCircle.fillColor = UIColor.black.cgColor
        bottomCircle.lineWidth = 2
        bottomCircle.path = UIBezierPath(arcCenter: CGPoint(x:self.view.frame.width/2, y: grid[grid.count - 1][0].y + 40), radius: CGFloat(radius), startAngle: 0, endAngle: 360, clockwise: true).cgPath
                
        self.view.layer.addSublayer(topCircle)
        self.view.layer.addSublayer(bottomCircle)
        self.view.addSubview(label)
        self.view.addSubview(resetButton)
        self.view.addSubview(doneButton)
    }
    
    func initGrid(_ rows: Int, _ cols: Int) {
        grid = [[CGPoint]](repeating: [CGPoint](repeating: CGPoint(x:0, y:0), count: cols), count: rows)
        let startX = 5
        let endX = Int(self.view.frame.width) - 5
        
        let step = Double(endX - startX) / 5.0
        let startY = Int(self.view.frame.height) / 4
        for r in 0 ..< rows {
            for c in 0 ..< cols {
                grid[r][c] = CGPoint(x:startX + Int(Double(step) * Double(c)), y: startY + Int(Double(step) * Double(r)))
            }
        }
    }
    
    @objc func donePressed() {
        
    }
    
    
    func computeCross(_ pathOne: [UIBezierPath], _ pathTwo: CGRect) -> Bool{
       // if computeCross(edges[0].bounds, tempPath.bounds) {

        for i in 0 ..< pathOne.count {
            let intersect = edges[i].bounds.intersection(pathTwo)
            if !intersect.isNull {
                return true
            }
        }
        
        return false
        
    }
    
    func appendPath(_ pointOne: CGPoint, _ pointTwo:CGPoint) {
        let tempPath = UIBezierPath()
        tempPath.move(to: pointOne)
        tempPath.addLine(to: pointTwo)
        edges.append(tempPath)
    }
    
    func drawMaze(_ points: [CGPoint]) {

        let choice = Int.random(in: 0...0)
        var tempPath = UIBezierPath()
        
        if choice == 0 {
            path.move(to: grid[0][3])
            path.addLine(to: grid[0][0])
            path.addLine(to: grid[5][0])
            path.addLine(to: grid[5][1])
            path.addLine(to: grid[4][1])
            path.addLine(to: grid[4][2])
            
            appendPath(grid[0][3], grid[0][0])
            appendPath(grid[0][0], grid[5][0])
            appendPath(grid[5][0], grid[5][1])
            appendPath(grid[5][1], grid[4][1])
            appendPath(grid[4][1], grid[4][2])
            
            path.move(to: grid[3][1])
            path.addLine(to: grid[3][3])
            path.addLine(to: grid[5][3])
            path.move(to: grid[5][2])
            path.addLine(to: grid[5][5])
            path.addLine(to: grid[0][5])
            path.addLine(to: grid[0][4])
            path.addLine(to: grid[1][4])
            path.addLine(to: grid[1][1])
            path.addLine(to: grid[2][1])
            
            appendPath(grid[3][1], grid[3][3])
            appendPath(grid[3][3], grid[5][3])
            appendPath(grid[5][2], grid[5][5])
            appendPath(grid[5][5], grid[0][5])
            appendPath(grid[0][5], grid[0][4])
            appendPath(grid[0][4], grid[1][4])
            appendPath(grid[1][4], grid[1][1])
            appendPath(grid[1][1], grid[2][1])
            
            path.move(to: grid[2][2])
            path.addLine(to: grid[2][5])
            path.move(to: grid[3][4])
            path.addLine(to: grid[3][5])
            path.move(to: grid[4][4])
            path.addLine(to: grid[5][4])
            
            appendPath(grid[2][2], grid[2][5])
            appendPath(grid[3][4], grid[3][5])
            appendPath(grid[4][4], grid[5][4])

            
            
        } else {
            path.move(to: grid[0][4])
            path.addLine(to: grid[0][0])
            path.addLine(to: grid[5][0])
            path.move(to: grid[5][1])
            path.addLine(to: grid[5][5])
            path.addLine(to: grid[0][5])
            
            
            
            path.move(to: grid[3][0])
            path.addLine(to: grid[3][1])
            path.addLine(to: grid[4][1])
            path.addLine(to: grid[4][4])
            path.move(to: grid[4][3])
            path.addLine(to: grid[3][3])
            path.addLine(to: grid[3][2])
            path.addLine(to: grid[2][2])
            path.addLine(to: grid[2][1])
            path.addLine(to: grid[1][1])
            
            path.move(to: grid[1][2])
            path.addLine(to: grid[1][3])
            path.addLine(to: grid[0][3])
            path.move(to: grid[3][5])
            path.addLine(to: grid[3][4])
            path.addLine(to: grid[1][4])
            path.move(to: grid[2][4])
            path.addLine(to: grid[2][3])
        }
        
        //path.addClip()
        maze.path = path.cgPath
        maze.fillColor = nil
        maze.strokeColor = UIColor.black.cgColor
        maze.lineWidth = 2
        //print(maze.bounds)
        //print(grid)
        
        self.view.layer.addSublayer(maze)
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
        
        
     let tempPath = UIBezierPath()
        tempPath.move(to: lastPoint)
        tempPath.addLine(to: currentPoint)
        //print("temp: \(tempPath.bounds)")
        //print(edges[0].bounds)
        if computeCross(edges, tempPath.bounds) {
            print("Hit wall: (\(currentPoint.x), \(currentPoint.y))")
        }
        
        
        if edges[0].contains(currentPoint) {
            //print("Hit wall: (\(currentPoint.x), \(currentPoint.y))")
            //print(edges[0].bounds)
        }
    
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
