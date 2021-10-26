import Combine // for Just
import SwiftUI

// See https://stackoverflow.com/questions/58733003/swiftui-how-to-create-textfield-that-only-accepts-numbers/58736068#58736068
/*
struct NumberInput: View {
    @Binding var text: String
    var label: String
    //@Binding var value: Int
    
    init(_ label: String, text: String) {
        self.label = label
        self.text = text
    }

    var body: some View {
        TextField(label, text: $text)
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.text = filtered
                }
        }
    }
}
*/

enum ShirtSize: String, CaseIterable {
    case small
    case medium
    case large
    case extraLarge
}

enum Sport: String, CaseIterable, Equatable {
    case none
    case baseball
    case cycling
    case football
    case golf
    case hockey
    case running
    case swimming
    case tennis
}

struct ContentView: View {
    @State private var bedTime: Date = Date()
    @State private var birthday: Date = Date()
    @State private var favoriteColor: Color = .yellow
    //@State private var favoriteNumber: Int = 0
    @State private var firstName: String = ""
    @State private var dogCount = 0
    @State private var hungry: Bool = false
    @State private var lastName: String = ""
    @State private var rating = 0.0
    @State private var shirtSize: ShirtSize = .large
    @State private var sport: Sport = .none
    
    var isEditing = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    
                    // There is no built-in checkbox view, put one can be created.
                    // A Toggle is typically used in place of a checkbox.
                    Toggle("Hungry?", isOn: $hungry)
                }
                Section(header: Text("Preferences")) {
                    ColorPicker("Favorite Color", selection: $favoriteColor)
                    DatePicker("Bed Time", selection: $bedTime, displayedComponents: .hourAndMinute)
                    //NumberInput("Favorite Number", text: $favoriteNumber)
                    Picker("Shirt Size", selection: $shirtSize) {
                        ForEach(ShirtSize.allCases, id: \.self) { size in
                            Text("\(size.rawValue)").tag(size)
                        }
                    }
                    // Radio buttons are not currently supported in iOS.
                    // In macOS, add the following.
                    //.pickerStyle(RadioGroupPickerStyle())
                    Picker("Favorite Sport", selection: $sport) {
                        ForEach(Sport.allCases, id: \.self) { sport in
                            Text("\(sport.rawValue)").tag(sport)
                        }
                    }
                    HStack {
                        Text("Rating")
                        Slider(value: $rating, in: 0...10, step: 1)
                        //TODO: How can rating be an Int?
                        Text("\(Int(rating))")
                    }
                    HStack {
                        Stepper("# of Dogs", value: $dogCount, in: 0...10)
                        Text(String(dogCount))
                    }
                    Button("Save") {}
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
