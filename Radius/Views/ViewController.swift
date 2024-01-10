//
//  ViewController.swift
//  Radius
//
//  Created by Kavyashree Hegde on 28/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var facilityTableView: UITableView!
    
    let networkService = NetworkService()
    var viewModel: FacilityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFacilities()
        setUpTableView()
    }

    fileprivate func setUpTableView() {
        facilityTableView.register(FacilityTableViewCell.self, forCellReuseIdentifier: FacilityTableViewCell.cellId)
        facilityTableView.delegate = self
        facilityTableView.dataSource = self
        
        facilityTableView.backgroundColor = .clear
        facilityTableView.separatorStyle = .none
        
        let firstColor = UIColor(red: 55/225, green: 125/225, blue: 246/225, alpha: 1.0)
        let secondColor = UIColor(red: 169/225, green: 219/225, blue: 251/225, alpha: 1.0)
        self.view.applyGradient(colours: [firstColor, secondColor])
    }
    
    private func fetchFacilities() {
        Task {
            let result = await networkService.sendRequest(endpoint: FacilityRequestEndpoint(), responseModel: FacilityResponse.self)
            switch result {
            case .success(let facilityResponse):
                viewModel = FacilityViewModel(facilityData: facilityResponse)
                facilityTableView.reloadData()
            case .failure(let error):
                self.showAlert(withTitle: "Error", withMessage: error.description, handler: nil)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.getSectionCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView()
        view.backgroundColor = .clear
        view.headerLabel.text = viewModel?.getSectionHeaderTitle(for: section)
        return view
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getRowsCount(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? FacilityTableViewCell
        if let selected = cell?.option?.selected {
            cell?.option?.selected = !selected
        } else {
            cell?.option?.selected = true
        }
        let optionId = cell?.option?.id
        let facilityId = cell?.facilityId
        
        if facilityId == FacilityType.otherFacilities.rawValue ||
            viewModel?.getRowsCount(for: indexPath.section) == 1 {
            return
        }
        
        if indexPath.section == 0 {
            viewModel?.clearSelectionForPropertyType()
            viewModel?.updateSelectionForPropertyTypeFor(section: indexPath.section, row: indexPath.row)
        } else {
            self.viewModel?.currentFacilities = self.viewModel?.facilities ?? []
            self.viewModel?.currentFacilities[indexPath.section].options[indexPath.row].selected = true
        }
                
        self.viewModel?.updateDataSourceFor(facilityId: facilityId, optionId: optionId)
        self.facilityTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FacilityTableViewCell.cellId, for: indexPath) as? FacilityTableViewCell else {
            return UITableViewCell()
        }
        
        let facilities = viewModel?.getFacilities(for: indexPath.section)
        let option = facilities?.options[indexPath.row]
        cell.option = option
        cell.facilityId = facilities?.facility_id
        
        return cell
    }
}
