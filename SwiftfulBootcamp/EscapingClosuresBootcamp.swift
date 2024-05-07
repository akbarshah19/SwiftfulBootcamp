//
//  EscapingClosures.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/25/24.
//

import SwiftUI

class EscapingClosuresBootcampVM: ObservableObject {
    @Published var text = "Hello"
    
    func getData() {
//        let data = downloadData()
//        DispatchQueue.main.async {
//            self.text = data
//        }
        
        downloadData2 { [weak self] data in
            DispatchQueue.main.async {
                self?.text = data
            }
        }
    }
    
    private func downloadData() -> String {
        return "New Data"
    }
    
    private func downloadData2(completion: @escaping DownloadCompletion){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("New Data")
        }
    }
}

typealias DownloadCompletion = (_ data: String) -> Void

struct EscapingClosuresBootcamp: View {
    
    @StateObject var vm = EscapingClosuresBootcampVM()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .bold()
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingClosuresBootcamp()
}
