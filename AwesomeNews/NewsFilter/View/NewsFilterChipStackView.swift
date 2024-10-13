//
//  NewsFilterChipStackView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import SwiftUI

struct NewsFilterChipStackView: View {
    let openFilterSheet: () -> Void
    let resetFilter: (NewsFilterKeyType) -> Void
    let filterState: NewsFilter

    var filterSheetIcon: Image {
        Image(systemName: "slider.horizontal.3")
    }

    var resetFilterIcon: Image {
        Image(systemName: "xmark")
    }

    var body: some View {
        HStack {
            FilterChipView(icon: filterSheetIcon) { openFilterSheet() }
            ForEach(filterState.getActiveFiltersDescription()) { filter in
                FilterChipView(icon: resetFilterIcon, descrition: filter.value.capitalized) { resetFilter(filter.keyType) }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

#Preview {
    NewsFilterChipStackView(
        openFilterSheet: { print("openFilter") },
        resetFilter: { _ in print("resetFilter") },
        filterState: .init(
            country: .unitedStates,
            category: .technology,
            keyword: "Example"
        )
    )
}
