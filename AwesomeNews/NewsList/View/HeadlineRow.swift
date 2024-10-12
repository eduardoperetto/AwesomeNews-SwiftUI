//
//  HeadlineRow.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import SwiftUI

struct HeadlineRow: View {
    let headline: Headline
    var onAppear: (() -> Void)? = nil
    private let imageSize: CGFloat = 80

    private var imageView: some View {
        Group {
            if let imageURL = headline.urlToImage {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                            .clipped()
                            .cornerRadius(8)
                    case .failure:
                        // Fallback image on failure
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
            }
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            imageView
            VStack(alignment: .leading, spacing: 8) {
                // Title
                Text(headline.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                // Description
                if let description = headline.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                // Source and Date
                HStack {
                    // Source Name
                    Text(headline.source.name)
                        .font(.caption)
                        .foregroundColor(.blue)

                    Spacer()

                    // Publication Date
                    Text(formattedDate(headline.publishedAt))
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
        .onAppear { onAppear?() }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
