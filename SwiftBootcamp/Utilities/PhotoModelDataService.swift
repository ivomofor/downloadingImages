//
//  PhotoModelDataService.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/08/23.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    @Published var photoModel: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryCompactMap(handleOutPut)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("Error downloading data: ---> \(error)")
                    break
                case .finished:
                    print("Success: ---> \(completion)")
                    break
                }
            } receiveValue: { [weak self] (data) in
                self?.photoModel = data
            }
            .store(in: &cancellables)

    }
    
    private func handleOutPut(outPut: URLSession.DataTaskPublisher.Output) throws -> Data? {
        guard let res = outPut.response as? HTTPURLResponse,
              res.statusCode >= 200 && res.statusCode <= 300
        else {
            throw URLError(.badServerResponse)
        }
        return outPut.data
    }
}
