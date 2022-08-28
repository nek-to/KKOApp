//
//  Shadow.swift
//  KKOApp
//
//  Created by VironIT on 24.08.22.
//

import UIKit

class ShadowView: UIView {
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var cornerRadius: CGFloat = 5 {
        didSet {
            imageView.layer.cornerRadius = cornerRadius
        }
    }
    
    var shadowColor: UIColor = .darkGray {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    var shadowOpacity: Float = 1 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    var shadowOffset = CGSize(width: 10, height: 10) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    var shadowRadius: CGFloat = 7 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupShadow()
    }
    
    private func setupShadow() {
//        let height = imageView.frame.height
//        let width = imageView.frame.width
//        let shadowSize: CGFloat = 20
//        let contactRect = CGRect(x: -shadowSize, y: height - (shadowSize * 0.4), width: width + shadowSize * 2, height: shadowSize)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
//  
//
//        let shadowOffsetX: CGFloat = 2500
//        let shadowPath = UIBezierPath()
//        shadowPath.move(to: CGPoint(x: 0, y: height))
//        shadowPath.addLine(to: CGPoint(x: width, y: 0))
//        shadowPath.addLine(to: CGPoint(x: width + shadowOffsetX, y: 2000))
//        shadowPath.addLine(to: CGPoint(x: shadowOffsetX, y: 2000))
//        layer.shadowPath = shadowPath.cgPath
        
        // how wide and high the shadow should be, where 1.0 is identical to the view
//        let shadowWidth: CGFloat = 1.25
//        let shadowHeight: CGFloat = 0.5
//
//        let shadowPath = UIBezierPath()
//        shadowPath.move(to: CGPoint(x: shadowRadius / 2, y: height - shadowRadius / 2))
//        shadowPath.addLine(to: CGPoint(x: width - shadowRadius / 2, y: height - shadowRadius / 2))
//        shadowPath.addLine(to: CGPoint(x: width * shadowWidth, y: height + (height * shadowHeight)))
//        shadowPath.addLine(to: CGPoint(x: width * -(shadowWidth - 1), y: height + (height * shadowHeight)))
//        layer.shadowPath = shadowPath.cgPath
//        layer.shadowOffset = .zero
//        layer.shadowOpacity = 0.1
//
//        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        
//        let shadowSize: CGFloat = 10
//        let shadowDistance: CGFloat = 40
//        let contactRect = CGRect(x: shadowSize, y: imageView.bounds.height - (shadowSize * 0.4) + shadowDistance, width: imageView.bounds.width - shadowSize * 2, height: shadowSize)
//
//        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
//
//        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
//        layer.shadowPath = cgPath
    }
    
    private func setup() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
    }
}
