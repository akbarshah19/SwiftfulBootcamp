//
//  UnitTestingBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 12/13/24.
//

import SwiftUI

class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArrray: [String] = []
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        dataArrray.append(item)
    }
}

struct UnitTestingBootcampView: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcampView(isPremium: false)
}
