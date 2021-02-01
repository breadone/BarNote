//
//  NoteListView.swift
//  BarNote
//
//  Created by Pradyun Setti on 30/01/21.
//

import SwiftUI

struct NoteListView: View {
    @Environment(\.managedObjectContext) var moc
    var noteItem: NoteItem
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(common.DateToString(noteItem.timestamp ?? Date(), as: "dd/MM, hh:mm"))
                    .font(.system(size: 10, weight: .medium))
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
            .frame(height: 80, alignment: .center)
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

struct NoteLIstView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let tNote = NoteItem(context: moc)
        tNote.title = "title"
        tNote.body = "body"
        tNote.timestamp = Date()
        
        return NoteListView(noteItem: tNote)
    }
}
