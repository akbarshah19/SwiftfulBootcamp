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
    @Published var currentUserIsSignedIn: Bool = false
    
    func signUpPressed() {
        guard !text.isEmpty else { return }
        currentUserIsSignedIn = true
    }
}

struct UITestingBootcampView: View {
    
    @StateObject private var vm = UITestingBootcampViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if vm.currentUserIsSignedIn {
                Text("Signed In!")
                    .foregroundStyle(.white)
                    .transition(.move(edge: .trailing))
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
            
            Button {
                withAnimation(.spring) {
                    vm.currentUserIsSignedIn.toggle()
                }
            } label: {
                Text("Sign Up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding()
        .font(.headline)
    }
}

#Preview {
    UITestingBootcampView()
}
