//
//  DownloadingImagesRow.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/17/24.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    var model: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
            
            VStack {
                Text(model.title)
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
