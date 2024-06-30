//
//  DownloadingImagesVM.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/17/24.
//

import Foundation
import Combine

class DownloadingImagesVM: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    let dataService = PhotoModelDataService.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] photoModels in
                self?.dataArray = photoModels
            }
            .store(in: &cancellables)
    }
}
