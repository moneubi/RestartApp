//
//  ContentView.swift
//  Restart
//
//  Created by DIFA SGMA on 25/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        
        if isOnboardingViewActive{
            
            OnboardingView()
        }else{
            
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
