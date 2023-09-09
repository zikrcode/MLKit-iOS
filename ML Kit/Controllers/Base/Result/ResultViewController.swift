//
//  ResultViewController.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 12/07/2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet private weak var resultTableView: UITableView!
    
    private var receivedData: [String: Any?]!
    private var resultTableViewDataSource: [Int: [String: String]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureResultTableView()
    }
    
    func setReceivedData(_ data: [String: Any?]) {
        receivedData = data
        resultTableViewDataSource = receivedData[AppConstants.RESULT_TEXT_KEY] as? [Int: [String: String]]
    }
    
    private func configureResultTableView() {
        resultTableView.layer.cornerRadius = AppConstants.SINGLE_HALF_CORNER_RADIUS

        resultTableView.register(UINib(nibName: ResultTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        
        resultTableView.register(UINib(nibName: ResultHeaderTableViewCell.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ResultHeaderTableViewCell.reuseIdentifier)
        resultTableView.register(UINib(nibName: ResultFooterTableViewCell.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ResultFooterTableViewCell.reuseIdentifier)

        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
}

extension ResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultTableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as! ResultTableViewCell
        let source = receivedData[AppConstants.RESULT_SOURCE_KEY] as! String
        let data = resultTableViewDataSource[indexPath.row]
        
        cell.bind(source: source, data: data)
        
        return cell
    }
}

extension ResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ResultHeaderTableViewCell.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ResultHeaderTableViewCell.reuseIdentifier) as! ResultHeaderTableViewCell
        
        let resultImage = receivedData[AppConstants.RESULT_IMAGE_KEY] as? UIImage
        
        headerView.bind(image: resultImage)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ResultFooterTableViewCell.height
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ResultFooterTableViewCell.reuseIdentifier) as! ResultFooterTableViewCell
        footerView.delegate = self
        return footerView
    }
}

extension ResultViewController: ResultFooterTableViewCellDelegate {
    func onExitButtonClicked() {
        guard let navigationController = self.navigationController else { return }
        
        if let viewController = navigationController.viewControllers.first(where: { $0 is HomeViewController}) {
            navigationController.popToViewController(viewController, animated: true)
        }
    }
}
