//
//  ContentView.swift
//  BarNote
//
//  Created by Pradyun Setti on 25/01/21.
//

import SwiftUI
import CoreData
import Foundation

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: NoteItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NoteItem.timestamp, ascending: true)])
    var fetchedNotes: FetchedResults<NoteItem>
    let testnotes = ["test1", "test2", "test3", "test4"]
    
    var body: some View {
        VStack {
            Button(action: {AddNote()}, label: {
                Image(systemName: "plus")
                Text("Add Note")
            })
            ScrollView {
//                ForEach(fetchedNotes, id: \.self) { note in
//                    Text(note.title!)
//
//                }
                ForEach(0 ..< testnotes.count) {
                    Text(testnotes[$0])
                }
            }
        }
        .padding()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
