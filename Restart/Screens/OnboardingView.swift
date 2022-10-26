//
//  OnboardingView.swift
//  Restart
//
//  Created by MBAYE Libasse on 25/10/2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    var body: some View {
        
        ZStack {
            
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20){
                
                // MARK: - Header
                
                Spacer()
                
                VStack(spacing: 0){
                    
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                      It's not how much we give but\nhow much love we put into giving.
                      """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
                }//: Header
                .opacity(self.isAnimating ? 1 : 0)
                .offset(y: self.isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: self.isAnimating)
                
                // MARK: - Center
                
                ZStack{
                    
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: self.imageOffset.width * -1)
                        .blur(radius: abs(self.imageOffset.width/5))
                        .animation(.easeOut(duration: 1), value: self.isAnimating)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(self.isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: self.isAnimating)
                        .offset(x: self.imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(self.imageOffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    
                                    if abs(self.imageOffset.width) <= 150{
                                        
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            
                                            self.indicatorOpacity = 0
                                            self.textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    
                                    self.imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        
                                        self.indicatorOpacity = 1
                                        
                                        self.textTitle = "Share."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1), value: self.imageOffset)
                    
                }//: Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(self.isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: self.imageOffset)
                        .opacity(self.indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                
                // MARK: - Footer
                
                ZStack{
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .offset(x: 20)
                    
                    HStack{
                        
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack{
                         
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    
                                    if gesture.translation.width > 0 && buttonOffset <= (buttonWidth - 80){
                                        
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{_ in
                                    
                                    withAnimation(Animation.easeOut(duration: 0.4)){
                                        
                                        if buttonOffset > buttonWidth/2{
                                            
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            self.isOnboardingViewActive = false
                                        }else{
                                            
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        .onTapGesture {
                            
                            self.isOnboardingViewActive = false
                        }
                        
                        Spacer()
                    }
                }//: Footer
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .padding()
                .opacity(self.isAnimating ? 1 : 0)
                .offset(y: self.isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: self.isAnimating)
            }
        }
        .onAppear(perform: {
            
            self.isAnimating = true
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
