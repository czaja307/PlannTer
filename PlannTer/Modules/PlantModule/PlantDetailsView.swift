import SwiftUI

struct PlantDetailsView: View {
    @StateObject private var controller = PlantDetailsController(plant: PlantModel(id: UUID(), name: "Edytka"))
    @State private var date = Date()
    
    
    var body: some View {
        ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                // top bar
                HStack {
                    ScreenTitle(title: controller.plant.name)
                    Image(systemName: "gearshape.fill")
                        .font(.mainText)
                        .foregroundColor(.primaryText)
                        .padding(.trailing, 40)
                }
                // plant image and labels
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(.white .opacity(0.4))
                            .frame(width: 150, height: 150)
                            .cornerRadius(15)
                        Image(.edytka)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 130)
                            .cornerRadius(15)
                    }
                    VStack {
                        //TODO: refactor this
                        Button(action: {}) {
                            Text("Green room")
                                .font(.note)
                                .frame(width: 180, height: 30)
                        }
                        .buttonBorderShape(.capsule)
                        .tint(.additionalBackground)
                        .disabled(true)
                        //------------
                        Button(action: {}) {
                            Text("Rose")
                                .font(.note)
                                .frame(width: 180, height: 30)
                        }
                        .buttonBorderShape(.capsule)
                        .tint(.additionalBackground)
                        //-------------
                        Button(action: {}) {
                            Text("Climbing")
                                .font(.note)
                                .frame(width: 180, height: 30)
                        }
                        .buttonBorderShape(.capsule)
                        .tint(.additionalBackground)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.leading, 10)
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
                
                //next - watering
                HStack {
                    DatePicker(
                        "Next watering:",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .frame(width: 300)
                    Text("32 days")
                }
                .font(.secondaryText)
                .foregroundColor(.primaryText)
                
                Spacer()
            }
        }
    }
}

#Preview {
    PlantDetailsView()
}
