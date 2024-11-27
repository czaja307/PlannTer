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
                plantService.loadPlantList() { result in
                    print(result)
                }
            }
            .padding()
            
            Button("GET PLANT DETAILS") {
                plantService.getPlantDetails(for: 3) { details in
                    print(details)
                }
            }
            .padding()
            
            // Przycisk do pobrania unikalnych kategorii roślin
            Button("GET UNIQUE CATEGORIES") {
                plantService.getUniqueCategories { categories in
                    print("Categories: \(categories)")
                }
            }
            .padding()

            // Przycisk do pobrania unikalnych gatunków dla danej kategorii
            Button("GET UNIQUE SPECIES FOR CATEGORY 'Fir'") {
                plantService.getUniqueSpeciesForCategory("Fir") { species in
                    print("Species for 'Fir': \(species)")
                }
            }
            .padding()

            // Przycisk do znalezienia ID rośliny na podstawie kategorii i gatunku
            Button("FIND PLANT ID FOR 'Fir' AND 'White'") {
                plantService.findPlantId(forCategory: "Fir", species: "White") { plantId in
                    print("Plant ID: \(plantId)")
                }
            }
            .padding()
        }
    }
}

#Preview {
    TestView()
}
