//
//  workingView.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/01/10.
//

import SwiftUI

struct workingView: View {
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var  currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text(currentUserName ?? "your name")
            Text("This user is \(currentUserAge ?? 0) years old" )
            Text("Their gender is \(currentUserGender ?? "unknown")")
            Text("SIGN OUT")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.7).cornerRadius(10))
                .foregroundColor(.white)
                .onTapGesture {
                    signOut()
                }
        }
        .font(.title)
        .foregroundColor(.purple)
        .padding()
        .padding(.vertical, 40)
        .background(Color.white.cornerRadius(10))
        .shadow(radius:10 )
    }
    
    private func signOut(){
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring()){
            currentUserSignedIn = false
        }
    }
}

struct workingView_Previews: PreviewProvider {
    static var previews: some View {
        workingView()
    }
}
