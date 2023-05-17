//
//  HomeVC.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import UIKit

protocol HomeViewToPresenterProtocol {
    func viewDidLoad()
}

final class HomeVC: UIViewController {
    
    // MARK: - Constants -
    enum Constants {
        enum HomeCollectionView {
            static let topInset: CGFloat = 16
        }
    }
    // MARK: - Views -
    private lazy var channelTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.clipsToBounds = true
        return tableView
    }()
    
    private lazy var programCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = true
        collectionView.dataSource =  self
        return collectionView
    }()
    
    private lazy var tableHeaderDayView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    // MARK: - Properties -
    var presenter: HomeViewToPresenterProtocol?

    // MARK: - Lifecycle Methods -
    
    init(presenter: HomeViewToPresenterProtocol?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

// MARK: - HomePresenterToViewProtocol -
extension HomeVC: HomePresenterToViewProtocol {
    
}

// MARK: - UICollectionViewDataSource -
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
