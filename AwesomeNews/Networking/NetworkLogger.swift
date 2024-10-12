//
//  NetworkLogger.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import Alamofire
import Foundation

enum LogLevel: String {
    case info = "ℹ️"
    case debug = "🐞"
    case warning = "⚠️"
    case error = "❌"
}

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.awesomenews.networklogger")
    let logQueue = DispatchQueue(label: "com.awesomenews.networklogger.logqueue", qos: .background)

    func log(_ level: LogLevel, message: String) {
        logQueue.async {
            print("\(level.rawValue) \(message)")
        }
    }

    // MARK: - Request Lifecycle Events

    func requestCreated(_ request: Request) {
        log(.info, message: "[Request Created] \(request.request?.httpMethod ?? "") \(request.request?.url?.absoluteString ?? "")")
    }

    func requestDidResume(_ request: Request) {
        log(.info, message: "[Request Started] \(request.request?.httpMethod ?? "") \(request.request?.url?.absoluteString ?? "")")
        if let headers = request.request?.allHTTPHeaderFields {
            var safeHeaders = headers
            // Mask sensitive headers
            if let auth = safeHeaders["Authorization"] {
                safeHeaders["Authorization"] = "*****"
            }
            log(.debug, message: "Headers: \(safeHeaders)")
        }
        if let body = request.request?.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            log(.debug, message: "Body: \(bodyString)")
        }
    }

    func requestDidFinish(_ request: Request) {
        log(.info, message: "[Request Finished] \(request.request?.httpMethod ?? "") \(request.request?.url?.absoluteString ?? "")")
    }

    func requestDidCancel(_ request: Request) {
        log(.warning, message: "[Request Canceled] \(request.request?.httpMethod ?? "") \(request.request?.url?.absoluteString ?? "")")
    }

    // MARK: - Task Metrics

    func taskMetrics(for session: Session, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        log(.debug, message: "[Task Metrics] \(task.originalRequest?.url?.absoluteString ?? "")")
        for transactionMetric in metrics.transactionMetrics {
            log(.debug, message: "    * Request Start Date: \(String(describing: transactionMetric.requestStartDate))")
            log(.debug, message: "    * Response End Date: \(String(describing: transactionMetric.responseEndDate))")
        }
    }

    // MARK: - Authentication Challenges

    func request(_ request: Request, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        log(.warning, message: "[Authentication Challenge] \(request.request?.url?.absoluteString ?? "")")
        // Handle challenge as needed
        completionHandler(.performDefaultHandling, nil)
    }

    // MARK: - Data Transfer Events

    func request(_ request: Request, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        log(.debug, message: "[Upload Progress] \(request.request?.url?.absoluteString ?? "") - \(String(format: "%.2f", progress * 100))%")
    }
}
