//
//  SuppliesView.swift
//  ezm
//
//  Created by Jake on 2026-05-22.
//

import SwiftUI

struct SuppliesView: View {
    @EnvironmentObject var suppliesVM: SuppliesViewModel
    @State private var showingAddSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack {
                Text("Supplies")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                Spacer()

                Button {
                    showingAddSheet = true
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
            .padding(.top, 20)

            if suppliesVM.supplies.isEmpty {
                Text("No supplies added yet.")
                    .foregroundColor(.gray)
                    .padding(.top, 40)
            } else {
                ForEach(suppliesVM.supplies) { supply in
                    SupplyCard(
                        icon: supply.icon,
                        title: supply.name,
                        subtitle: supply.details
                    )
                }
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .background(Color.black.ignoresSafeArea())
        .sheet(isPresented: $showingAddSheet) {
            AddSupplySheet().environmentObject(suppliesVM)
        }
        .onChange(of: suppliesVM.triggerAddSupplySheet) { newValue in
            if newValue {
                showingAddSheet = true
                suppliesVM.triggerAddSupplySheet = false
            }
        }
    }
}
