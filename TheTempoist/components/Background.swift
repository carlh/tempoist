//
//  Background.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/2/22.
//

import SwiftUI

struct CurveOne: Shape {
    func path(in rect: CGRect) -> Path {
        let bezier = UIBezierPath()
        bezier.move(to: CGPoint(x: 0, y: rect.height))
        bezier.addLine(to: CGPoint(x: 0, y: rect.height / 2.0))
        bezier.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height / 3), controlPoint: CGPoint(x: rect.width / 2, y: rect.height / 5))
        bezier.addLine(to: CGPoint(x: rect.width, y: rect.height))
        bezier.close()
        return Path(bezier.cgPath)
    }
}

struct CurveTwo: Shape {
    func path(in rect: CGRect) -> Path {
        let bezier = UIBezierPath()
        bezier.move(to: CGPoint(x: 0, y: rect.height))
        bezier.addLine(to: CGPoint(x: 0, y: rect.height / 1.4))
        bezier.addQuadCurve(to: CGPoint(x: rect.width / 1.1, y: rect.height / 1.6), controlPoint: CGPoint(x: rect.width / 2.5, y: rect.height / 4.3))
        bezier.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height / 1.5), controlPoint:
                                CGPoint(x: rect.width / 1.1, y: rect.height / 1.6))
        
        
        bezier.addLine(to: CGPoint(x: rect.width, y: rect.height))
        bezier.close()
        return Path(bezier.cgPath)
    }
}

struct Background: View {
    var body: some View {
        ZStack {
            CurveOne()
                .fill(LinearGradient(colors: [.red.opacity(0.5), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
            CurveTwo()
                .fill(LinearGradient(colors: [.blue.opacity(0.6), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
            .preferredColorScheme(.dark)
        Background()
        
    }
}
