//
//  SearchableBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 8/2/25.
//

import Combine
import SwiftUI

struct Restaurant: Identifiable {
    var id: String
    var title: String
    var cuisine: RestaurantCuisine
}

enum RestaurantCuisine: String, Hashable {
    case italian, american, japanese
}

final class RestaurantManager {
    func getAllRestaurants() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "Burger Shack", cuisine: .american),
            Restaurant(id: "2", title: "Pasta Palace", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi Heaven", cuisine: .japanese),
            Restaurant(id: "4", title: "Local Market", cuisine: .american)
        ]
    }
}

class SearchableBootcampVM: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchScope: SearchScopeOption = .all
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published private(set) var allRestaurantCuisines: [SearchScopeOption] = []
    @Published private(set) var allSearchScopes: [SearchScopeOption] = []
    
    private let restaurantManager = RestaurantManager()
    private var cancellables = Set<AnyCancellable>()
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    enum SearchScopeOption: Hashable {
        case all
        case cuisine(option: RestaurantCuisine)
        
        var title: String {
            switch self {
            case .all:
                "All"
            case .cuisine(let option):
                option.rawValue.capitalized
            }
        }
    }
    
    init() {
        subscribeToSearchText()
    }
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await restaurantManager.getAllRestaurants()
            let allCuisines = Set(allRestaurants.map { $0.cuisine })
            allSearchScopes = [.all] + allCuisines.map { SearchScopeOption.cuisine(option: $0) }
        } catch {
            print(error)
        }
    }
    
    private func subscribeToSearchText() {
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] text, scope in
                self?.filterRestaurants(searchText: text, searchScope: scope)
            }
            .store(in: &cancellables)
    }
    
    private func filterRestaurants(searchText: String, searchScope: SearchScopeOption) {
        guard !searchText.isEmpty else {
            filteredRestaurants = allRestaurants
            self.searchScope = .all
            return
        }
        
        var restaurantsInScope = allRestaurants
        switch searchScope {
        case .all:
            break
        case .cuisine(let option):
            restaurantsInScope = allRestaurants.filter { restaurant in
                return restaurant.cuisine == option
            }
        }
        
        let search = searchText.lowercased()
        filteredRestaurants = restaurantsInScope.filter { restaurant in
            let titleContainsSearch = restaurant.title.lowercased().contains(search)
            let cuisineContainsSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
            return titleContainsSearch || cuisineContainsSearch
        }
    }
}

struct SearchableBootcamp: View {
    @StateObject private var vm = SearchableBootcampVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vm.filteredRestaurants) { restaurant in
                    restaurantRow(restaurant)
                }
            }
            .padding()
        }
        .navigationTitle("Restaurants")
        .searchable(text: $vm.searchText, prompt: "Search something")
        .searchScopes($vm.searchScope) {
            ForEach(vm.allSearchScopes, id: \.self) { scope in
                Text(scope.title)
                    .tag(scope)
            }
        }
        .searchSuggestions {
            Text("Burger")
                .searchCompletion("Burger")
        }
        .task {
            await vm.loadRestaurants()
        }
    }
    
    private func restaurantRow(_ model: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(model.title)
                .bold()
            Text(model.cuisine.rawValue.uppercased())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        SearchableBootcamp()
    }
}
