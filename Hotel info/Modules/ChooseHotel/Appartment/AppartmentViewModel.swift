//
//  AppartmentViewModel.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 04.09.2023.
//

final class AppartmentViewModel {
    var responseModel: Box<ResponseAppartmentModel?> = Box(nil)
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func viewDidLoad() {
        fetchModel()
    }
}

private extension AppartmentViewModel {
    func fetchModel() {
        Task(priority: .utility) {
            do {
                let response = try await apiService.fetchAppartmentInfo()
                await MainActor.run(body: {
                    responseModel.value = response
                })
            } catch {
                
            }
        }
    }
}

