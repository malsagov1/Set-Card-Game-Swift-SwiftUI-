//
//  File.swift
//  Memorize
//
//  Created by Umar Malsagov on 05.12.2021.
//

import SwiftUI

struct AnimateStatus: ViewModifier {
    var status: States?
    var wrong: Bool = false
    var selected: Bool = false
    var matched: Bool = false
    init (status: States?) {
        self.status = status
        switch status {
        case .State1: selected = true
        case .State2: wrong = true
        case .State3: matched = true
        case .none:
            return
        }
    }
 
  func body(content: Content) -> some View {

    content
        .modifier(Shake(attempt: wrong ? 1 : 0))
        .animation(wrong ? .easeInOut(duration: 0.3) : nil, value: wrong)
        .rotation3DEffect(Angle(degrees: matched ? 180 : 0), axis: (1,0,0))
        .scaleEffect(selected ? 1.025 : 1)

}
}
    extension View {
        func animateStatus (status: States?) -> some View {
           self.modifier(AnimateStatus (status: status))
            
        }
        
}










struct Shake: GeometryEffect {

    var attempt: Double
    var amount: CGFloat = 10
    var shakesPerUnit = 2
    var animatableData: Double {
        get {
            return attempt
        }
        set {
            attempt = newValue
        }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                amount * sin(CGFloat(animatableData) * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }

}
