//
//  SetLayoutViewController.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/4.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit

class SetLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        drawGrid()
    }

    func drawGrid() -> Void {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 2
        
        let screenWidth = Double(UIScreen.main.bounds.size.width)
        let margin = 20.0
        let originY = 100.0
        let length = screenWidth - 2.0 * margin
        let gridRect = CGRect(x: margin, y: originY, width: length, height: length)
        
        let path = UIBezierPath(rect: gridRect)
        path.move(to: CGPoint(x: gridRect.minX, y: gridRect.midY - CGFloat(length / 4.0)))
        path.addLine(to: CGPoint(x: gridRect.maxX, y: gridRect.midY - CGFloat(length / 4.0)))
        
        path.move(to: CGPoint(x: gridRect.minX, y: gridRect.midY))
        path.addLine(to: CGPoint(x: gridRect.maxX, y: gridRect.midY))
        
        path.move(to: CGPoint(x: gridRect.minX, y: gridRect.midY + CGFloat(length / 4.0)))
        path.addLine(to: CGPoint(x: gridRect.maxX, y: gridRect.midY + CGFloat(length / 4.0)))
        
        
        path.move(to: CGPoint(x: gridRect.midX - CGFloat(length / 4.0), y: gridRect.minY))
        path.addLine(to: CGPoint(x: gridRect.midX - CGFloat(length / 4.0), y: gridRect.maxY))
        
        path.move(to: CGPoint(x: gridRect.midX, y: gridRect.minY))
        path.addLine(to: CGPoint(x: gridRect.midX, y: gridRect.maxY))
        
        path.move(to: CGPoint(x: gridRect.midX + CGFloat(length / 4.0), y: gridRect.minY))
        path.addLine(to: CGPoint(x: gridRect.midX + CGFloat(length / 4.0), y: gridRect.maxY))
        
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
