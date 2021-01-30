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
    @State private var colour: String = "blue"
    @State private var extendedViewOn: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {withAnimation{ addNoteScreen.toggle() }},
                       label: { Text("Add Note").foregroundColor(.primary) }
                )
                Spacer()
                Button(action: { NSApplication.shared.terminate(self) },
                       label: { Text("Quit").foregroundColor(.primary) }
                )
            }
            if addNoteScreen {
                HStack() {
                    ForEach(0 ..< common.colours.count) { c in
                        colourView(colour: common.colours[c])
                            .onTapGesture {
                                colour = common.colours[c]
                            }
                    }
                }
                Form() {
                    TextField("Note Title", text: $noteTitle)
                    TextField("More Info", text: $noteBody)
                    Button(action: { addNoteItem() },
                           label: { Text("Save").foregroundColor(common.colourDict[colour]) }
                    )
                }
            }
            ScrollView {
                ForEach(fetchedNotes, id: \.self) { note in
                    NoteListView(noteItem: note)
                        .onTapGesture {
                            extendedViewOn.toggle()
                        }
                        .sheet(isPresented: $extendedViewOn) {
                            ExpandedView(note: note)
                        }
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
        newNote.colour = colour
        
        try? moc.save()
        noteTitle = ""
        noteBody = ""
        colour = "blue"
        withAnimation{addNoteScreen.toggle()}
    }
    
}

struct NoteListView: View {
    @Environment(\.managedObjectContext) var moc
    var noteItem: NoteItem
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(common.DateToString(noteItem.timestamp ?? Date()))
                    .font(.system(size: 8, weight: .medium))
                    .foregroundColor(.white)
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
                    .foregroundColor(.white)
            })
        }
        .padding()
        .frame(width: 250, height: 85, alignment: .leading)
        .background(common.colourDict[noteItem.colour ?? "blue"])
        .cornerRadius(17)
    }
    
    func deleteItem(_ item: NoteItem) {
        moc.delete(item)
        
        try? moc.save()
    }
}

struct colourView: View {
    let colour: String
    static var chosenColour = "blue"
    
    var body: some View {
        Circle()
            .strokeBorder(Color.primary,lineWidth: 2.5)
            .background(Circle().foregroundColor(common.colourDict[colour]))
            .frame(width: 30, height: 30)
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
//            NoteListView(noteItem: tNote)
            colourView(colour: "red")
        }
    }
}
