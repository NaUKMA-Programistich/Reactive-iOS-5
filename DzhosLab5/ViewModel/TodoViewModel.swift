import Combine

import SwiftData
import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var isLoading: Bool = true
    
    let updateTodoAction = PassthroughSubject<Todo, Never>()
    let deleteTodoAction = PassthroughSubject<IndexSet, Never>()
    
    var bag = Set<AnyCancellable>()
    
    private let repository: TodoRepository = .shared
    
    init() {
        defer { isLoading = false }
        todos = repository.getAll()
        
        updateTodoAction
            .sink { [weak self] todo in self?.updateTodo(todo) }
            .store(in: &bag)
        
        deleteTodoAction
            .sink { [weak self] indexSet in self?.deleteTodos(indexSet) }
            .store(in: &bag)
    }
    
    func refresh() {
        isLoading = true
        defer { isLoading = false }

        todos = repository.getAll()
    }
    
    private func deleteTodos(_ indexs: IndexSet) {
        isLoading = true
        defer { isLoading = false }
        
        for index in indexs {
            let todo = todos[index]
            repository.delete(todo)
        }
        
        todos = repository.getAll()
    }
    
    private func updateTodo(_ todo: Todo) {
        isLoading = true
        defer { isLoading = false }
        
        repository.update(todo)
        todos = repository.getAll()
    }
}
