//
//  ImageLoadingViewModel.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/08/23.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let manager = PhotoModelCacheManager.instance
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        downloadImage()
    }
    func getImage() {
        guard let savedImage = manager.get(key: imageKey) else {
            downloadImage()
            print("Downloading Images now!")
            return
        }
        image = savedImage
        print("Getting saved image!")
    }
    func downloadImage() {
        print("Downloading images now...")
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self ](_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (image) in
                guard
                    let self = self,
                    let image = image
                else { return }
                self.image = image
                self.manager.save(image: image, imgName: self.imageKey)
            }
            .store(in: &cancellables)
    }
}
