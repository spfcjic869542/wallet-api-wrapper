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
  
  (post-request endpoint api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\" }" daemonHost daemonPort filename wallet-password)))


(defun import-wallet-key (endpoint daemonHost daemonPort filename wallet-password scan-height view-key spend-key api-key)
  
  (post-request endpoint api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\",
                                                \"scanHeight\": ~A,
                                                \"privateViewKey\": \"~A\",
                                                \"privateSpendKey\": \"~A\" }" daemonHost daemonPort filename wallet-password scan-height view-key spend-key)))


(defun import-wallet-seed (endpoint daemonHost daemonPort filename wallet-password scan-height mnemonicseed api-key)

  (post-request endpoint api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\",
                                                \"scanHeight\": ~A,
                                                \"mnemonicSeed\": \"~A\" }" daemonHost daemonPort filename wallet-password scan-height mnemonicseed)))


(defun import-view-wallet (endpoint daemonHost daemonPort filename wallet-password scan-height view-key address api-key)

  (post-request endpoint api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\",
                                                \"scanHeight\": ~A,
                                                \"privateViewKey\": \"~A\",
                                                \"address\": \"~A\" }" daemonHost daemonPort filename wallet-password scan-height view-key address)))


(defun create-wallet (endpoint daemonHost daemonPort filename wallet-password api-key)

  (post-request endpoint api-key (format nil "{ \"daemonHost\": \"~A\",
                                                \"daemonPort\": ~A,
                                                \"filename\": \"~A\",
                                                \"password\": \"~A\" }" daemonHost daemonPort filename wallet-password)))


(defun close-wallet (endpoint api-key) (delete-request endpoint api-key nil))


                                        ;address functions


(defun get-addresses (endpoint api-key) (map 'string #'code-char (get-request endpoint api-key nil)))


(defun delete-wallet (endpoint wallet-address api-key)  (delete-request (concatenate 'string endpoint wallet-address) api-key nil))


(defun get-primary-address (endpoint api-key) (map 'string #'code-char (get-request endpoint api-key nil)))


(defun create-random-wallet (endpoint api-key) (map 'string #'code-char (post-request endpoint api-key nil)))


(defun import-wallet-private-key (endpoint private-key scanheight api-key)

  (post-request endpoint api-key (format nil "{
                                               \"scanHeight\": ~A,
                                               \"privateSpendKey\": \"~A\" }" scanHeight private-key)))


(defun import-wallet-public-key (endpoint public-key scanheight api-key)
  
  (post-request endpoint api-key (format nil "{
                                               \"scanHeight\": ~A,
                                               \"publicSpendKey\": \"~A\" }" scanHeight public-key)))


(defun create-integrated-wallet (endpoint address payment-id api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "addresses/" address "/" payment-id) api-key nil)))


                                        ;node functions


(defun get-node-info (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "node") api-key nil)))


(defun set-node (endpoint daemonhost daemonport api-key) (put-request (concatenate 'string endpoint "node") api-key (format nil "{
                                                                                                                                  \"daemonHost\": \"~A\",
                                                                                                                                  \"daemonPort\": ~A }" daemonhost daemonport)))


                                        ;key functions


(defun get-container-private-keys (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "keys") api-key nil)))


(defun get-container-keys (endpoint address api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "keys/" address) api-key nil)))


(defun get-mnemonic-seed (endpoint address api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "keys/mnemonic/" address) api-key nil)))


                                        ;transaction functions


(defun get-transactions (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "transactions") api-key nil)))


(defun get-transaction-details (endpoint hash api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "hash/" hash) api-key nil)))


(defun get-unconfirmed-transactions (endpoint api-key) (map 'string #'code-char (get-request (concatenate 'string endpoint "transactions/unconfirmed") api-key nil)))



