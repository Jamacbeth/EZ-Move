//
//  MoveCompleteView.swift
//  ezm
//
//  Created by Jake on 2026-07-31.
//

import SwiftUI

struct MoveCompleteView: View {
    var body: some View {
        VStack(spacing: 20) {

            Text("🎉")
                .font(.system(size: 80))

            Text("You're Ready to Move!")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)

            Text("All rooms packed, supplies gathered, and tasks completed.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 80)
        .background(Color.black.ignoresSafeArea())
    }
}
