//
//  AccessibilityVoiceOverBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 6/23/24.
//

import SwiftUI

struct AccessibilityVoiceOverBootcamp: View {
    
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Volume", isOn: $isActive)
                    
                    HStack {
                        Text("Volume")
                        Spacer()
                        Text(isActive ? "On" : "Off")
                            .accessibilityHidden(true)
                    }
                    .background()
                    .onTapGesture {
                        isActive.toggle()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(isActive ? "is on" : "is off")
                    .accessibilityHint("Double tap to toggle setting.")
                } header: {
                    Text("Preferences")
                }
                
                Section {
                    Button("Favourites") {
                        
                    }
                    .accessibilityRemoveTraits(.isButton)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .accessibilityLabel("Favourites")
                    
                    Text("Favourites")
                        .accessibilityAddTraits(.isButton)
                        .onTapGesture {
                            
                        }
                } header: {
                    Text("Application")
                }
                
                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .accessibilityAddTraits(.isHeader)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) { index in
                                VStack {
                                    Image("swift")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: 100, maxHeight: 100)
                                        .clipShape(.rect(cornerRadius: 10))
                                    
                                    Text("Item \(index)")
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Item \(index)")
                                .accessibilityAddTraits(.isButton)
                                .accessibilityHint("Double tap to open.")
                                .onTapGesture {
                                    
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Voice Over")
        }
    }
}

#Preview {
    AccessibilityVoiceOverBootcamp()
}
