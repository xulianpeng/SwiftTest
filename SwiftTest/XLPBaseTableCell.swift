//
//  XLPBaseTableCell.swift
//  SwiftTest
//
//  Created by lianpeng on 2017/3/28.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

import UIKit

class XLPBaseTableCell: UITableViewCell {

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
