//
//  ContentView.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/01/06.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ContentViewVM()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}


