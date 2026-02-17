//
//  orderView.swift
//  marqueeAnimation20260216
//
//  Created by emi oiso on 2026/02/17.

import SwiftUI

struct oderView: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var marqueeText: String

    @State private var beerOn = false
    @State private var salmonOn = false
    @State private var ebiOn = false
    @State private var kappaOn = false
    @State private var puddingOn = false
    @State private var teaOn = false
    @State private var gariOn = false

    var body: some View {
        VStack(spacing: 0) {

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    MenuRow(title: "🍺 ビール", isOn: $beerOn); Divider()
                    MenuRow(title: "🐟 サーモン", isOn: $salmonOn); Divider()
                    MenuRow(title: "🍤 えび", isOn: $ebiOn); Divider()
                    MenuRow(title: "🥒 かっぱ巻き", isOn: $kappaOn); Divider()
                    MenuRow(title: "🍮 プリン", isOn: $puddingOn); Divider()
                    MenuRow(title: "🍵 お茶", isOn: $teaOn); Divider()
                    MenuRow(title: "🥢 ガリ", isOn: $gariOn)
                }
                .padding()
            }

            Button {
                applySelectionToMarquee()
                resetToggles()
                dismiss()
            } label: {
                Text("注文する 📝")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
            }
            .background(Color(UIColor.systemBackground))
        }
        .navigationTitle("注文票 🍣")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func applySelectionToMarquee() {
        var add: [String] = []
        if beerOn { add.append("🍺") }
        if salmonOn { add.append("🐟サーモン") }
        if ebiOn { add.append("🍤") }
        if kappaOn { add.append("🥒かっぱ巻き") }
        if puddingOn { add.append("🍮") }
        if teaOn { add.append("🍵") }
        if gariOn { add.append("🥢ガリ") }

        guard !add.isEmpty else { return }

        for item in add {
            if !marqueeText.contains(item) {
                marqueeText += "," + item
            }
        }
    }

    private func resetToggles() {
        beerOn = false
        salmonOn = false
        ebiOn = false
        kappaOn = false
        puddingOn = false
        teaOn = false
        gariOn = false
    }
}

//struct MenuRow: View {
//    let title: String
//    @Binding var isOn: Bool
//
//    var body: some View {
//        HStack {
//            Text(title).font(.title3)
//            Spacer()
//            Toggle("", isOn: $isOn).labelsHidden()
//        }
//        .padding(.vertical, 8)
//    }
//}
