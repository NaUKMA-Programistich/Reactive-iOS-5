import SwiftUI

struct TodoListScreen: View {
    @EnvironmentObject var viewModel: TodoViewModel

    @State var editTodo: Todo = Todo(text: "")
    @State var isEditTodoPresented: Bool = false
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            NavigationView {
                List {
                    ForEach(viewModel.todos) { todo in
                        Text(todo.text)
                            .onTapGesture {self.edit(todo: todo) }
                    }
                    .onDelete(perform: delete)
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: add) {
                            Label("Add Todo", systemImage: "plus")
                        }
                    }
                }
                .refreshable {
                    viewModel.refresh()
                }
            }
            .sheet(isPresented: $isEditTodoPresented) {
                TodoScreen(todo: $editTodo)
            }
        }
    }
    
    private func add() {
        self.editTodo = Todo(text: "")
        self.isEditTodoPresented = true
    }

    private func delete(offsets: IndexSet) {
        viewModel.deleteTodoAction.send(offsets)
    }
    
    private func edit(todo: Todo) {
        self.editTodo = todo
        self.isEditTodoPresented = true
    }
}
