//
//  InputFieldValidator.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case mobile
    case username
    case requiredField(field: String)
    
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .username: return UserNameValidator()
        case .mobile: return MobileNumberValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        }
    }
}

struct IdValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        
        switch value.trim().count {
        case 0:
            throw ValidationError("Mobile number is Required")
        case _ where value.trim().count < 5 :
            throw ValidationError("Mobile number must contain more than four digit" )
        case _ where value.trim().count > 16 :
            throw ValidationError("Mobile number shoudn't conain more than 16 digit" )
            
        default:
            break
        }
        
        
        return value
    }
    
    
}
struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        switch value.trim().count {
        case 0:
            throw ValidationError("\(fieldName) is Required")
        case _ where value.trim().count < 2 :
            throw ValidationError("\(fieldName) must contain more than two digit" )
        case _ where value.trim().count > 10 :
            throw ValidationError("\(fieldName) shoudn't conain more than 10 digit" )
            
        default:
            break
        }
       
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("Username shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}

struct MobileNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        
        switch value.trim().count {
        case 0:
             throw ValidationError("Mobile number is Required")
        case _ where value.trim().count < 5 :
            throw ValidationError("Mobile number must contain more than four digit" )
        case _ where value.trim().count > 16 :
             throw ValidationError("Mobile number shoudn't conain more than 16 digit" )
       
        default:
            break
        }
        

        return value
    }
    
    
}


struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}


extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
