//
//  NMapSearchResultViewController+Delegate.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/14.
//

import UIKit

extension NMapSearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        // call Local API with searchBar.text
        guard let searchQuery = searchBar.text else {
            return
        }
        
        localQuery.searchData(query: searchQuery) { searchResults in
            DispatchQueue.main.async {
                self.searchResults = searchResults
                self.tableView.reloadData()
            }
        }
    }
}

extension NMapSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = NMapDetailViewController(mapItem: self.searchResults[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
