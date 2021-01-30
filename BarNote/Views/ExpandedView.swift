//
//  ExpandedView.swift
//  BarNote
//
//  Created by Pradyun Setti on 29/01/21.
//

import SwiftUI

struct ExpandedView: View {
    @Environment(\.presentationMode) var presentationMode
    let note: NoteItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: { self.presentationMode.wrappedValue.dismiss() },
                       label: { Text("Close") }
                )
                    .padding(.leading, 5)
                Spacer()
                Text(common.DateToString(note.timestamp ?? Date(), as: "dd/MM, hh:mm"))
                    .font(.system(size: 10, weight: .medium, design: .default))
            }
            Text(note.title ?? "(no title)")
                .font(.title2)
                .foregroundColor(.white)
                .bold()
                .lineLimit(2)
            Text(note.body ?? "(no description)")
                .font(.body)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 200, height: 250, alignment: .topLeading)
        .background(common.colourDict[note.colour ?? "blue"])
    }
}


