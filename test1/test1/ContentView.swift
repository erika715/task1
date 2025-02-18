//
//  ContentView.swift
//  test1
//
//  Created by Эрика Манучарян on 18.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextView(selectedText: $text)
        }
        .padding()
    }
}

struct TextView: UIViewRepresentable {
    @Binding var selectedText: String
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChangeSelection(_ textView: UITextView) {
            if let range = textView.selectedTextRange, let selected = textView.text(in: range) {
                print("Первый символ: \(selected.first.map { String($0) } ?? "")")
                print("Последний символ: \(selected.last.map { String($0) } ?? "")")
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = "Выделите часть этого текста, чтобы увидеть первый и последний символ."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
