//
//  FilmsTableViewCell.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import UIKit
import SnapKit

class FilmsTableViewCell: UITableViewCell {
    var label: UILabel!
    static let identifier: String = "cellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    func configure() {
        label = UILabel(frame: .zero)
        self.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
