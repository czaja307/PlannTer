import SwiftUI
import SwiftData
import PhotosUI

struct PlantEditView: View {
    @Environment(\.modelContext) private var context
    @Bindable var plant: PlantModel
    @State private var createdPlant: PlantModel
    @Query var roomList: [RoomModel]
    
    @State private var rooms: [String] = []
    @State private var selectedRoom: String
    @State private var types: [String] = ["None"]
    @State private var subtypes: [String] = ["None"]
    
    @FocusState private var isActive: Bool
    @State private var savingEmpty: Bool = false
    @State private var uiImg: UIImage? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    init(plant: PlantModel) {
        self.plant = plant
        self.createdPlant = PlantModel(plant: plant)
        self.selectedRoom = plant.room.name
        
    }
    
    
    var body: some View {
        ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    isActive = false
                }
            VStack {
                TopEditSection(
                    plant: $createdPlant,
                    roomList: roomList,
                    rooms: $rooms,
                    selectedRoom: $selectedRoom,
                    types: $types,
                    selectedType: Binding(
                        get: { createdPlant.category ?? "None" },
                        set: { createdPlant.category = $0 }
                    ),
                    subtypes: $subtypes,
                    selectedSubType: Binding(
                        get: { createdPlant.species ?? "None" },
                        set: { createdPlant.species = $0 }
                    ),
                    uiImg: $uiImg
                )
                
                TextInput(title: "Name your plant", prompt: "Edytka", inputText: $createdPlant.name, isActive: $isActive)
                    .frame(width: 0.9 * UIScreen.main.bounds.width)
                    .onChange(of: createdPlant.name) {
                        savingEmpty = createdPlant.name == ""
                    }
                if(savingEmpty) {
                    Text("You must give your plant a name that is not empty")
                        .padding(.horizontal, 30)
                        .font(.note)
                        .foregroundColor(Color.red)
                }
                SliderSection(
                    value: Binding(
                        get: { createdPlant.wateringFreq ?? 7 },
                        set: { createdPlant.wateringFreq = $0 }
                    ), title: "Watering interval", unit: "days", range: 1...30, step: 1, sColor: .green
                )
                SliderSection(
                    value: Binding(
                        get: { createdPlant.waterAmountInML ?? 220 },
                        set: { createdPlant.waterAmountInML = $0 }
                    ), title: "Water amount", unit: "ml", range: 50...1000, step: 50, sColor: .blue
                )
                SliderSection(
                    value: Binding(
                        get: { createdPlant.dailySunExposure ?? 3 },
                        set: { createdPlant.dailySunExposure = $0 }
                    ), title: "Sun exposure", unit: "h", range: 0...12, step: 1, sColor: .yellow
                )
                SliderSection(
                    value: Binding(
                        get: { createdPlant.conditioningFreq ?? 0 },
                        set: { createdPlant.conditioningFreq = $0 }
                    ), title: "Conditioning interval", unit: "days", range: 0...90, step: 1, sColor: .pink
                )
                Spacer()
                HStack{
                    Spacer()
                    MiniButton(title: "Reset", action: resetPlant)
                    Spacer()
                    MiniButton(title: "Save", action: savePlant)
                    Spacer()
                }
                .frame(width: 0.9 * UIScreen.main.bounds.width)
            }
        }
        .onAppear {
            if let imageUrl = createdPlant.imageUrl, imageUrl != "ExamplePlant" {
                uiImg = LocalFileManager.instance.getImage(name: createdPlant.imageUrl!)
            }
        }
        .navigationBarBackButtonHidden(true)
        .customToolbar(title: "Edit plant", presentationMode: presentationMode)
    }
    
    private func resetPlant() {
        createdPlant = PlantModel(plant: plant)
        selectedRoom = plant.room.name
        uiImg = LocalFileManager.instance.getImage(name: createdPlant.imageUrl!)
    }
    
    private func savePlant() {
        if(savingEmpty){
            return
        }
        let foundRoom = RoomModel.getRoom(name: selectedRoom, fromRooms: roomList)
        if (foundRoom != nil) {
            plant.room = foundRoom!
        }else {
            print("kurwa hij") //kluczowe do poprawnego dzialania aplikacji
        }
        if (plant.imageUrl != nil && plant.imageUrl != "ExamplePlant" && plant.imageUrl !=  "\(selectedRoom)_\(createdPlant.name)") {
            LocalFileManager.instance.deleteImage(name: plant.imageUrl!)
        }
        plant.name = createdPlant.name
        plant.wateringFreq = createdPlant.wateringFreq
        plant.waterAmountInML = createdPlant.waterAmountInML
        plant.dailySunExposure = createdPlant.dailySunExposure
        plant.conditioningFreq = createdPlant.conditioningFreq
        plant.category = createdPlant.category
        plant.species = createdPlant.species
        if (uiImg != nil) {
            print("Saving img")
            let fileName = "\(selectedRoom)_\(createdPlant.name)"
            LocalFileManager.instance.saveImage(image: uiImg!, name: fileName)
            plant.imageUrl = fileName
        } else {
            plant.imageUrl = "ExamplePlant"
        }
        context.insert(plant)
        do {
            try context.save()
        } catch {
            print("Failed to save plant: \(error)")
        }
        
        
        dispatchNotification(identifier: plant.id.description, title: plant.name + " is thirsty!", body: "Your plant needs to drink some water.", date: plant.nextWateringDate)
        
        presentationMode.wrappedValue.dismiss()
    }
}


