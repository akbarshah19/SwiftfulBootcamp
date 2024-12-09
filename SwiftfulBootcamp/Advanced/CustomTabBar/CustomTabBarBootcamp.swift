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
    
    @State private var tabSelection: TabBarItem = .init(iconName: "house", title: "Home", color: .red)
        
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
                .tabBarItem(.init(iconName: "house", title: "Home", color: .red), selection: $tabSelection)
            
            Color.blue
                .tabBarItem(.init(iconName: "heart", title: "Favorites", color: .blue), selection: $tabSelection)
            
            Color.green
                .tabBarItem(.init(iconName: "person", title: "Profile", color: .green), selection: $tabSelection)
        }
    }
}

#Preview {
    let tabs: [TabBarItem] = [
        .init(iconName: "house", title: "Home", color: .red),
        .init(iconName: "heart", title: "Favourites", color: .blue),
        .init(iconName: "person", title: "Profile", color: .green)
    ]
    
    CustomTabBarBootcamp()
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
        .clipShape(.rect(cornerRadius: 8))
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
                .padding(8)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(_ tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
