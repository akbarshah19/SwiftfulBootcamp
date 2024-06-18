//
//  DownloadingImagesBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/17/24.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesVM()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
