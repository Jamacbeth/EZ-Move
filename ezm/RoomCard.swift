//
//  RoomCard.swift
//  ezm
//
//  Created by Jake on 2026-07-31.
//

import SwiftUI

struct RoomCard: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {

            Text(icon)
                .font(.system(size: 22))
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

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(red: 0.09, green: 0.09, blue: 0.11))
        .cornerRadius(18)
    }
}
