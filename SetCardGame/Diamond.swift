//
//  XSX.swift
//  Memorize
//
//  Created by Умар Мальсагов on 14.11.2021.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to:CGPoint (x: rect.minX, y: rect.midY))
        p.addLine(to:CGPoint (x: rect.midX, y: rect.minY))
        p.addLine(to:CGPoint (x: rect.maxX, y: rect.midY))
        p.addLine(to:CGPoint (x: rect.midX, y: rect.maxY))
        p.addLine(to:CGPoint (x: rect.minX, y: rect.midY))
        return p
    }
}







