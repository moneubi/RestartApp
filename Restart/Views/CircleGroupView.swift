//
//  CircleGroupView.swift
//  Restart
//
//  Created by DIFA SGMA on 25/10/2022.
//

import SwiftUI

struct CircleGroupView: View {
    
    // MARK: - Properties
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State private var isAnimating: Bool = false
    
    // MARK: - Body
    var body: some View {
        
        ZStack{
            
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .blur(radius: self.isAnimating ? 0 : 10)
        .opacity(self.isAnimating ? 1 : 0)
        .scaleEffect(self.isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: self.isAnimating)
        .onAppear(perform: {
            
            self.isAnimating = true
        })
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}
