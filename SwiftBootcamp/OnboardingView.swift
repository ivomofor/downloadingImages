//
//  OnboardingView.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/01/17.
//

import SwiftUI

struct OnboardingView: View {
    // Onboarding State
    /*
     0 - Welcome Screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @State var onboardingSate: Int = 0
    @State var name: String = ""
    @State var age: Double = 50
    @State var gender: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var  currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false

    
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        ZStack {
            ZStack {
                switch onboardingSate {
                case 0:
                    WelcomeSection
                        .transition(transition)
                case 1:
                    AddNameSection
                        .transition(transition)
                case 2:
                    AddAgeSection
                        .transition(transition)
                case 3:
                    AddGenderSection
                        .transition(transition)
                default:
                    Text("...")
                }
            }
            VStack{
                Spacer()
                buttomButton
            }
            .padding(30)
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().background(Color.purple)
    }
}

// MARK: COMPONENT
extension OnboardingView {
    private var buttomButton: some View {
        Text(onboardingSate == 0 ? "SING UP" : onboardingSate == 3 ? "FINISH" : "NEXT")
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white.cornerRadius(10))
            .animation(nil)
            .onTapGesture {
                handleNextButtonPress()
            }
        }
    private var WelcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            Text("Find your match")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .foregroundColor(.white)
                        .offset(y: 5), alignment: .bottom
                )
            Text("ind your your matchindmatchind your matchind your matchind your matchind your matchind  matchind your matchind your matchind your match")
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var AddNameSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What is your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            TextField("Enter your name", text: $name)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.white.cornerRadius(10))
            Spacer()
            Spacer()
        }
        .padding(30)
    }

    private var AddAgeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What is your Age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text("\(String(format: "%.0f", age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Slider(value: $age, in: 18...100, step: 1)
                .accentColor(.white)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    private var AddGenderSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What is your gender")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Picker(selection: $gender,
                   label: Text(gender.count > 1 ? gender : "Select a gender")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.cornerRadius(10))
                   , content: {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("None").tag("Non e")
            }).pickerStyle(MenuPickerStyle())
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    

}

// MARK: FUNCTIONS
extension OnboardingView {
    func handleNextButtonPress(){
        
        switch onboardingSate {
        case 1:
            guard name.count >= 3 else {
                showAnAlert(title: "Your name must be at least 3 characters long! 😩")
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAnAlert(title: "Plase select a gender 😳")
                return
            }
        default:
            break
        }
        
        if onboardingSate == 3 {
            signIn()
        } else {
            withAnimation(.spring()){
                onboardingSate += 1
            }
        }
    }
    private func signIn(){
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        currentUserSignedIn = true
    }
    private func showAnAlert(title: String) -> Void {
        alertTitle = title
        showAlert.toggle()
    }
}
