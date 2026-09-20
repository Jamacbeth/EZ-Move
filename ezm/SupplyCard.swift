//
//  SupplyCard.swift
//  ezm
//
//  Created by Jake on 2026-05-22.
//

import SwiftUI

struct SupplyCard: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            Text(icon)
                .font(.system(size: 26))
                .frame(width: 48, height: 48)
                .background(Color.blue)
                .cornerRadius(16)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "plus.circle.fill")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(red: 0.09, green: 0.09, blue: 0.11))
        .cornerRadius(18)
    }
}
