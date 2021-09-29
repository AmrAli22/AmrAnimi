//
//  ViewController.swift
//  AmrAnimi
//
//  Created by Amr Ali on 15/09/2021.
//

import UIKit

class ViewController: UIViewController {

    typealias Radians = CGFloat
    var TOPtimer = Timer()
    var Bottomtimer = Timer()
    
    var topView = UIView()
    var BottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        
     
        self.topView     =     addWedgeView(color: #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), angle: 0.5 * .pi)
        self.BottomView  =     addWedgeView(color: #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1), angle: 1.5 * .pi)
        
        self.view.addSubview(topView)
        self.view.addSubview(BottomView)
        
        self.TOPtimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateCounting(view: self.topView)
           })
        self.Bottomtimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateCounting(view: self.BottomView)
           })
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.TOPtimer.invalidate()
            self.Bottomtimer.invalidate()
           }
        
    }
    
    func addWedgeView(color: UIColor, angle: Radians) -> SimonWedgeView {
        let wedgeView = SimonWedgeView(frame: self.view.bounds)

        wedgeView.color = color
        wedgeView.centerAngle = angle
      //  self.view.addSubview(wedgeView)
     return wedgeView
    }
    
    func updateCounting(view : UIView){
        rotateLeft(view: view)
    }
    
    func rotateLeft(view: UIView) {
        UIView.animate(withDuration: 1.5, animations: {
            view.transform = CGAffineTransform(rotationAngle: ((180.0 * CGFloat((Double.pi))) / 180.0) * -1)
            view.transform = CGAffineTransform(rotationAngle: ((0.0 * CGFloat((Double.pi))) / 360.0) * -1)
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func update(view: UIView) {
        rotateLeft(view: view)
    }
    
    
    
    
}

extension UIBezierPath {

    typealias Radians = CGFloat

    
    static func simonWedge(innerRadius: CGFloat, outerRadius: CGFloat, centerAngle: Radians, gap: CGFloat) -> UIBezierPath {
        let innerAngle: Radians = CGFloat.pi / 2 - gap / (2 * innerRadius)
        let outerAngle: Radians = CGFloat.pi / 2 - gap / (2 * outerRadius)
        let path = UIBezierPath()
        path.addArc(withCenter: .zero, radius: innerRadius, startAngle: centerAngle - innerAngle, endAngle: centerAngle + innerAngle, clockwise: true)
        path.addArc(withCenter: .zero, radius: outerRadius, startAngle: centerAngle - innerAngle, endAngle: centerAngle + innerAngle, clockwise: true)
        path.close()
        return path
    }

}

class SimonWedgeView: UIView {
    
    typealias Radians = CGFloat

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }

    var centerAngle: Radians = 0 { didSet { setNeedsDisplay() } }
    var color: UIColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) { didSet { setNeedsDisplay() } }

    override func draw(_ rect: CGRect) {
        let path = wedgePath()
        color.setFill()
        path.fill()
    }

    private func commonInit() {
        contentMode = .redraw
        backgroundColor = .clear
        isOpaque = false
    }

    private func wedgePath() -> UIBezierPath {
       let bounds = self.bounds
         let outerRadius = min(bounds.size.width, bounds.size.height) / 2
         let innerRadius = outerRadius / 2
         let gap = (outerRadius - innerRadius) / 2
         let path = UIBezierPath.simonWedge(innerRadius: innerRadius, outerRadius: outerRadius, centerAngle: centerAngle, gap: gap)
         path.apply(CGAffineTransform(translationX: bounds.midX, y: bounds.midY))
         return path
          
     }
}


