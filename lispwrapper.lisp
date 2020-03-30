                                        ;load packages


(ql:quickload :drakma)


                                        ;define request types


(defun post-request (endpoint api-key content)
  
  (drakma:http-request endpoint
                       :method :post
                       :content-type "application/json"
                       :additional-headers (list (cons "X-API-KEY" api-key))
                       :content content))


(defun get-request (endpoint api-key content)

  (drakma:http-request endpoint
                       :method :get
                       :content-type "application/json"
                       :additional-headers (list (cons "X-API-KEY" api-key))
                       :content content))


(defun delete-request (endpoint api-key content)

  (drakma:http-request endpoint
                       :method :delete
                       :content-type "application/json"
                       :additional-headers (list (cons "X-API-KEY" api-key))
                       :content content))


(defun put-request (endpoint api-key content)

  (drakma:http-request endpoint
                       :method :put
                       :content-type "application/json"
                       :additional-headers (list (cons "X-API-KEY" api-key))
                       :content content))


                                        ;wallet functions


(defun open-wallet (endpoint daemonHost daemonPort filename wallet-password api-key)
  
  (post-request (concatenate 'string endpoint "/wallet/open") api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\" }" daemonHost daemonPort filename wallet-password)))


(defun import-wallet-key (endpoint daemonHost daemonPort filename wallet-password scan-height view-key spend-key api-key)
  
  (post-request (concatenate 'string endpoint "/wallet/import/key") api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\",
                                                \"scanHeight\": ~A,
                                                \"privateViewKey\": \"~A\",
                                                \"privateSpendKey\": \"~A\" }" daemonHost daemonPort filename wallet-password scan-height view-key spend-key)))


(defun import-wallet-seed (endpoint daemonHost daemonPort filename wallet-password scan-height mnemonicseed api-key)

  (post-request (concatenate 'string endpoint "/wallet/import/seed") api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\",
                                                \"scanHeight\": ~A,
                                                \"mnemonicSeed\": \"~A\" }" daemonHost daemonPort filename wallet-password scan-height mnemonicseed)))


(defun import-view-wallet (endpoint daemonHost daemonPort filename wallet-password scan-height view-key address api-key)

  (post-request (concatenate 'string endpoint "/wallet/import/view") api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\",
                                                \"scanHeight\": ~A,
                                                \"privateViewKey\": \"~A\",
                                                \"address\": \"~A\" }" daemonHost daemonPort filename wallet-password scan-height view-key address)))


(defun create-wallet (endpoint daemonHost daemonPort filename wallet-password api-key)

  (post-request (concatenate 'string endpoint "/wallet/create") api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\" }" daemonHost daemonPort filename wallet-password)))


(defun close-wallet (endpoint api-key) (delete-request (concatenate 'string endpoint "/wallet") api-key nil))


                                        ;address functions


(defun get-addresses (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/addresses") api-key nil)))


(defun delete-wallet (endpoint wallet-address api-key)  (delete-request (concatenate 'string endpoint "/addresses/" wallet-address) api-key nil))


(defun get-primary-address (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/addresses/primary") api-key nil)))


(defun create-random-wallet (endpoint api-key) (map 'string #'code-char (post-request (concatenate 'string endpoint "/addresses/create") api-key nil)))


(defun import-wallet-private-key (endpoint private-key scanheight api-key)

  (post-request (concatenate 'string endpoint "/addresses/import") api-key (format nil "{
                                               \"scanHeight\": ~A,
                                               \"privateSpendKey\": \"~A\" }" scanHeight private-key)))


(defun import-wallet-public-key (endpoint public-key scanheight api-key)
  
  (post-request (concatenate 'string endpoint "/addresses/import/view") api-key (format nil "{
                                               \"scanHeight\": ~A,
                                               \"publicSpendKey\": \"~A\" }" scanHeight public-key)))


(defun create-integrated-wallet (endpoint address payment-id api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/addresses/" address "/" payment-id) api-key nil)))


                                        ;node functions


(defun get-node-info (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/node") api-key nil)))


(defun set-node (endpoint daemonhost daemonport api-key) (put-request (concatenate 'string endpoint "/node") api-key (format nil "{
                                                                                                                                  \"daemonHost\": \"~A\",
                                                                                                                                  \"daemonPort\": ~A }" daemonhost daemonport)))


                                        ;key functions


(defun get-container-private-keys (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/keys") api-key nil)))


(defun get-container-keys (endpoint address api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/keys/" address) api-key nil)))


(defun get-mnemonic-seed (endpoint address api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/keys/mnemonic/" address) api-key nil)))


                                        ;transaction functions


(defun get-transactions (endpoint  api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions") api-key nil)))


(defun get-transaction-details (endpoint hash api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions/hash/" hash) api-key nil)))


(defun get-unconfirmed-transactions (endpoint api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions/unconfirmed") api-key nil)))


(defun get-unconfirmed-transactions-address (endpoint address api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions/unconfirmed/" address) api-key nil)))


(defun get-transactions-from-height (endpoint height api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions/" height) api-key nil)))


(defun get-transactions-startheight-endheight (endpoint startheight endheight api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions/" startheight "/" endheight) api-key nil)))


(defun get-transactions-address-startheight (endpoint address startheight api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions/address/" address "/" startheight) api-key nil)))


(defun get-transactions-address-startheight-endheight (endpoint address startheight endheight api-key)
  
  (map 'string #'code-char (get-request (concatenate 'string endpoint "/transactions/address/" address "/" startheight "/" endheight) api-key nil)))


(defun basic-send (endpoint address amount paymentid api-key)

  (map 'string #'code-char (post-request (concatenate 'string endpoint "/transactions/send/basic") api-key (format nil "{
                                                                                                                        \"destination\": \"~A\",
                                                                                                                        \"amount\": ~A,
                                                                                                                        \"paymentID\": \"~A\" }" address amount paymentid))))



(defun prepare-basic-send (endpoint address amount paymentid api-key) 
  
  (post-request (concatenate 'string endpoint "/transactions/prepare/basic") api-key (format nil "{
                                                                                               \"destination\": \"~A\",
                                                                                               \"amount\": ~A,
                                                                                               \"paymentID\": \"~A\" }" address amount paymentid)))


(defun advanced-send (endpoint addresses amounts paymentid unlocktime api-key)

  (setq input (princ-to-string (collect-list addresses amounts)))

  (setq input (string-left-trim "(" input))

  (setq input (string-right-trim ")" input))
  
  (setq input (string-right-trim "," input))

  (concatenate 'string "{ \"destinations\": [ " input " ], \"paymentID\": " "\"" paymentid "\": " "\"unlockTime\": " (write-to-string unlocktime) "}")

  (post-request (concatenate 'string endpoint "/transactions/send/advanced") api-key (concatenate 'string "{ \"destinations\": [ " input " ], \"paymentID\": " "\"" paymentid "\": " "\"unlockTime\": " (write-to-string unlocktime) "}")))


(defun prepare-advanced-send (endpoint addresses amounts paymentid unlocktime api-key) (advanced-send (concatenate 'string endpoint "/transactions/prepare/advanced") addresses amounts paymentid unlocktime api-key))


(defun send-prepared-transactions (endpoint hash api-key) (post-request (concatenate 'string endpoint "/transactions/send/prepared") api-key (format nil "{ \"transactionHash\": \"~A\" }" hash)))


(defun cancel-prepared-transaction (endpoint hash api-key) (delete-request (concatenate 'string endpoint "/transactions/prepared" hash) api-key nil))


(defun send-fusion-transaction (endpoint api-key) (post-request (concatenate 'string endpoint "/transactions/send/fusion/basic") api-key nil))


(defun send-advanced-fusion-transaction (endpoint mixin addresses destination optimizetarget api-key)

  (post-request (concatenate 'string endpoint "/transactions/send/fusion/advanced") api-key (format nil "{ \"mixin\": ~A, \"sourceAddresses\": [ \"~A\" ], \"destination\": \"~A\", \"optimizeTarget\": ~A }" mixin addresses destination optimizetarget)))


(defun get-transaction-private-key (endpoint hash api-key) (get-request (concatenate 'string endpoint "/transactions/privatekey/" hash) api-key nil))




                                        ;balance functions


(defun balance (endpoint api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/balance") api-key nil)))


(defun balance-address (endpoint address api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/balance/" address) api-key nil)))


(defun get-balances (endpoint api-key)

  (map 'string #'code-char (get-request (concatenate 'string endpoint "/balances") api-key nil)))


                                        ;misc functions


(defun save (endpoint api-key) (put-request (concatenate 'string endpoint "/save") api-key nil))


(defun export-wallet-data (endpoint filename api-key)

  (post-request (concatenate 'string endpoint "/export/json") api-key (format nil "{ \"filename\": \"~A\" }" filename)))


(defun reset-wallet (endpoint scanheight api-key) (put-request (concatenate 'string endpoint "/reset") api-key (format nil "{ \"scanHeight\": ~A }" scanheight)))


(defun validate-address (endpoint address api-key) (post-request (concatenate 'string endpoint "/addresses/validate") api-key (format nil "{ \"address\": \"~A\" }" address)))


(defun get-status (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "/status") api-key nil)))


                                        ;supporting functions


(defun collect-list (addresses amounts)
  
  (loop for address in addresses
        for amount in amounts
        
        do
        
        (setq address-string (princ-to-string address))
        (setq amount-string (princ-to-string amount))
        
        (setq json (format nil "{ \"address\": \"~A\", \"amount\": ~A }" address-string amount-string))
        
        collect json))
