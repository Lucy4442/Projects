//
//  Searchable.swift
//  LongPressGesture
//
//  Created by mac on 09/04/24.
//

import SwiftUI
import Combine
import AVFoundation

struct Resturant : Identifiable,Hashable {
    let id : String
    let title : String
    let cuisine : CuisineOption
    
}

enum CuisineOption : String {
    case american,italian,japanese
}

final class ResturantManager {
    func getAllResturant() async throws -> [Resturant] {
        [
            Resturant(id: "1", title: "Burger Shack", cuisine: .american),
            Resturant(id: "2", title: "Pasta Palace", cuisine: .italian),
            Resturant(id: "3", title: "Sushi Heaven", cuisine: .japanese),
            Resturant(id: "4", title: "Local Market", cuisine: .american)
        ]
    }
}


@MainActor
final class SearchableViewModel : ObservableObject {
    @Published private(set) var allResturants : [Resturant] = []
    @Published private(set) var filterResturants : [Resturant] = []
    @Published var searchText : String = ""
    @Published var searchScope : SearchScopeOption = .all
    @Published private(set) var allSearchScope : [SearchScopeOption] = []
    
    
    var cancellables = Set<AnyCancellable>()
    
    var isSearching : Bool {
        !searchText.isEmpty
    }
    
    var showSearchSuggestion : Bool {
        searchText.count < 3
    }
    
    enum SearchScopeOption : Hashable{
        case all
        case cuisine(option : CuisineOption)
        
        var title : String {
            switch self {
            case .all:
                return "All"
            case .cuisine(let option):
                return option.rawValue.capitalized
            }
        }
    }
    
    let manager = ResturantManager()
    
    init() {
        addSubscribers()
    }
    
    func loadResturants() async {
        
        do {
            allResturants =  try await manager.getAllResturant()
            
            let allCuisines = Set(allResturants.map{ $0.cuisine })
            allSearchScope = [.all] + allCuisines.map{ SearchScopeOption.cuisine(option: $0) }
            
        } catch {
            print(error)
        }
        
    }
    
    func getSearchSuggestions() -> [String] {
        guard showSearchSuggestion else {
            return []
        }
        
        var suggestions : [String] = []
        
        let search = searchText.lowercased()
        if search.contains("pa") {
            suggestions.append("Pasta")
        }
        if search.contains("su") {
            suggestions.append("Sushi")
        }
        if search.contains("bu") {
            suggestions.append("Burger")
        }
        suggestions.append("Market")
        suggestions.append("grocery")
        
        return suggestions
    }
    
    func addSubscribers(){
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main, options: nil)
            .sink {[weak self] (searchText,searchScope) in
                self?.filterResturants(searchText: searchText,currentsearchScope : searchScope)
            }
            .store(in: &cancellables)
    }
    
    func filterResturants(searchText : String,currentsearchScope : SearchScopeOption) {
        guard !searchText.isEmpty else {
            filterResturants = []
            searchScope = .all
            return
        }
        
        //filter on search scope
        var resturantScope = allResturants
        switch currentsearchScope {
        case .all:
            break
        case .cuisine(let option):
            resturantScope = allResturants.filter{ $0.cuisine == option }
        }
        
        //filter on search text
        let search = searchText.lowercased()
        
        filterResturants = allResturants.filter({ resturant in
            let titleContainSearch = resturant.title.lowercased().contains(search)
            let cuisineContainSearch = resturant.cuisine.rawValue.lowercased().contains(search)
            return titleContainSearch || cuisineContainSearch
        })
    }
    
}

struct Searchable: View {
    
    @StateObject var viewModel = SearchableViewModel()
    
    var body: some View {
        
        ScrollView{
            VStack(spacing : 20)
            {
                ForEach( viewModel.isSearching ? viewModel.filterResturants : viewModel.allResturants, id: \.self) { resturant in
                    resturantRow(resturant: resturant)
                }
            }
            .padding()
        }
        .searchable(text: $viewModel.searchText,placement: .automatic,prompt: Text("Search Resturants..."),suggestions: {
            ForEach(viewModel.getSearchSuggestions(),id : \.self) { suggestion in
                Text(suggestion)
                    .searchCompletion(suggestion)
            }
        })
//        .searchScopes($viewModel.searchScope,scopes : {
//            ForEach(viewModel.allSearchScope, id : \.self) { scope in
//                Text(scope.title)
//                    .tag(scope)
//            }
//        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Restaurants")
        .task {
            await viewModel.loadResturants()
        }

        
    }
    
    
    
    private func resturantRow(resturant : Resturant) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(resturant.title)
                .font(.headline)
            Text(resturant.cuisine.rawValue.capitalized)
                .font(.caption)
            
        }
        .padding()
        .frame(maxWidth : .infinity,alignment: .leading)
        .background(Color.black.opacity(0.05))
        
    }
}

struct Searchable_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Searchable()
        }
    }
}
