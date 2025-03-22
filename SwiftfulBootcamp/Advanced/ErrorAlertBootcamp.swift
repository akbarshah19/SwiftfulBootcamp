//
//  ErrorAlertBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 3/22/25.
//

import SwiftUI

protocol SwiftulAlert {
    var title: String { get }
    var message: String? { get }
    var buttons: AnyView { get }
}

enum DataError: SwiftulAlert {
    case noData(ok: () -> Void)
    case invalidResponse(ok: () -> Void,
                         cancel: () -> Void)
    
    var title: String {
        switch self {
        case .noData:
            return "No Data"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
    
    var message: String? {
        switch self {
        case .noData:
            return "No Data Message"
        case .invalidResponse:
            return "Invalid Response Message"
        }
    }
    
    var buttons: AnyView {
        AnyView(getButtons)
    }
    
    @ViewBuilder
    var getButtons: some View {
        switch self {
        case .noData(let ok):
            Button("OK") {
                ok()
            }
        case .invalidResponse(let ok, let cancel):
            Button("OK") {
                ok()
            }
            
            Button("Cancel") {
                cancel()
            }
        }
    }
}

extension View {
    func alert<T>(_ alert: Binding<T?>) -> some View where T: SwiftulAlert {
        self
            .alert(
                alert.wrappedValue?.title ?? "Error",
                isPresented: Binding(value: alert),
                actions: { alert.wrappedValue?.buttons },
                message: {Text(alert.wrappedValue?.message ?? "")}
            )
    }
}

struct ErrorAlertBootcamp: View {
    
    @State private var alert: DataError?
    
    var body: some View {
        Button("Show Alert") {
            alert = .noData(ok: {
                //ok
            })
        }
        .alert($alert)
    }
}

#Preview {
    ErrorAlertBootcamp()
}
