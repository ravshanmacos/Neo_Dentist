//
//  Divider.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

enum DividerStyle {
    case defaultLine
    case dashed
}

class Divider: BaseView {
    
    private let circle1 = makeCircle()
    private let circle2 = makeCircle()
    private lazy var dashedLine: UIView = {
        let startPoint = CGPoint(x: 0, y: self.bounds.height/2)
        let endPoint = CGPoint(x: contentWidth() - 30, y: self.bounds.height/2)
        let dashedLine = drawDashLine(startPoint: startPoint, endPoint: endPoint)
        return dashedLine
    }()
    
    private let straightLine: UIView = {
       let view = UIView()
        view.backgroundColor = R.color.gray_light()
        return view
    }()
    
    private let style: DividerStyle
    
    init(frame: CGRect = .zero, style: DividerStyle = .defaultLine) {
        self.style = style
        super.init(frame: frame)
    }
    
    override func setupUI() {
        super.setupUI()
        switch style {
        case .defaultLine:
            addSubview(straightLine)
        case .dashed:
            addSubviews(circle1, circle2, dashedLine)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        switch style {
        case .defaultLine:
            straightLine.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(1)
            }
        case .dashed:
            circle1.snp.makeConstraints { make in
                make.height.width.equalTo(21)
                make.top.bottom.equalToSuperview()
                make.leading.equalToSuperview().offset(-10.5)
            }
            circle2.snp.makeConstraints { make in
                make.height.width.equalTo(21)
                make.trailing.equalToSuperview().offset(10.5)
                make.centerY.equalTo(circle1.snp.centerY)
            }
            
            dashedLine.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.equalTo(1)
                make.leading.equalTo(circle1.snp.trailing).offset(5)
                make.trailing.equalTo(circle2.snp.leading).offset(-5)
            }
        }
    }
}

private extension Divider {
    static func makeCircle() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 10.5
        view.backgroundColor = R.color.blue_dark()
        return view
    }
    
    func drawDashLine(startPoint p0: CGPoint, endPoint p1: CGPoint) -> UIView{
        let view = UIView()
        let dashPath = CGMutablePath()
        dashPath.addLines(between: [p0, p1])
        
        let dashLayer = CAShapeLayer()
        dashLayer.path = dashPath
        dashLayer.strokeColor = R.color.gray_dark()?.cgColor
        dashLayer.lineDashPattern = [3, 6]
        dashLayer.lineWidth = 1
        
        view.layer.addSublayer(dashLayer)
        return view
    }
}
