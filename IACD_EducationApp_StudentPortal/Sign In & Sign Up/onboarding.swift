//
//  onboarding.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by Christopher on 2022/07/19.
//

import SwiftUI

struct OnBoardingStep{
    let image: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep(image: "onboarding 1", title: "First see learning", description: "Everything you need in one place"),
    OnBoardingStep(image: "onboarding 2", title: "Connect with everyone", description: "Connect with your classmates and teachers"),
    OnBoardingStep(image: "onboarding 3", title: "Always facinated learning", description: "Anywhere and anytime")
]

struct onboarding: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var currentStep = 0
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
               
            }
            
            TabView(selection: $currentStep) {
                ForEach(0..<onBoardingSteps.count) {it in
        VStack {
            Image(onBoardingSteps[it].image)
                .resizable()
                .frame(width: 350, height: 350)
            
            Text(onBoardingSteps[it].title)
                .font(.title)
                .bold()
            
            Text(onBoardingSteps[it].description)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 16)
                    }
                .tag(it)
                }
              }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack{
                ForEach(0..<onBoardingSteps.count) {it in
                    if it == currentStep{
                        Rectangle()
                            .frame(width: 20, height: 10)
                            .cornerRadius(10)
                            .foregroundColor(.purple)
                    } else{
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                  }
            }
            .padding(.bottom, 24)
            
            Button(action: {
                if self.currentStep < onBoardingSteps.count - 1 {
                    self.currentStep += 1
                } else {
                    //get started
                }
                
                viewModel.firstTimeSignIn = false;
                
            }){
                Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get started")
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            }
        }
    }


struct onboarding_Previews: PreviewProvider {
    static var previews: some View {
        onboarding().environmentObject(AppViewModel())
    }
}
