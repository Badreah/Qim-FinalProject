//
//  AuthError.swift
//  Qim
//
//  Created by Badreah Saad on 22/01/2022.
//

import Foundation
import UIKit
import Firebase


extension AuthErrorCode {
    var description: String? {
        switch self {
        case .emailAlreadyInUse:
                return " البريد الالكتروني مسجل مسبقا"
        case .userDisabled:
                return "المستخدم غير نشط حاليا"
        case .operationNotAllowed:
                return "العملية غير معتمدة"
        case .invalidEmail:
                return "الرجاء التأكد من ادخال البريد الالكتروني الصحيح"
        case .wrongPassword:
                return "الرجاء التأكد من ادخال كلمة مرور صحيحة "
        case .userNotFound:
                return "لم يتم العثور على حساب مستخدم "
        case .networkError:
                return "حدث خطأ في الشبكة. حاول مرة اخرى"
        case .weakPassword:
                return "كلمة المرور ضعيفه"
        case .missingEmail:
                return "الرجاء إدخال البريد الإلكتروني "
        case .internalError:
                return "خطأ داخلي يرجى المحاولة مرة أخرى"
        case .invalidCustomToken:
                return "الرمز غير صالح"
        case .tooManyRequests:
                return "لقد أرسلت عددًا كبيرًا جدًا من الطلبات إلى الخادم. الرجاء الإنتظار قليلا "
        default:
            return nil
        }
    }
}

public extension Error {
    var localizedDescription: String {
        let error = self as NSError
        if error.domain == AuthErrorDomain {
            if let code = AuthErrorCode(rawValue: error.code) {
                if let errorString = code.description {
                    return errorString
                }
            }
        }
        return error.localizedDescription
    } }
