//
//  MapSearchResultViewController+Delegate.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/12.
//

import MapKit

extension MapSearchResultViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // every time text changes on search bar
        // completer gets the text as a search text
        // also, gets mapView region to set searching area
        if let region = mapView?.region {
            searchCompleter.region = region
        }
        searchCompleter.queryFragment = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MapSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResultCompletions[indexPath.row]
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let mapItem = response?.mapItems[0] else {
                return
            }
            let vc = MapDetailViewController(mapItem: mapItem)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension MapSearchResultViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // handles the result that Completer retrieved.
        searchResultCompletions = completer.results
        tableView.reloadData()
    }
}
