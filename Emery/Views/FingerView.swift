//
//  FingerView.swift
//  Emery
//
//  Created by Daniel Eden on 06/03/2021.
//

import SwiftUI

struct FingerView: View {
    @State var selectedShape: NailShape = .almond
    @State var imagePickerOpen = false
    @State private var chosenImage: UIImage?
    
    @State var scaleFactor: CGFloat = 0.5
    @State var lastScaleFactor: CGFloat = 0.5
    
    @State var offset: CGSize = .init()
    @State var lastOffset: CGSize = .init()
    
    @State private var skintonePickerActive = false
    @State var skintoneColor: CGColor = DEFAULT_COLOR
    
    var body: some View {
        VStack {
            Spacer()
        
            ZStack(alignment: .bottom) {
                Image("finger-shape")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 112)
                    .mask(
                        LinearGradient(
                            gradient: .init(colors: [.black, .clear]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    )
                    .offset(y: 15)
                    .foregroundColor(skintoneColor == DEFAULT_COLOR ? .clear : Color(skintoneColor))
                
                Image("finger-outline")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 112)
                    .mask(
                        LinearGradient(
                            gradient: .init(colors: [.black, .clear]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    )
                    .popover(isPresented: $skintonePickerActive) {
                        SkintonePicker(selection: $skintoneColor).fixedSize()
                    }
                    .opacity(0.2)
            
                NailMask(
                    selectedShape: selectedShape,
                    image: chosenImage,
                    scaleFactor: scaleFactor,
                    offset: offset)
                    .offset(y: -156)
            }.gesture(MagnificationGesture()
                .onChanged {
                    self.scaleFactor = self.lastScaleFactor * $0.magnitude
                }
                .onEnded { _ in
                    self.lastScaleFactor = self.scaleFactor
                }
            ).simultaneousGesture(DragGesture()
                .onChanged { value in
                    self.offset.height = self.lastOffset.height + value.translation.height
                    self.offset.width = self.lastOffset.width + value.translation.width
                }
                .onEnded { _ in
                    self.lastOffset = self.offset
                }
            )
            
            Spacer()
        }.toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Picker(
                    selection: $selectedShape,
                    label:
                        Label("Nail Shape: \(selectedShape.description)", systemImage: "hand.point.up.left")
                            .font(.title)
                    ) {
                    ForEach(NailShape.allCases, id: \.self) { shape in
                        Text(shape.description)
                            .tag(shape)
                    }
                }.pickerStyle(MenuPickerStyle())
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { imagePickerOpen.toggle() }) {
                    Label("Choose Image", systemImage: "photo.on.rectangle.angled")
                        .font(.title)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Button(action: { skintonePickerActive.toggle() }) {
                    Label("Choose Skin Tone", systemImage: "paintpalette")
                        .font(.title)
                }
            }
        }.sheet(isPresented: $imagePickerOpen) {
            ImagePicker(image: $chosenImage)
        }
    }
}

struct FingerView_Previews: PreviewProvider {
    static var previews: some View {
        FingerView()
    }
}
