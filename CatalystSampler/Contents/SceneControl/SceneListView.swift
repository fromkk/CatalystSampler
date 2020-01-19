//
//  SceneListView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/19.
//  Copyright © 2020 fromKK. All rights reserved.
//

import SwiftUI
import Combine

final class SceneListViewModel: ObservableObject {
    @Published var showDontSupportMultipleWindow: Bool = false
    @Published var items: [String] = []
    init() {
        reloadItems()
    }
    
    private func reloadItems() {
        self.items = UIApplication.shared.connectedScenes.map { $0.session.persistentIdentifier }
    }
    
    func reload(for persistenIdentifier: String) {
        guard let scene = UIApplication.shared.connectedScenes.first(where: { scene in
            return scene.session.persistentIdentifier == persistenIdentifier
        }) else {
            return
        }

        if UIApplication.shared.supportsMultipleScenes {
            UIApplication.shared.requestSceneSessionRefresh(scene.session)
            showDontSupportMultipleWindow = false
        } else {
            showDontSupportMultipleWindow = true
        }
        
    }
    
    func remove(with persistenIdentifier: String) {
        guard let scene = UIApplication.shared.connectedScenes.first(where: { scene in
            return scene.session.persistentIdentifier == persistenIdentifier
        }) else {
            return
        }

        if UIApplication.shared.supportsMultipleScenes {
            UIApplication.shared.requestSceneSessionDestruction(scene.session, options: nil, errorHandler: nil)
            showDontSupportMultipleWindow = false
        } else {
            showDontSupportMultipleWindow = true
        }
    }
}

struct SceneListView: View {
    @ObservedObject var viewModel: SceneListViewModel = .init()
    var body: some View {
        List(viewModel.items) { id in
            Text(id)
                .contextMenu(menuItems: {
                    Button(action: {
                        self.viewModel.reload(for: id)
                    }, label: {
                        Text("Reload")
                    })
                    Button(action: {
                        self.viewModel.remove(with: id)
                    }, label: {
                        Text("Delete")
                    })
                })
        }.alert(isPresented: $viewModel.showDontSupportMultipleWindow) { () -> Alert in
            Alert(title: Text("Error"), message: Text("Don't support multiple window"), dismissButton: Alert.Button.default(Text("OK")))
        }
    }
}
