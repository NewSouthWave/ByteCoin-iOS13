//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: Double)
    func didFailwithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "284afd07-37a1-45e3-833f-175b08577c8c"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","KRW","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){    //  for은 외부 / currency는 내부 파라미터
        // URL 업데이트
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        // url 옵셔널 바인딩으로 언래핑
        if let url = URL(string: urlString) {
            
            // URLSession 객체 생성
            let session = URLSession(configuration: .default)
            print("<< URL 세션 생성 >>")

            // 새로운 data task 생성
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
//                let dataAsString = String(data: data!, encoding: .utf8)
//                print(dataAsString!)
                print("<< Data Task 생성 >>")

                if let safeData = data {
                    print("<< 옵셔널 바인딩 >>")
                    if let price = self.parseJSON(safeData){
                        print(price)
                        self.delegate?.didUpdateCoin(self, coin: price)
                    }
                }
                
            }
            // api 서버에서 데이타를 받아와서 task 시작
            task.resume()
        }
        
    }
    
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        } catch {
            print(error)
            return nil
        }
    }
    
    
}

/*
 <<< API JSON 포맷 >>>
 // 20250220225211
 // https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=284afd07-37a1-45e3-833f-175b08577c8c

 {
   "time": "2025-02-20T13:52:11.4000000Z",
   "asset_id_base": "BTC",
   "asset_id_quote": "USD",
   "rate": 97440.8701048634
 }
 
 */
