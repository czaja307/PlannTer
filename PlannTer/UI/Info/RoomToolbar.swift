//
//  RoomToolbar.swift
//  PlannTer
//
//  Created by Anna Sidor on 23/11/2024.
//

import SwiftUI

struct RoomToolbar: ViewModifier {
    let title: String
    let sunHours: Int
    let presentationMode: Binding<PresentationMode>
    @State private var isToolbarExpanded: Bool = false
    
    
    func body(content: Content) -> some View {
        VStack(spacing: 20) {
                    ZStack {
                        // Toolbar background
                        Color.additionalBackground
                            .edgesIgnoringSafeArea(.top)
                        
                        VStack (alignment: .center){
                        
                            HStack {
                                // Leading Button (Back button)
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 0)
                                        .font(.mainText)
                                        .foregroundColor(.secondaryText)
                                }
                                
                                Text(title)
                                    .font(.mainText)
                                    .frame(width: 200)
                                    
                                    .foregroundColor(.secondaryText)
                                    .position(x: (UIScreen.main.bounds.width - 200)/2, y: 20)
                                
                                Spacer()
                            }
                            
                            if(isToolbarExpanded) {
                                HStack {
                                    Image("SunSymbol")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("\(sunHours)h")
                                        .font(.secondaryText)
                                        .foregroundColor(.secondaryText)
                                    RoomBar(progressBarWidth: 230, progressBarHeight: 30, time: 0.6, sunBegin: 0.4, sunEnd: 0.7)
                                        .padding(15)
                                        .cornerRadius(2)
                                }
                            }
                            
                            Button(action: {
                                withAnimation {
                                    isToolbarExpanded.toggle()
                                }
                            }) {
                                Image(systemName: isToolbarExpanded ? "chevron.up" : "chevron.down")
                                    .padding(5)
                                    .font(.mainText)
                                    .foregroundColor(.secondaryText)
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 15)
                    }
                    .frame(maxHeight: isToolbarExpanded ? 190 : 130)
                    .animation(.easeInOut, value: isToolbarExpanded)
                           
                    
                    content
                }
    }
}

struct RoomBar: View {
    
    let progressBarWidth: CGFloat
    let progressBarHeight: CGFloat
    var time: Double
    let sunBegin: CGFloat
    let sunEnd: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.primaryText)
                .frame(width: progressBarWidth * 1.00, height: progressBarHeight)

            Rectangle()
                .fill(Color.primaryBackground)
                .frame(width: progressBarWidth * sunEnd, height: progressBarHeight)
            Rectangle()
                .fill(Color.primaryText)
                .frame(width: progressBarWidth * sunBegin, height: progressBarHeight)
            Rectangle()
                .fill(Color.black)
                .frame(width: 2, height: progressBarHeight)
                .offset(x: CGFloat(time) * progressBarWidth)
        }
        .border(Color.black, width: 1)
        .cornerRadius(2)
    }
    
}

extension View {
    func roomToolbar(title: String, sunHours: Int, presentationMode: Binding<PresentationMode>) -> some View {
        self.modifier(RoomToolbar(title: title, sunHours: sunHours, presentationMode: presentationMode))
    }
}

#Preview{
    @Environment(\.presentationMode) var presentationMode
    VStack {
        
    }.navigationBarBackButtonHidden(true)
        .roomToolbar(title: "title", sunHours: 4, presentationMode: presentationMode)
        .background(Color.primaryBackground)
}
