//
//  ViewController.swift
//  BoundingRectIssue
//
//  Created by Issam LANOUARI on 09/06/2021.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var height: NSLayoutConstraint!

  let usedFont: UIFont = UIFont.systemFont(ofSize: 17)
  let usedStyle: NSMutableParagraphStyle = {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = 3
    style.lineBreakMode = NSLineBreakMode.byWordWrapping
    return style
  }()
                      
  let text: String = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupixdatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    textView.font = usedFont
//    textView.text = text
    textView.attributedText = NSMutableAttributedString(string: text, attributes: [.font: usedFont, .paragraphStyle: usedStyle])
  }

  @IBAction func FixSizeAction(_ sender: Any) {
    let attributes: [NSAttributedString.Key: Any] = [.font: usedFont, .paragraphStyle: usedStyle]
    
    height.constant = text.heightWithConstrainedWidth( textView.frame.width, attributes: attributes)
//
//    height.constant = text.height(withConstrainedWidth: textView.frame.width, font: usedFont)
  }
}

extension String {
  func heightWithConstrainedWidth(_ width: CGFloat, attributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
    return ceil(boundingBox.height)
  }

  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    return ceil(boundingBox.height)
  }
}

