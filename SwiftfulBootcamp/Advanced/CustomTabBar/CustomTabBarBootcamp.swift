//
//  CustomTabBarBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 11/26/24.
//

import SwiftUI

enum TabBarItem: Hashable {
    case home, favroites, profile
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favroites: return "heart"
        case .profile: return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favroites: return "Favourites"
        case .profile: return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .favroites: return Color.blue
        case .profile: return Color.green
        }
    }
}

struct CustomTabBarBootcamp: View {
    
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
                .tabBarItem(.home, selection: $tabSelection)
            
            Color.blue
                .tabBarItem(.favroites, selection: $tabSelection)
            
            Color.green
                .tabBarItem(.profile, selection: $tabSelection)
        }
    }
}

#Preview {
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
    
    @ViewBuilder
    private func tabView(tab: TabBarItem) -> some View {
        var isSelected: Bool {
            return selection == tab
        }
        
        VStack {
            Image(systemName: tab.iconName)
                .font(.headline)
            
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold))
        }
        .foregroundStyle(isSelected ? tab.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(isSelected ? tab.color.opacity(0.2) : .clear)
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
