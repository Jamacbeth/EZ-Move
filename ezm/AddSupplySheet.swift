//
//  AddSupplySheet.swift
//  ezm
//
//  Created by Jake on 2026-05-22.
//

import SwiftUI

struct AddSupplySheet: View {
    @EnvironmentObject var suppliesVM: SuppliesViewModel

    let availableSupplies: [SupplyItem] = [
        SupplyItem(name: "Small Box", details: "For books, tools, small items", icon: "📦"),
        SupplyItem(name: "Medium Box", details: "For kitchen items, decor", icon: "📦"),
        SupplyItem(name: "Large Box", details: "For bedding, pillows, toys", icon: "📦"),
        SupplyItem(name: "Tape", details: "Packing tape roll", icon: "🧵"),
        SupplyItem(name: "Bubble Wrap", details: "Protect fragile items", icon: "🎈"),
        SupplyItem(name: "Markers", details: "Label your boxes", icon: "🖊️")
    ]

    var body: some View {
        NavigationView {
            List(availableSupplies) { supply in
                Button {
                    suppliesVM.supplies.append(supply)
                } label: {
                    HStack {
                        Text(supply.icon)
                            .font(.system(size: 22))

                        VStack(alignment: .leading) {
                            Text(supply.name)
                                .font(.system(size: 18))

                            Text(supply.details)
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }

                        Spacer()
                    }
                }
            }
            .navigationTitle("Add Supply")
        }
    }
}
