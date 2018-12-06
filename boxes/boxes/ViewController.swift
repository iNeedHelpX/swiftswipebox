//
//  ViewController.swift
//  boxes
//
//  Created by julia pak on 2018-12-05.
//  Copyright © 2018 julia pak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     let numViewPerRow = 15 //number of rows across in boxes
    var cells = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let width = view.frame.width / CGFloat(numViewPerRow)
        
       // loop within a loop to generate the graph of boxes
        for j in 0...30 {
            for i in 0...numViewPerRow {
             
                let cellView = UIView()
                cellView.backgroundColor = randomColor() //randdom box color
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))// Do any additional setup after loading the view, typically from a nib.
    }
    var selectedCell: UIView?
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) { //function to that handles the pan style swipe
        let location = gesture.location(in: view)
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        print (i, j)
        
        let key = "\(i)|\(j)"
        guard let cellView = cells[key] else { return }
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
       // cellView?.backgroundColor = .red
        selectedCell = cellView
        view.bringSubviewToFront(cellView)
        //animate the blocks
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }, completion: { (_) in
            
        })
    }
    }
func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(12.0)
        let blue =  CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

