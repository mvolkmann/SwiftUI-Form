//import Combine // for Just
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

struct ContentView: View {
    private static let blogUrl = "https://mvolkmann.github.io/blog"
    
    // Typically form data would be tied to ViewModel properties
    // rather than using @State.
    @State private var bedTime: Date = Date()
    @State private var birthday: Date = Date()
    @State private var favoriteColor: Color = .yellow
    //@State private var favoriteNumber: Int = 0
    @State private var firstName = ""
    @State private var dogCount = 0
    @State private var hungry = false
    @State private var lastName = ""
    @State private var motto = "This is my motto."
    @State private var rating = 0.0
    @State private var shirtSize: ShirtSize = .large
    
    var isEditing = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    Toggle("Hungry?", isOn: $hungry)
                }
                Section(header: Text("Preferences")) {
                    // Links work in Simulator, but not in Preview.
                    Link("Blog", destination: URL(string: ContentView.blogUrl)!)
                    VStack {
                        Text("Motto")
                        // It seems TextEditor lineLimit is only enforced on initial render.
                        // It doesn't prevent more lines from being displayed
                        // if the user types more text.
                        TextEditor(text: $motto).lineLimit(2)
                    }
                    ColorPicker("Favorite Color", selection: $favoriteColor)
                    DatePicker("Bed Time", selection: $bedTime, displayedComponents: .hourAndMinute)
                    //NumberInput("Favorite Number", text: $favoriteNumber)
                    Picker("Shirt Size", selection: $shirtSize) {
                        ForEach(ShirtSize.allCases, id: \.self) { size in
                            Text("\(size.rawValue)").tag(size)
                        }
                    }
                    HStack {
                        Text("Rating")
                        //TODO: Why does value have to be Float instead of Int?
                        Slider(value: $rating, in: 0...10, step: 1)
                        Text("\(Int(rating))")
                    }
                    HStack {
                        Stepper("# of Dogs", value: $dogCount, in: 0...10)
                        Text(String(dogCount))
                    }
                    Button("Save") {}
                }
                
                // Common UI components that are not built into SwiftUI include:
                // - checkbox: alternative is Toggle
                // - image picker: must build or using a library
                // - multiple choice: alternative is List
                //   inside NavigationView with EditButton
                // - radio buttons: alternative is Picker
                //   (supported in macOS with Picker and
                //   .pickerStyle(RadioGroupPickerStyle())
                // - toggle buttons: alternative is Picker
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