private struct TopEditSection: View {
    @Binding var plant: PlantModel
    var roomList: [RoomModel]
    @Binding var rooms: [String]
    @Binding var selectedRoom: String
    @Binding var types: [String]
    @Binding var selectedType: String
    @Binding var subtypes: [String]
    @Binding var selectedSubType: String
    @State private var isTypeSelected: Bool = false
    @State private var pickedPhoto: PhotosPickerItem? = nil
    @Binding var uiImg: UIImage?
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let downloadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        uiImg = downloadedImage
                    }
                }
            } catch {
                print("Failed to load image from URL: \(error)")
            }
        }
        
    }
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(0.4))
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
                PhotosPicker(
                    selection: $pickedPhoto,
                    matching: .images,
                    photoLibrary: .shared()) {
                        if (uiImg != nil) {
                            Image(uiImage: uiImg!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                        } else {
                            Image(plant.imageUrl!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                        }
                    }
                    .task (id: pickedPhoto) {
                        if let data = try? await pickedPhoto?.loadTransferable(type: Data.self) {
                            uiImg = UIImage(data: data)
                        }
                    }
                    .onChange(of: plant.imageUrl)  { newImageUrl in
                        loadImage(from: newImageUrl)
                        if(uiImg == nil) {
                            pickedPhoto = nil
                        }
                    }
                
            }
            VStack {
                MiniDropdownPicker(selected: $selectedRoom, items: rooms)
                
                MiniDropdownPicker(selected: $selectedType, items: types)
                    .onChange(of: selectedType) {
                        isTypeSelected = selectedType != "None"
                        if(isTypeSelected){
                            plant.category = selectedType
                            PlantService.shared.getUniqueSpeciesForCategory(selectedType) { categories in
                                subtypes = categories
                                subtypes.append("None")
                                selectedSubType = subtypes.last!
                            }
                        }
                        else{
                            selectedSubType = "None"
                        }
                    }
                MiniDropdownPicker(selected: $selectedSubType, items: subtypes)
                    .disabled(!isTypeSelected)
                    .onChange(of: selectedSubType) {
                        if(selectedSubType != "None"){
                            plant.species = selectedSubType
                            PlantService.shared.findPlantId(forCategory: selectedType, species: selectedSubType)
                            { foundId in
                                PlantService.shared.getPlantDetails(for: foundId) { details in
                                    if(details != nil) {
                                        let tempName = plant.name
                                        let cat = plant.category
                                        let sub = plant.species
                                        plant = PlantModel(details: details!, conditioniingFreq: plant.conditioningFreq ?? 0)
                                        plant.name = (tempName != "") ? tempName : plant.name
                                        plant.category =  cat
                                        plant.species = sub
                                    }
                                }
                            }
                        }
                    }
            }
            .padding(.leading, 10)
        }
        .padding(.horizontal, 40)
        .onAppear {
            rooms = roomList.map { $0.name }
            rooms.removeAll { $0.isEmpty }
            PlantService.shared.getUniqueCategories { categories in
                DispatchQueue.main.async {
                    types.append(contentsOf: categories)
                }
            }
        }
    }
    
}

private struct SliderSection: View {
    @Binding var value: Int
    var title: String
    var unit: String
    var range: ClosedRange<Double>
    var step: Double
    let sColor: Color
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title):")
                Spacer()
                Text("\(value) \(unit)")
            }
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .padding(.top, 20)
            .font(.custom("Roboto", size: 20))
            .foregroundColor(.primaryText)
            
            Slider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int($0) }
                ),
                in: range,
                step: step,
                minimumValueLabel: Text("\(Int(range.lowerBound)) \(unit)"),
                maximumValueLabel: Text("\(Int(range.upperBound)) \(unit)"),
                label: {
                    Text(unit)
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .tint(sColor)
        }
    }
}

private struct MiniDropdownPicker : View {
    @Binding var selected: String
    let items: [String]
    
    var body : some View {
        Menu{
            ForEach(items, id: \.self){ optionVal in
                Button(action: {selected = optionVal}) {
                    Text(optionVal)
                }
            }
        } label: {
            Label(selected, systemImage: "chevron.down")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.additionalBackground)
                .font(.secondaryText)
                .foregroundColor(.white)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 180, height: 30)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(.additionalBackground)
        .cornerRadius(30)
    }
}

private struct MiniButton : View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .font(.buttonText)
                .padding(10)
                .foregroundColor(.secondaryText)
                .background(.additionalBackground)
                .cornerRadius(10)
                .shadow(color: Color(.brown), radius: 3, x: 2, y: 4)
        }
        .frame(width: 160, height: 80)
    }
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: SettingsModel.self, RoomModel.self, PlantModel.self, configurations: config)
//
//
//    PlantEditView(plant: PlantModel.examplePlant)
//            .modelContainer(container)
//}
