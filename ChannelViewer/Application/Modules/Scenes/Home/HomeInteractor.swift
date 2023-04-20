//
//  HomeInteractor.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import Foundation

protocol HomeInteractorToPresenterProtocol: AnyObject {
    
}

final class HomeInteractor {
    weak var presenter: HomeInteractorToPresenterProtocol?
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    
}
