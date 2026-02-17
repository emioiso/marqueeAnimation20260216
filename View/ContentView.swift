//
//  ContentView.swift
//  marqueeAnimation20260216
//
//  Created by emi oiso on 2026/02/16.
//
//import SwiftUI
//import UIKit
//
//// =====================
//// ContentView（トップ）
//// =====================
//struct ContentView: View {
//
//    // マーキーで流すテキスト（NextViewで追加される）
//    @State private var marqueeText: String = "うに,たまご,カッパまき,えび,🍵"
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 0) {
//
//                // 上の画像
//                GeometryReader { proxy in
//                    let size = proxy.size
//
//                    Image("sushiTaishos")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: size.width, height: size.height)
//                        .clipped()
//                        .cornerRadius(18)
//                }
//                .frame(height: 220)
//
//                // マーキー（1行・省略なし）
//                Marquee(
//                    text: marqueeText,
//                    swiftUIFont: .system(size: 18),
//                    uiFont: UIFont.systemFont(ofSize: 18)
//                )
//                .padding(.vertical, 10)
//
//                // 下の画像
//                Image("sushiSara")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: .infinity)
//                    .cornerRadius(18)
//
//                Spacer()
//
//                // 注文票へ
//                NavigationLink(destination: NextView(marqueeText: $marqueeText)) {
//                    Text("注文票📝")
//                        .font(.headline)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.black)
//                        .foregroundColor(.white)
//                        .cornerRadius(16)
//                }
//                .padding(.top, 16)
//            }
//            .padding()
//            // .navigationTitle("Marquee Text") // 欲しければON
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
//// =====================
//// Marquee（テキスト流し）
//// =====================
//struct Marquee: View {
//
//    let text: String
//    let swiftUIFont: Font
//    let uiFont: UIFont
//
//    @State private var textWidth: CGFloat = 0
//    @State private var offset: CGFloat = 0
//
//    private let speed: CGFloat = 40 // pt/sec
//
//    var body: some View {
//        GeometryReader { geo in
//            let containerWidth = geo.size.width
//
//            ZStack(alignment: .leading) {
//                Text(text)
//                    .font(swiftUIFont)
//                    .lineLimit(1)
//                    .fixedSize(horizontal: true, vertical: false) // ← 省略を出さない
//                    .offset(x: offset)
//                    .onAppear {
//                        resetAndAnimate(containerWidth: containerWidth)
//                    }
//                    .onChange(of: text) { _ in
//                        resetAndAnimate(containerWidth: containerWidth)
//                    }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .clipped()
//        }
//        .frame(height: uiFont.lineHeight + 6)
//    }
//
//    private func resetAndAnimate(containerWidth: CGFloat) {
//        textWidth = measureTextWidth(text: text, font: uiFont)
//        offset = containerWidth
//        animate(containerWidth: containerWidth)
//    }
//
//    private func animate(containerWidth: CGFloat) {
//        let distance = containerWidth + textWidth
//        let duration = Double(distance / speed)
//
//        withAnimation(.linear(duration: duration)) {
//            offset = -textWidth
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//            offset = containerWidth
//            animate(containerWidth: containerWidth)
//        }
//    }
//
//    private func measureTextWidth(text: String, font: UIFont) -> CGFloat {
//        (text as NSString).size(withAttributes: [.font: font]).width
//    }
//}
//
//// =====================
//// NextView（注文票）
//// =====================
//struct NextView: View {
//
//    @Environment(\.dismiss) private var dismiss
//    @Binding var marqueeText: String
//
//    @State private var beerOn = false
//    @State private var salmonOn = false
//    @State private var ebiOn = false
//    @State private var kappaOn = false
//    @State private var puddingOn = false
//    @State private var teaOn = false
//    @State private var gariOn = false
//
//    var body: some View {
//        VStack(spacing: 0) {
//
//            // 上：メニュー一覧
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    MenuRow(title: "🍺 ビール", isOn: $beerOn); Divider()
//                    MenuRow(title: "🐟 サーモン", isOn: $salmonOn); Divider()
//                    MenuRow(title: "🍤 えび", isOn: $ebiOn); Divider()
//                    MenuRow(title: "🥒 かっぱ巻き", isOn: $kappaOn); Divider()
//                    MenuRow(title: "🍮 プリン", isOn: $puddingOn); Divider()
//                    MenuRow(title: "🍵 お茶", isOn: $teaOn); Divider()
//                    MenuRow(title: "🥢 ガリ", isOn: $gariOn)
//                }
//                .padding()
//            }
//
//            // 下：固定ボタン
//            Button {
//                applySelectionToMarquee()
//                resetToggles()   // ← 注文後に注文票側をリセット
//                dismiss()
//            } label: {
//                Text("注文する 📝")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.black)
//                    .foregroundColor(.white)
//                    .cornerRadius(16)
//                    .padding(.horizontal)
//                    .padding(.vertical, 12)
//            }
//            .background(Color(UIColor.systemBackground))
//        }
//        .navigationTitle("注文票 🍣")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    private func applySelectionToMarquee() {
//        var add: [String] = []
//        if beerOn { add.append("🍺") }
//        if salmonOn { add.append("🐟サーモン") }
//        if ebiOn { add.append("🍤") }
//        if kappaOn { add.append("🥒かっぱ巻き") }
//        if puddingOn { add.append("🍮") }
//        if teaOn { add.append("🍵") }
//        if gariOn { add.append("🥢ガリ") }
//
//        guard !add.isEmpty else { return }
//
//        // 文末に追加（重複は追加しない）
//        for item in add {
//            if !marqueeText.contains(item) {
//                marqueeText += "," + item
//            }
//        }
//    }
//
//    private func resetToggles() {
//        beerOn = false
//        salmonOn = false
//        ebiOn = false
//        kappaOn = false
//        puddingOn = false
//        teaOn = false
//        gariOn = false
//    }
//}
//
//// 行コンポーネント
//struct MenuRow: View {
//    let title: String
//    @Binding var isOn: Bool
//
//    var body: some View {
//        HStack {
//            Text(title)
//                .font(.title3)
//            Spacer()
//            Toggle("", isOn: $isOn)
//                .labelsHidden()
//        }
//        .padding(.vertical, 8)
//    }
//}

//
//  ContentView.swift
//  marqueeAnimation20260216
//
//  Created by emi oiso on 2026/02/16.
//

import SwiftUI
import UIKit

// =====================
// ContentView（トップ）
// =====================
struct ContentView: View {

    // マーキーで流すテキスト（NextViewで追加される）
    @State private var marqueeText: String = "うに,たまご,カッパまき,えび,🍵"

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {

                // 上の画像
                GeometryReader { proxy in
                    let size = proxy.size

                    Image("sushiTaishos")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .cornerRadius(18)
                }
                .frame(height: 220)

                // マーキー（1行・省略なし）
                Marquee(
                    text: marqueeText,
                    swiftUIFont: .system(size: 18),
                    uiFont: UIFont.systemFont(ofSize: 18)
                )
                .padding(.vertical, 10)

                // 下の画像
                Image("sushiSara")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(18)

                Spacer()

                // 注文票へ
                NavigationLink(destination: NextView(marqueeText: $marqueeText)) {
                    Text("注文票📝")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.top, 16)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

// =====================
// Marquee（テキスト流し）
// =====================
struct Marquee: View {

    let text: String
    let swiftUIFont: Font
    let uiFont: UIFont

    @State private var textWidth: CGFloat = 0
    @State private var offset: CGFloat = 0

    private let speed: CGFloat = 40 // pt/sec

    var body: some View {
        GeometryReader { geo in
            let containerWidth = geo.size.width

            Text(text)
                .font(swiftUIFont)
                .lineLimit(1)
//                .truncationMode(.clip)                 // ✅ …を出さない
                .fixedSize(horizontal: true, vertical: false) // ✅ 本来の横幅で描画
                .offset(x: offset)
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()
                .onAppear {
                    start(containerWidth: containerWidth)
                }
                .onChange(of: text) { _ in
                    start(containerWidth: containerWidth)
                }
                .id(text) // ✅ テキストが変わったら確実にアニメをリスタート
        }
        .frame(height: uiFont.lineHeight + 6)
    }

    private func start(containerWidth: CGFloat) {
        // ✅ テキスト幅を計測
        textWidth = (text as NSString).size(withAttributes: [.font: uiFont]).width

        // ✅ 右からスタート
        offset = containerWidth

        let distance = containerWidth + textWidth
        let duration = Double(distance / speed)

        // ✅ タイマー無限ループをやめて repeatForever にする（安定）
        withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
            offset = -textWidth
        }
    }
}

// =====================
// NextView（注文票）
// =====================
struct NextView: View {

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

            // 上：メニュー一覧
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

            // 下：固定ボタン
            Button {
                applySelectionToMarquee()
                resetToggles()   // ✅ 注文後に注文票側をリセット
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

        // 文末に追加（重複は追加しない）
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

// 行コンポーネント
struct MenuRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.vertical, 8)
    }
}
