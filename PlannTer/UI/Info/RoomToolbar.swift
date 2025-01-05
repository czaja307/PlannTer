//
//  RoomToolbar.swift
//  PlannTer
//
//  Created by Anna Sidor on 23/11/2024.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct RoomToolbar: ViewModifier {
    let title: String
    let sunHours: Int
    let presentationMode: Binding<PresentationMode>
    let room: RoomModel
    @State private var isToolbarExpanded: Bool = false
    
    @State private var sunBegin: Double = 0.3 // Default dawn value (optional fallback)
    @State private var sunEnd: Double = 0.7
    let sunCalculator = SunEventCalculator()
    
    func body(content: Content) -> some View {
        VStack(spacing: 20) {
                    ZStack {
                        // Toolbar background
                        Color.additionalBackground
                            .edgesIgnoringSafeArea(.top)
                        
                        VStack (){
                        
                            HStack {
                                // Leading Button (Back button)
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .padding(.horizontal, 25)
                                        .padding(.vertical, 0)
                                        .font(.mainText)
                                        .foregroundColor(.secondaryText)
                                }
                                Text(title)
                                    .font(.mainText)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.secondaryText)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                NavigationLink(destination: RoomEditView(room: room)) {
                                    Image(systemName: "gearshape.fill")
                                        .padding(.horizontal, 25)
                                        .padding(.vertical, 0)
                                        .font(.mainText)
                                        .foregroundColor(.secondaryText)
                                }
                            }
                            
                            if(isToolbarExpanded) {
                                HStack {
                                    Image("SunSymbol")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                    Text("\(sunHours)h")
                                        .font(.secondaryText)
                                        .foregroundColor(.secondaryText)
                                    RoomBar(progressBarWidth: 230, progressBarHeight: 30, time: Double(Calendar.current.component(.hour, from: Date()))/24, sunBegin: sunBegin, sunEnd: sunEnd)
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
                        .padding(.top, 45)
                        .padding(.bottom, 15)
                    }
                    .frame(maxHeight: isToolbarExpanded ? 290 : 200)
                    .animation(.easeInOut, value: isToolbarExpanded)
                    .cornerRadius(15)
                    
                    content
        }.onAppear{
            fetchSunEvents()
        }
        
    }
    
    func fetchSunEvents() {
           Task {
               if let dawn = await sunCalculator.getDawn(),
                  let dusk = await sunCalculator.getDusk() {
                   DispatchQueue.main.async {
                       sunBegin = dawn
                       sunEnd = dusk
                   }
               }
           }
       }
    
}

class SunEventCalculator {
    private let weatherService = WeatherService()

    func getDusk() async -> Double? {
        do {
            let weather = try await weatherService.weather(for: CLLocation(latitude: 52, longitude: 20))
            if let dusk = weather.dailyForecast.first?.sun.civilDusk {
                let duskHour = Double(Calendar.current.component(.hour, from: dusk)) / 24
                return duskHour
            }
        } catch {
            print("Error fetching weather: \(error)")
        }
        return nil
    }

    func getDawn() async -> Double? {
        do {
            let weather = try await weatherService.weather(for: CLLocation(latitude: 52, longitude: 20))
            if let dawn = weather.dailyForecast.first?.sun.civilDawn {
                let dawnHour = Double(Calendar.current.component(.hour, from: dawn)) / 24
                return dawnHour
            }
        } catch {
            print("Error fetching weather: \(error)")
        }
        return nil
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
                .fill(Color.plantShadow)
                .frame(width: 4, height: progressBarHeight)
                .offset(x: CGFloat(time) * progressBarWidth)
        }
        .border(Color.primaryText, width: 1)
        .cornerRadius(2)
    }
    
}

extension View {
    func roomToolbar(title: String, sunHours: Int, presentationMode: Binding<PresentationMode>, room: RoomModel) -> some View {
        self.modifier(RoomToolbar(title: title, sunHours: sunHours, presentationMode: presentationMode, room: room))
    }
}

#Preview{
    @Environment(\.presentationMode) var presentationMode
    VStack {
        
    }.navigationBarBackButtonHidden(true)
        .roomToolbar(title: "hjbjdd", sunHours: 4, presentationMode: presentationMode, room: RoomModel.exampleRoom)
        .background(Color.primaryBackground)
}
