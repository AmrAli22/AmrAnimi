//
//  ViewControllerCircile.swift
//  AmrAnimi
//
//  Created by Amr Ali on 15/09/2021.
//

import Foundation
import UIKit

class ViewControllerCircile : UIViewController {
    
    var frame =  CGRect() //CGRect(x: view.center.x  , y: view.center.y , width: 200, height: 200)
    var TopSpinningCircleView = SpinningCircleView() //SpinningCircleView(frame: frame, start: 0.55 , end: 0.95)
    var BottomSpinningCircleView = SpinningCircleView()// SpinningCircleView(frame: frame, start: 0.05 , end: 0.45)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frame = CGRect(origin: CGPoint(x: self.view.bounds.midX - 100 , y: self.view.bounds.midY - 100), size: CGSize(width: 200, height: 200))
     //   self.frame = CGRect(x: view.bounds.midX  , y: view.bounds.midY  , width: 200, height: 200)
        self.TopSpinningCircleView = SpinningCircleView(frame: frame, start: 0.55 , end: 0.95)
        self.BottomSpinningCircleView = SpinningCircleView(frame: frame, start: 0.05 , end: 0.45)
        
        configure()
        configureSpinningCircleView()
        self.view.addSubview(Checkmark_View)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            UIView.animate(withDuration: 1.5) {
                self.Checkmark_View.alpha = 1
                self.TopSpinningCircleView.isHidden = true
                self.BottomSpinningCircleView.isHidden = true
            }
            self.Checkmark_View.showCheckmark(true, animated: true)
        }
    }
    
    lazy var Checkmark_View: CheckmarkView = {
        let hv = CheckmarkView(frame: CGRect(origin: CGPoint(x: self.view.bounds.midX - 100 , y: self.view.bounds.midY - 100), size: CGSize(width: 200, height: 200)))
        hv.backgroundColor = .green
        hv.layer.cornerRadius = 100
        hv.alpha = 0
        return hv
    }()
    
    
    private func configure() {
        view.backgroundColor =  .white
        
       
        
    }
    
    private func configureSpinningCircleView() {
     
    
        TopSpinningCircleView.frame = frame
        BottomSpinningCircleView.frame = frame
        view.addSubview(TopSpinningCircleView)
        view.addSubview(BottomSpinningCircleView)
        
        TopSpinningCircleView.animate()
        BottomSpinningCircleView.animate()
        
        
    }
}
