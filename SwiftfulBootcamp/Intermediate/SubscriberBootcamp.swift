//
//  SubscriberBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 5/21/24.
//

import SwiftUI
import Combine

class SubscriberBootcampVM: ObservableObject {
    @Published var count = 0
    @Published var text = ""
    @Published var isValid = false
    @Published var showButton = false
    
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupTimer()
        addTextFieldSubscriber()
        addButtonSubscriber() 
    }
    
    func addTextFieldSubscriber() {
        $text
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.isValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.isValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setupTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink{ [weak self] _ in
                
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.count += 1
                
                if strongSelf.count == 10 {
                    for item in strongSelf.cancellables {
                        item.cancel()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $isValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let strongSelf = self else {
                    return
                }
                
                if isValid, count > 10 {
                    strongSelf.showButton = true
                } else {
                    strongSelf.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberBootcampVM()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something", text: $vm.text)
                .padding()
                .background(Color.gray.opacity(0.3))
                .clipShape(.rect(cornerRadius: 10))
            
            Text(vm.isValid.description)
            
            Button {
                //
            } label: {
                Text("Button")
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.blue)
                    .opacity(vm.showButton ? 1 : 0.5)
            }
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

#Preview {
    SubscriberBootcamp()
}
