//
//  FilterChipView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 13/10/24.
//

import SwiftUI

struct FilterChipView: View {
    let icon: Image?
    let descrition: String?
    let onTap: () -> Void

    init(
        icon: Image? = nil,
        descrition: String? = nil,
        onTap: @escaping () -> Void
    ) {
        self.icon = icon
        self.descrition = descrition
        self.onTap = onTap
    }

    var iconSize: CGFloat {
        descrition != nil ? 12 : 20
    }

    var body: some View {
        HStack {
            if let icon {
                icon
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            if let descrition {
                Text(descrition)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    FilterChipView(icon: Image(systemName: "slider.horizontal.3"), descrition: "Filter") { print("openFilter") }
}
