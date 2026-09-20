//
//  BoxCard.swift
//  ezm
//
//  Created by Jake on 2026-06-05.
//

import SwiftUI

struct BoxCard: View {
    let box: BoxItem
    let roomName: String

    var body: some View {
        HStack(spacing: 16) {

            // MARK: - Box Image or Default Icon
            if let img = box.image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(16)
            } else {
                Image(systemName: "shippingbox.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color(red: 0.15, green: 0.15, blue: 0.18))
                    .cornerRadius(16)
            }

            // MARK: - Box Info
            VStack(alignment: .leading, spacing: 4) {
                Text(box.label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                Text(box.isPacked ? "Packed" : "Not Packed")
                    .font(.system(size: 14))
                    .foregroundColor(box.isPacked ? .green : .yellow)
            }

            Spacer()
        }
        .padding()
        .background(Color(red: 0.09, green: 0.09, blue: 0.11))
        .cornerRadius(18)
    }
}
