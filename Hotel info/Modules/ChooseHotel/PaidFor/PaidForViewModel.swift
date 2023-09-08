//
//  PaidForViewModel.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

final class PaidForViewModel {
    var orderNumber: Box<Int> = Box(0)
    
    func viewDidLoad() {
        getOrderNumber()
    }
}

private extension PaidForViewModel {
    func getOrderNumber() {
        orderNumber.value = Int.random(in: 111111...999999)
    }
}

