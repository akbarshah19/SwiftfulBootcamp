//
//  TypealiasBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/25/24.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TvModel = MovieModel

//struct TvModel {
//    let title: String
//    let director: String
//    let count: Int
//}

struct TypealiasBootcamp: View {
    
    @State var item: TvModel = .init(title: "Title", director: "Joe", count: 5)
    
    var body: some View {
        VStack(spacing: 16) {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}
