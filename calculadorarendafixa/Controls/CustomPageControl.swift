//
//  CustomPageControl.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 28/05/24.
//
import UIKit

class CustomPageControl: UIControl {

    // Configuração dos tamanhos para os indicadores
    let selectedIndicatorSize = CGSize(width: 20, height: 8)
    let defaultIndicatorSize = CGSize(width: 40, height: 8)
    var indicatorColor: UIColor = .gray
    var currentPageIndicatorColor: UIColor = .blue
    var dotSpacing: CGFloat = 2.0  // Espaço entre os pontos
    
    var numberOfPages: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard numberOfPages > 0 else { return }
        
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        
        // Calcula a largura total dos pontos mais o espaçamento
        let totalWidth = CGFloat(numberOfPages) * defaultIndicatorSize.width + CGFloat(numberOfPages - 1) * dotSpacing
        let startX = (rect.width - totalWidth) / 2
        let centerY = rect.height / 2
        
        for i in 0..<numberOfPages {
            let size = i == currentPage ? selectedIndicatorSize : defaultIndicatorSize
            let color = i == currentPage ? currentPageIndicatorColor : indicatorColor
            
            let originX = startX + CGFloat(i) * (defaultIndicatorSize.width + dotSpacing)
            let adjustedOriginX = i == currentPage ? originX + (defaultIndicatorSize.width - selectedIndicatorSize.width) / 2 : originX
            
            let dotRect = CGRect(x: adjustedOriginX, y: centerY - size.height / 2, width: size.width, height: size.height)
            let dotPath = UIBezierPath(roundedRect: dotRect, cornerRadius: size.height / 2)
            
            context?.setFillColor(color.cgColor)
            context?.addPath(dotPath.cgPath)
            context?.fillPath()
        }
    }
}
