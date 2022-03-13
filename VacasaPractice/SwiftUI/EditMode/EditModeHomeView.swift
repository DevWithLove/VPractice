//
//  EditModeHomeView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 14/03/22.
//

import SwiftUI

struct EditModeHomeView: View {
    @State var items = ["1","2","3","4"]

    @State var isEditing = false
    @State var selectedRows: [String]?

    var body: some View {
        List(selection: $selectedRows) {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
            .onDelete(perform: delete)
            .onMove(perform: move)
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
