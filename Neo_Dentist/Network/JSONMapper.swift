//
//  JSONMapper.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import SwiftyJSON

struct MappingError: LocalizedError {
    var errorDescription: String? { "mapping_error" }
}

protocol JSONMapper {
    func mapToObject<T: Decodable>(from json: Any, type: T.Type) throws -> T
    func mapToObject<T: Decodable>(from data: Data, type: T.Type) throws -> T
    func mapToResult<T: Decodable>(from result: Result<APIResponse, Error>, forKey key: String?, type: T.Type) -> Result<T, Error>
    func bool(from result: Result<APIResponse, Error>, forKey key: String) -> Result<Bool, Error>
    func string(from result: Result<APIResponse, Error>, forKey key: String) -> Result<String, Error>
}

extension JSONMapper {
    func mapToResult<T: Decodable>(from result: Result<APIResponse, Error>, forKey key: String?, type: T.Type) -> Result<T, Error>{
        switch result {
        case .success(let response):
            guard let bodyData = response.body(for: nil) else {
                return Result.failure(MappingError())
            }
            do {
                let object = try self.mapToObject(from: bodyData, type: type)
                return Result.success(object)
            } catch let error {
                return Result.failure(error)
            }
            
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
    func bool(from result: Result<APIResponse, Error>, forKey key: String) -> Result<Bool, Error> {
        switch result {
        case .success(let response):
            guard let bodyData = response.body(for: key) as? Bool else { return Result.failure(MappingError()) }
            return Result.success(bodyData)
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
    func string(from result: Result<APIResponse, Error>, forKey key: String) -> Result<String, Error> {
        switch result {
        case .success(let response):
            guard let bodyData = response.body(for: key) as? String else { return Result.failure(MappingError()) }
            return Result.success(bodyData)
        case .failure(let error):
            return Result.failure(error)
        }
    }
}

class JSONMapperImplementation: JSONMapper {
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func mapToObject<T: Decodable>(from json: Any, type: T.Type) throws -> T {
        do {
            //converting json of type any into JSON
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            let object = try mapToObject(from: jsonData, type: type)
            return object
        } catch  {
            print(error.localizedDescription)
        }
        throw MappingError()
    }
    
    func mapToObject<T: Decodable>(from data: Data, type: T.Type) throws -> T {
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("\(key.stringValue) was not found, \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("\(type) was expected, \(context.debugDescription) | \(context.codingPath)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("no value was found for \(type), \(context.debugDescription)")
        } catch {
            print("Unknown error")
        }
        
        throw MappingError()
    }
    
    
}
