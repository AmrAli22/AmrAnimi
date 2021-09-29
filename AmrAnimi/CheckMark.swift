//
//  CheckMark.swift
//  AmrAnimi
//
//  Created by Amr Ali on 27/09/2021.
//

import UIKit
class CheckmarkView: UIView {
    public private (set) var checked: Bool = true
    public var animationCurve: AnimationCurve = .linear
    public var animationDuration = 1.5
    
    @objc override dynamic class var layerClass: AnyClass {
    get {
            return CAShapeLayer.self
        }
    }
    
    public func animateCheckmarkStrokeEnd(_ show: Bool) {
        guard let layer = layer as? CAShapeLayer else { return }
        let newStrokeEnd: CGFloat = show ? 1.0 : 0.0
        let oldStrokeEnd: CGFloat = show ? 0.0 : 1.0

        let keyPath = "strokeEnd"
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = oldStrokeEnd
        animation.toValue = newStrokeEnd
        animation.duration = animationDuration
        let timingFunction: CAMediaTimingFunction
        if animationCurve == .linear {
            timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        } else {
            timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        animation.timingFunction = timingFunction
        layer.add(animation, forKey: nil)
        DispatchQueue.main.async {
            layer.strokeEnd = newStrokeEnd
        }
        self.checked = show
    }
    
    
    public func showCheckmark(_ checked: Bool, animated: Bool) {
        guard let layer = layer as? CAShapeLayer else { return }
        let newStrokeEnd: CGFloat = checked ?  1.0 : 0.0
        
        //---------------------------------------------------------------------
        //This code is only needed if you allow the user to switch animation types
        let oldStrokeEnd: CGFloat = checked ? 0.0 : 1.0

            alpha = 1.0 // For stroke animations, make sure the alpha is set to make the check visible
            layer.strokeEnd = oldStrokeEnd //Start the strokeEnd at its old (opposite) value

        //---------------------------------------------------------------------

        if !animated {
            alpha = newStrokeEnd
            layer.strokeEnd = newStrokeEnd
        } else {
            animateCheckmarkStrokeEnd(checked)
        }
    }
    
    private func checkmarkPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 40, y: bounds.midY))
        path.addLine(to: CGPoint(x: 80, y: bounds.midY + 40))
        path.addLine(to: CGPoint(x: 160, y: bounds.midY - 60))
        return path.cgPath
    }
    
    
    func doInitSetup() {
        guard let layer = layer as? CAShapeLayer,
              bounds.size.height >= 50,
              bounds.size.width >= 50
        else { return }
        layer.lineWidth = 8
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.path = checkmarkPath()
    }

    override required init(frame: CGRect) {
        super.init(frame: frame)
        doInitSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doInitSetup()
    }
    
    
}



extension UIBezierPath {
    func addArrow(start: CGPoint, end: CGPoint, pointerLineLength: CGFloat, arrowAngle: CGFloat) {
        self.move(to: start)
        self.addLine(to: end)

        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))

        self.addLine(to: arrowLine1)
        self.move(to: end)
        self.addLine(to: arrowLine2)
    }
    
}
