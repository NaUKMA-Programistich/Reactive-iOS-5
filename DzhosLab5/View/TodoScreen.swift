import SwiftUI

struct TodoScreen: View {
    @EnvironmentObject var viewModel: TodoViewModel
    @Binding var todo: Todo
    
    @FocusState private var keyboardFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Action on Todo")
            
            TextField(todo.text, text: $todo.text, prompt: Text("Todo Text"))
                .focused($keyboardFocused)
                .textFieldStyle(.roundedBorder)
                .padding(.top, 16)
            
            HStack {
                Button("Back") { dismiss() }
                Spacer()
                Button("Save") {
                    viewModel.updateTodoAction.send(todo)
                    dismiss()
                }
                .disabled(todo.text.isEmpty)
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .padding(36)
        .onAppear {
            self.keyboardFocused = true
        }
    }
}
