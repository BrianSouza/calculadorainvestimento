//
//  TornPaperView.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 08/06/24.
//
import UIKit

class TornPaperCardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        // Configurar bordas arredondadas nas partes superiores
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //layer.borderWidth = 2
        //layer.borderColor = UIColor.black.cgColor
        layer.backgroundColor = UIColor.white.cgColor

        // Adicionar a máscara de elipses
        addEllipseMask()
    }

    private func addEllipseMask() {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds

        let path = UIBezierPath(rect: bounds)

        let ellipseWidth: CGFloat = 20
        let ellipseHeight: CGFloat = 20
        let spaceBetweenEllipses: CGFloat = 10

        var x: CGFloat = bounds.width - ellipseWidth / 2

        while x > 0 {
            let ellipseCenterX = x - ellipseWidth / 2
            let ellipseRect = CGRect(x: ellipseCenterX, y: bounds.height - ellipseHeight, width: ellipseWidth, height: ellipseHeight)
            let ellipsePath = UIBezierPath(ovalIn: ellipseRect)
            path.append(ellipsePath.reversing())
            x -= (ellipseWidth + spaceBetweenEllipses)
        }

        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Atualizar a máscara quando o layout for atualizado
        addEllipseMask()
    }
}
