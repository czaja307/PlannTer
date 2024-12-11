//
//  TestView.swift
//  PlannTer
//
//  Created by zawodev on 20/11/2024.
//
import SwiftUI
import Foundation

struct TestView: View {
    var body: some View {
        VStack{
            Button("LOAD PLANT LIST"){
                PlantService.shared.loadPlantList { result in
                    let commonNames = result.compactMap { $0.commonName } // wyciąga tylko istniejące commonName
                    print(commonNames)
                    
                    //print(result)
                    //print("\n")
                }
            }
            .padding()
            
            Button("GET PLANT DETAILS 3") {
                PlantService.shared.getPlantDetails(for: 3) { details in
                    print(details)
                }
            }
            .padding()
            
            Button("GET PLANT DETAILS 1212") {
                PlantService.shared.getPlantDetails(for: 1212) { details in
                    print(details)
                }
            }
            .padding()
            
            // Przycisk do pobrania unikalnych kategorii roślin
            Button("GET UNIQUE CATEGORIES") {
                PlantService.shared.getUniqueCategories { categories in
                    print("Categories: \(categories)")
                }
            }
            .padding()

            // Przycisk do pobrania unikalnych gatunków dla danej kategorii
            Button("GET UNIQUE SPECIES FOR CATEGORY 'begonia'") {
                PlantService.shared.getUniqueSpeciesForCategory("begonia") { species in
                    print("Species for 'begonia': \(species)")
                }
            }
            .padding()

            // Przycisk do znalezienia ID rośliny na podstawie kategorii i gatunku
            Button("FIND PLANT ID FOR 'iron cross' AND 'begonia'") {
                PlantService.shared.findPlantId(forCategory: "begonia", species: "iron cross") { plantId in
                    print("Plant ID: \(plantId)")
                }
            }
            .padding()

            
            PlantTile(plant: PlantModel.exampleApiPlant, deleteAction: deleteAction)

        }
    }
    func deleteAction(plant: PlantModel) {
        print("A")
    }
}

#Preview {
    TestView()
}
