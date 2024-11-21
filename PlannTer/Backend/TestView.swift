//
//  TestView.swift
//  PlannTer
//
//  Created by zawodev on 20/11/2024.
//
import SwiftUI
import Foundation

struct TestView: View {
    @State private var plantService = PlantService()
    
    var body: some View {
        VStack{
            Button("LOAD PLANT LIST"){
                plantService.loadPlantList()
            }
            .padding()
            
            Button("GET PLANT DETAILS"){
                plantService.getPlantDetails(for: 1)
            }
            .padding()
        }
    }
}

#Preview {
    TestView()
}
