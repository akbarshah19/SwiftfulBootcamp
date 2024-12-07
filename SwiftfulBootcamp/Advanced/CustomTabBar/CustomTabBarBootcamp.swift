//
//  CustomTabBarBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 11/26/24.
//

import SwiftUI

struct TabBarItem: Hashable {
    let iconName: String
    let title: String
    let color: Color
}

struct CustomTabBarBootcamp: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchTab(tab: tab)
                    }
            }
        }
    }
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.headline)
            
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold))
        }
        .foregroundStyle(tab.color)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(tab.color.opacity(0.2))
        .clipShape(.rect(cornerRadius: 20))
    }
    
    private func switchTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
    }
}

#Preview {
    static let tabs: [TabBarItem] = [
        .init(iconName: "house", title: "Home", color: .red),
        .init(iconName: "heart", title: "Favourites", color: .blue),
        .init(iconName: "person", title: "Profile", color: .green)
    ]
    
    CustomTabBarContainerView(selection: .constant(.init(iconName: "house", title: "Home")) {}
}
