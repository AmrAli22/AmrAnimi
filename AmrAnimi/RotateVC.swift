//
//  RotateVC.swift
//  AmrAnimi
//
//  Created by Amr Ali on 27/09/2021.
//

import UIKit

class SpinningCircleView : UIView {
    
    let spinningCircle = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // configure(start: start, end: end)
    }
    
    required init(frame: CGRect , start : CGFloat , end : CGFloat) {
        super.init(frame: frame)
        print("CALLED")
        self.configure(start: start, end: end)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(start : CGFloat , end : CGFloat) {
        
        frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        let rect  = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
     

        
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor =  UIColor.systemBlue.cgColor  //color Literal
        spinningCircle.lineWidth = 4
        spinningCircle.strokeEnd = end
        spinningCircle.strokeStart = start
      
        spinningCircle.lineCap = .round
        
        self.layer.addSublayer(spinningCircle)
        
    }
    
    func animate(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { completed in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { complted in
                self.animate()
            }

        }

    }

    
}
