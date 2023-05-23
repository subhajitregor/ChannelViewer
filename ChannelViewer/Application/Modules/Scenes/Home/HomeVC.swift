//
//  HomeVC.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import UIKit
import SnapKit
import DifferenceKit

protocol HomePresenterToViewProtocol: AnyObject {
    func reloadData<C>(with stagedChangeset: StagedChangeset<C>, completion: @escaping (C) -> Void)
    func showEmptyView()
    func showErrorStateView()
    func showChannelsAndPrograms()
    func showLoader()
    func hideLoader()
}

final class HomeVC: BaseViewController {
    
    // MARK: - Constants -
    enum Constants {
        enum HomeCollectionView {
            static let topInset: CGFloat = 16
        }
    }
    // MARK: - Views -
    
    private lazy var programCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    // MARK: - Properties -
    private var didSetupConstraints = false
    
    var presenter: HomeViewToPresenterProtocol?

    // MARK: - Lifecycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        setupViews()
        setUpCollectionView()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            programCollectionView.snp.makeConstraints { make in
                make.leading.trailing.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}

// MARK: - Private Methods -
private extension HomeVC {
    func setupViews() {
        view.backgroundColor = UIColor(named: "Background")?.withAlphaComponent(0.5)
        
        self.view.addSubview(programCollectionView)
        
        self.view.setNeedsUpdateConstraints()
    }
    
    func setUpCollectionView() {
        programCollectionView.dataSource = self
        programCollectionView.delegate = self
        
        programCollectionView.register(classes: [
            ProgramCVCellModel.self,
            ChannelCVCellModel.self
        ])
    }
}

// MARK: - HomePresenterToViewProtocol -
extension HomeVC: HomePresenterToViewProtocol {
    
    func reloadData<C>(with stagedChangeset: StagedChangeset<C>,  completion: @escaping (C) -> Void) {
        programCollectionView.reload(using: stagedChangeset, setData: completion)
    }
    
    func showEmptyView() {
        programCollectionView.reloadData()
    }
    
    func showErrorStateView() {
        
    }
    
    func showChannelsAndPrograms() {
        
    }
    
    func showLoader() {
        self.showLoadingIndicator()
    }
    
    func hideLoader() {
        self.hideLoadingIndicator()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = presenter?.item(at: indexPath) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(with: model, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 300, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
