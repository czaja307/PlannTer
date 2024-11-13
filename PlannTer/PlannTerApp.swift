//
//  PlannTerApp.swift
//  PlannTer
//
//  Created by Jakub Czajkowski on 24/10/2024.
//

import SwiftUI

@main
struct PlannTerApp: App {
    var body: some Scene {
        WindowGroup {
            //RoomTile(roomName: "osdfijldf", roomWarnings: 3, numPlants: 3, listPosition: 0).preferredColorScheme(.light)
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                PlantTile(plant: PlantModel.examplePlant)
                PlantTile(plant: PlantModel.examplePlant)
                CreatePlantTile()
                //zawodev
                //main scene goes there, reszte trzeba opakowac w ten navigation view zeby ladnie przechodzilo miedzy scenami
            }
        }
    }
}

#Preview {
    ContentView()
}
