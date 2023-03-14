//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by Leon Grimmeisen on 19.03.22.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX+20, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX+20, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX-20, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX-20, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX+20, y: rect.maxY))

        return path
    }
    
}

struct ContentView: View {
    var body: some View {
        Arrow()
            //.stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .fill(.red)
            .frame(width: 200, height: 300)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
