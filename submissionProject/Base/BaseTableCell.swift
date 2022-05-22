//
//  BaseTableCell.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import UIKit

class BaseTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectionStyle = .none
        initView()
    }
    
    func initView() {
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
