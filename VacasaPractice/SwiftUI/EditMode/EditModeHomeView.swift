//
//  EditModeHomeView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 14/03/22.
//

import SwiftUI

struct EditModeHomeView: View {
    @State var items = ["1","2","3","4"]

    @State var isEditing = true
    @State var selectedRows = Set<String>()
    var body: some View {
        List(selection: $selectedRows) {
            ForEach(items, id: \.self) { item in
                EditableRow(title: item)
            }
            .onDelete(perform: delete)
            .onMove(perform: move)
            .listRowBackground(Color.clear)
        }
        .navigationBarItems(leading: Button(action: {
            add()
        }, label: {
            Text("Add")
        }), trailing: Button(action: {
            isEditing.toggle()
        }, label: {
            if self.isEditing {
                Text("Done").foregroundColor(.red)
            } else {
                Text("Edit").foregroundColor(.blue)
            }
        }) ) // Instead of using EditButton(), you can custome the edit button
        .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
        // add animation
        .animation(Animation.spring(), value: isEditing)
        .onAppear {
           selectedRows = ["3","4"]
        }
    }

    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            items.remove(at: first)
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    func add() {
        let newItem = UUID().uuidString
        items.append(newItem)
    }
}

struct EditModeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        EditModeHomeView()
    }
}

struct EditableRow: View {
    let title: String
    var body: some View {
        HStack (spacing: 10) {
            Image(systemName: "plus.circle.fill")
                .frame(width: 20, height: 20)
            Text(title)
            Spacer()
        }
    }
}

/*

 struct ContentView: View {
     struct Ocean: Identifiable, Hashable {
         let name: String
         let id = UUID()
     }
     private var oceans = [
         Ocean(name: "Pacific"),
         Ocean(name: "Atlantic"),
         Ocean(name: "Indian"),
         Ocean(name: "Southern"),
         Ocean(name: "Arctic")
     ]
     @State private var multiSelection = Set<UUID>()

     var body: some View {
         NavigationView {
             List(oceans, selection: $multiSelection) {
                 Text($0.name)
             }
             .navigationTitle("Oceans")
             .environment(\.editMode, .constant(.active))
             .onTapGesture {
                 // This is a walk-around: try how it works without `asyncAfter()`
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                     print(multiSelection)
                 })
             }
         }
         Text("\(multiSelection.count) selections")
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }
 */
