//
//  SkintonePicker.swift
//  Emery
//
//  Created by Daniel Eden on 06/03/2021.
//

import SwiftUI

let DEFAULT_COLOR = UIColor.systemGray4.cgColor
fileprivate let SWATCH_SIZE: CGFloat = 60.0

struct SkintonePicker: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selection: CGColor
    
    var rows: [GridItem] = [
        GridItem(.fixed(SWATCH_SIZE), spacing: 4),
        GridItem(.fixed(SWATCH_SIZE), spacing: 4),
        GridItem(.fixed(SWATCH_SIZE), spacing: 4),
        GridItem(.fixed(SWATCH_SIZE), spacing: 4),
        GridItem(.fixed(SWATCH_SIZE), spacing: 4),
    ]
    
    var body: some View {
        LazyVGrid(
            columns: rows,
            alignment: .center,
            spacing: 4
        ) {
            ForEach(Array(skintones), id: \.self) { swatch in
                SkintoneSwatch(color: swatch, isSelected: selection == swatch)
                    .onTapGesture {
                        self.selection = swatch
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            
            SkintoneSwatch(isSelected: selection == DEFAULT_COLOR)
                .onTapGesture {
                    self.selection = DEFAULT_COLOR
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

struct SkintoneSwatch: View {
    var color: CGColor = DEFAULT_COLOR
    var isSelected: Bool = false
    var body: some View {
        Color(color)
            .frame(width: SWATCH_SIZE, height: SWATCH_SIZE)
            .cornerRadius(2)
            .overlay(color == DEFAULT_COLOR
                ? AnyView(Image(systemName: "xmark").font(Font.body.bold()).foregroundColor(Color(UIColor.systemGray.cgColor)))
                : AnyView(EmptyView())
            )
            .overlay(
                isSelected
                ? AnyView(RoundedRectangle(cornerRadius: 4).stroke(Color.accentColor, lineWidth: 4))
                : AnyView(EmptyView())
            )
    }
}
