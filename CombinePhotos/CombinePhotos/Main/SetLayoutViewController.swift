//
//  SetLayoutViewController.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/4.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit

class SetLayoutViewController: UIViewController {

    @IBOutlet weak var combineButton: UIButton!
    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    var chooseRow = 0
    var chooseCol = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        drawGrid()
        fillImageToGridRect(image: "check")
        buttonTopConstraint.constant = gridRectValue().maxY + 20.0
    }
    
    func gridRectValue() -> CGRect {
        let screenWidth = Double(UIScreen.main.bounds.size.width)
        let margin = 20.0
        let originY = 100.0
        let length = screenWidth - 2.0 * margin
        return CGRect(x: margin, y: originY, width: length, height: length)
    }

    func drawGrid() -> Void {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 2
        
        let gridRect = gridRectValue()
        let length = gridRect.width
        
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
    
    func fillImageToGridRect(image name: String) -> Void {
        let containerView = UIView(frame: gridRectValue())
        let delta: CGFloat = 2.0
        let length = gridRectValue().size.width / 4.0
        let image = UIImage(named: name)
        
        for row in 0 ..< 4 {
            for col in 0 ..< 4 {
                let imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: delta + CGFloat(col) * length, y: delta + CGFloat(row) * length, width: length - 2.0 * delta, height: length - 2.0 * delta)
                imageView.isHidden = true
                containerView.addSubview(imageView)
            }
        }
        
        view.addSubview(containerView)
        containerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(chooseLayout)))
    }
    
    
    @objc func chooseLayout(sender: UIPanGestureRecognizer) -> Void {
        let point = sender.location(in: sender.view)
        let length = gridRectValue().size.width / 4.0
        let row = Int(point.y / (length + 1) + 1)
        let col = Int(point.x / (length + 1) + 1)
        let checkImageViews = sender.view?.subviews
        for rowIndex in 0 ..< 4 {
            for colIndex in 0 ..< 4 {
                let imamgeView = checkImageViews![rowIndex * 4 + colIndex] as! UIImageView
                imamgeView.isHidden = rowIndex >= row || colIndex >= col
            }
        }
        combineButton.isEnabled = true
        combineButton.backgroundColor = UIColor.red
        if row != chooseRow || col != chooseCol {
            combineButton.setTitle("去合成 \(row) * \(col) 的图片", for: .normal)
            chooseCol = col
            chooseRow = row
        }
        
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
