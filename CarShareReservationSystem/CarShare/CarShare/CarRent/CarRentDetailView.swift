//
//  CarRentDetailView.swift
//  CarShare
//
//  Created by aicoin on 2021/12/26.
//

import SwiftUI

struct CarRentDetailView: View {
    @ObservedObject var userState: UserStateModel = .shared
    @ObservedObject var model: CarRentViewModel
    @State private var rentDisabled = false
    @State var showAlertScc: Bool = false
    @State private var pickAvailable = true
    @State private var dropAvailable = true
    
    var buttonColor: Color {
        return rentDisabled ? Color.red : Color.green
    }
    
    var body: some View {
        if userState.isLogin {
            Form {
                DatePicker(selection: $model.pickDate, displayedComponents: [.date, .hourAndMinute]) {
                    Text("pick")
                }
                .onReceive(model.validatePickDate) { out in
                    pickAvailable = out
                }
                
                DatePicker(selection: $model.dropDate, displayedComponents: [.date, .hourAndMinute]) {
                    Text("drop")
                }
                .onReceive(model.validateDropDate) { out in
                    dropAvailable = out
                }
                
                Section(header: Text("Select location")) {
                    Picker("locs", selection: $model.pickerAddress) {
                        ForEach(model.locStrs, id: \.self) { loc in
                            Text("\(loc)")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Button(action: {
                    model.rentCar() { success in
                        print(success)
                        self.showAlertScc = success
                    }
                }) {
                    Text("Rent")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(15.0)
                }
                .alert(isPresented: $showAlertScc) {
                    Alert(title: Text("Rent Success!"), message: nil, dismissButton: .cancel())
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .listRowBackground(Color.clear)
                .disabled(rentDisabled)
                .onReceive(model.validatedAll) {
                    self.rentDisabled = !$0
                }
            }
        } else {
            LoginView()
        }
    }
}

struct CarRentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CarRentDetailView(model: CarRentViewModel(selectedCar: Car(carID: 101, make: "ss", model: "ss", pricePerHour: 1, pricePerDay: 1, capacity: 1, picURL: "https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car1.jpg", description: "ss")))
    }
}
