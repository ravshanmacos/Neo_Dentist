//
//  SheetProtocols.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/01/24.
//

import UIKit

protocol SheetProtocol {
    var sheetImageView: UIImageView { get set }
    var sheetLabel: UILabel { get set }
}


protocol TwoActionSheetProtocol: SheetProtocol {
    var sheetFirstAction: UIButton { get set }
    var sheetSecondAction: UIButton { get set }
}

protocol SingleActionSheetProtocol: SheetProtocol {
    var sheetFirstActionButton: UIButton { get set }
}
