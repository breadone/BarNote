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
    @FetchRequest(entity: NoteItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NoteItem.timestamp, ascending: false)])
    var fetchedNotes: FetchedResults<NoteItem>
    
    @State private var addNoteScreen: Bool = false
    @State private var noteTitle: String = ""
    @State private var noteBody: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {withAnimation{ addNoteScreen.toggle() }},
                       label: { Text("Add Note") }
                )
                Spacer()
                Button(action: {NSApplication.shared.terminate(self) },
                       label: { Text("Quit") }
                )
            }
            if addNoteScreen {
                Form() {
                    TextField("Note Title", text: $noteTitle)
                    TextField("More Info", text: $noteBody)
                    Button(action: { addNoteItem() },
                           label: { Text("Save") }
                    )
                }
            }
            ScrollView {
                ForEach(fetchedNotes, id: \.self) { note in
                    NoteListView(noteItem: note)
                }
            }

        }
        .padding()
    }
    
    private func addNoteItem() {
        let newNote = NoteItem(context: moc)
        newNote.title = noteTitle
        newNote.body = noteBody
        newNote.timestamp = Date()
        
        try? moc.save()
        noteTitle = ""
        noteBody = ""
        withAnimation{addNoteScreen.toggle()}
    }
    
}

struct NoteListView: View {
    @Environment(\.managedObjectContext) var moc
    var noteItem: NoteItem
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(DateToString(noteItem.timestamp ?? Date()))
                    .font(.system(size: 8, weight: .medium))
                Text(noteItem.title ?? "(no title)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
                Text(noteItem.body ?? "(no more info)")
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: {withAnimation{ deleteItem(noteItem) }}, label: {
                Image(systemName: "trash")
                    .renderingMode(.original)
                    .foregroundColor(.white)
            })
            .padding()
        }
        .padding()
        .frame(width: 250, height: 100, alignment: .leading)
        .background(Color.blue)
        .cornerRadius(17)
    }
    
    func deleteItem(_ item: NoteItem) {
        moc.delete(item)
        
        try? moc.save()
    }
    
    private func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM, hh:mm"
        return formatter1.string(from: date)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let tNote = NoteItem(context: moc)
        tNote.title = "title"
        tNote.body = "body"
        tNote.timestamp = Date()
        
        return NavigationView {
            NoteListView(noteItem: tNote)
        }
    }
}
