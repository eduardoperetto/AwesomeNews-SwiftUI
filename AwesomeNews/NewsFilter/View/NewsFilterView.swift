//
//  NewsFilterView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import SwiftUI

struct NewsFilterView: View {
    // MARK: - Properties

    @ObservedObject var viewModel: NewsListViewModel
    @State private var selectedCategory: NewsCategory
    @State private var selectedCountry: NewsCountry
    @State private var searchKeyword: String

    // MARK: - Init

    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        _selectedCategory = State(initialValue: viewModel.filter.category)
        _selectedCountry = State(initialValue: viewModel.filter.country)
        _searchKeyword = State(initialValue: "")
    }

    // MARK: - Views

    var categoryPicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Category")
                .font(.headline)
                .foregroundColor(.primary)
            Picker(selection: $selectedCategory, label: Text("")) {
                ForEach(NewsCategory.allCases, id: \.self) { category in
                    Text(category.rawValue.capitalized).tag(category)
                }
            }
            .pickerStyle(DefaultPickerStyle())
            .padding(.vertical, 5)
        }
        .padding(.horizontal)
    }

    var countryPicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Country")
                .font(.headline)
                .foregroundColor(.primary)
            Picker(selection: $selectedCountry, label: Text("")) {
                ForEach(NewsCountry.allCases, id: \.self) { country in
                    Text(country.rawValue.uppercased()).tag(country)
                }
            }
            .pickerStyle(DefaultPickerStyle())
            .padding(.vertical, 5)
        }
        .padding(.horizontal)
    }

    var keywordInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Keyword")
                .font(.headline)
                .foregroundColor(.primary)
            TextField("Enter keyword", text: $searchKeyword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }

    var resetButton: some View {
        Button(action: resetFilters) {
            Text("Reset")
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1.5)
                )
        }
    }

    var applyButton: some View {
        Button(action: {
            viewModel.applyFilters(category: selectedCategory, country: selectedCountry, keyword: searchKeyword)
        }) {
            Text("Apply")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        categoryPicker
                        countryPicker
                        keywordInput
                    }
                    .padding(.vertical)
                }
                Spacer()

                // Action Buttons
                HStack(spacing: 20) {
                    resetButton

                    applyButton
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .background(Color(.systemBackground))
            .navigationTitle("Filter News")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    viewModel.presentFilterSheet = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                }
            )
        }
    }

    private func resetFilters() {
        withAnimation {
            selectedCategory = .general
            selectedCountry = .unitedStates
            searchKeyword = ""
        }
    }
}

#Preview {
    NewsFilterView(viewModel: NewsListViewModel(service: NewsService.shared))
}
