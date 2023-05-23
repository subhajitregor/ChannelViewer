//
//  ChannelCVCell.swift
//  ChannelViewer
//
//  Created by subhajit halder on 23/05/23.
//

import UIKit

struct ChannelCVCellModel: CellViewModel {
    typealias CellType = ChannelCVCell
    
    var onClick: ((ChannelCVCell) -> Void)?
    let channelId: Int
    let name: String
    
    var differenceIdentifier: String {
        return "\(channelId)"
    }
    
    func setup(cell: ChannelCVCell) {
        cell.configureCell(self)
    }
    
    func isContentEqual(to source: ChannelCVCellModel) -> Bool {
        return channelId == source.channelId && name == source.name
    }
}

final class ChannelCVCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var didSetupConstraints = false
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            nameLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func configureCell(_ data: ChannelCVCellModel) {
        self.nameLabel.text = data.name
    }
}

private extension ChannelCVCell {
    func setupViews() {
        contentView.addSubview(nameLabel)
        
        setNeedsUpdateConstraints()
    }
}

