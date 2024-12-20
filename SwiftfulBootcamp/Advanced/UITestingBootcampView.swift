//
//  UITestingBootcampView.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 12/15/24.
//

import SwiftUI

class UITestingBootcampViewModel: ObservableObject {
    
    let placeHolder: String = "Add text..."
    @Published var text: String = ""
    @Published var currentUserIsSignedIn: Bool
    
    init(currentUserIsSignedIn: Bool) {
        self.currentUserIsSignedIn = currentUserIsSignedIn
    }
    
    func signUpPressed() {
        guard !text.isEmpty else { return }
        currentUserIsSignedIn = true
    }
}

struct UITestingBootcampView: View {
    
    @StateObject private var vm: UITestingBootcampViewModel
    
    init(currentUserIsSignedIn: Bool) {
        _vm = StateObject(wrappedValue: UITestingBootcampViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if vm.currentUserIsSignedIn {
                SignedInHomeView()
            }
            
            if !vm.currentUserIsSignedIn {
                Content()
                    .transition(.move(edge: .leading))
            }
        }
    }
    
    @ViewBuilder
    private func Content() -> some View {
        VStack {
            TextField(vm.placeHolder, text: $vm.text)
                .padding()
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))
                .accessibilityIdentifier("SignUpTextField")
            
            Button {
                withAnimation(.spring) {
                    vm.signUpPressed()
                }
            } label: {
                Text("Sign Up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
            .accessibilityIdentifier("SignUpButton")
        }
        .padding()
        .font(.headline)
    }
}

struct SignedInHomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Signed In!")
                    .font(.title)
                    .transition(.move(edge: .trailing))
                    .accessibilityIdentifier("SignedInText")
                
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show Alert")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .accessibilityIdentifier("ShowAlertButton")
                
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .accessibilityIdentifier("NavigationLinkToDestination")
            }
            .padding()
            .alert(isPresented: $showAlert, content: {
                return Alert(title: Text("Alert"))
            })
        }
    }
}

#Preview {
    UITestingBootcampView(currentUserIsSignedIn: false)
}
