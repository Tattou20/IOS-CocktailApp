//
//  APICallerCategory.swift
//  CocktailApp
//
//  Created by user238581 on 4/19/24.
//

import Foundation

final class APICallerCategory {
    static let shared = APICallerCategory()
    
    struct Constants {
        static let nonAlcoholicURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic")}
    
    private init() {}
    
    public func getCategory(completion: @escaping (Result<[Category], Error>) -> Void){
        guard let url = Constants.nonAlcoholicURL else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
        else if let data = data {
            do{
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                
                print("Drinks: \(result.drinks.count)")
                completion(.success(result.drinks))
            }
            catch{
                completion(.failure(error))
            }
                
        }
        }
        task.resume()
    }
}

//Models
struct APIResponse: Codable{
    let drinks: [Category]
}

struct Category: Codable{
    let strDrink: String
    let strDrinkThumb: String?
    let idDrink: String
}
