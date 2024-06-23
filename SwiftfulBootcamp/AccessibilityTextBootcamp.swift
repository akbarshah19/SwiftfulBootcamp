//
//  AccessibilityTextBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/18/24.
//

import SwiftUI

struct AccessibilityTextBootcamp: View {
    var body: some View {
        Text("Hello, World!")
    }
}

extension ContentSizeCategory {
    var cusomMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall:
            return 1.0
        case .small:
            return 1.0
        case .medium:
            return 1.0
        case .large:
            return 1.0
        case .extraLarge:
            return 1.0
        case .extraExtraLarge:
            return 1.0
        case .extraExtraExtraLarge:
            return 1.0
        case .accessibilityMedium:
            return 1.0
        case .accessibilityLarge:
            return 1.0
        case .accessibilityExtraLarge:
            return 1.0
        case .accessibilityExtraExtraLarge:
            return 1.0
        case .accessibilityExtraExtraExtraLarge:
            return 1.0
        @unknown default:
            fatalError()
        }
    }
}

#Preview {
    AccessibilityTextBootcamp()
}
