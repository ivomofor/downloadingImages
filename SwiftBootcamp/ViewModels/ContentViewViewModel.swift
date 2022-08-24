//
//  ContentViewViewModel.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/08/23.
//

import Foundation
import Combine

class ContentViewVM: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    let dataService = PhotoModelDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        dataService.$photoModel
            .sink { [weak self] (dataModel) in
                self?.dataArray = dataModel
            }
            .store(in: &cancellables)
    }
}
