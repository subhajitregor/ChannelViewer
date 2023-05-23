//
//  ProgramCVCell.swift
//  ChannelViewer
//
//  Created by subhajit halder on 23/05/23.
//

import UIKit

struct ProgramCVCellModel: CellViewModel {
    
    typealias CellType = ProgramCVCell
    
    let programId: Int
    let name: String
    var onClick: ((ProgramCVCell) -> Void)?
    
    var differenceIdentifier: String {
        return "\(programId)"
    }
    
    func setup(cell: ProgramCVCell) {
        cell.configureCell(self)
    }
    
    func isContentEqual(to source: ProgramCVCellModel) -> Bool {
        return programId == source.programId && name == source.name
    }
}

final class ProgramCVCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var didSetupConstraints = false
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .white
        label.textColor = .black
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
    
    func configureCell(_ data: ProgramCVCellModel) {
        self.nameLabel.text = data.name
    }
}

private extension ProgramCVCell {
    func setupViews() {
        contentView.addSubview(nameLabel)
        
        setNeedsUpdateConstraints()
    }
}
