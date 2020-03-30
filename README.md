# Wallet-API Wrapper

Wallet-API Wrapper is a wrapper made in common lisp to interface with Turtlecoin's [Wallet-API](https://turtlecoin.github.io/wallet-api-docs/).

# Dependencies

[Quicklisp](https://www.quicklisp.org/beta/)

[Drakma](https://edicl.github.io/drakma/)

Quicklisp can be considered optional but is reccomended due to ease of use in managing and loading packages.

# Functions Overview

1. Wallet 
	1. open-wallet
    2. import-wallet-key
	3. import-wallet-seed
	4. import-view-wallet
	5. create-wallet
	6. close-wallet

2. Address
	1. get-addresses
	2. delete-wallet
	3. get-primary-address
	4. create-random-wallet
	5. import-wallet-private-key
	6. import-wallet-public-key
	7. create-integrated-wallet

3. Node
	1. get-node-info
	2. set-node

4. Key functions
	1. get-container-private-keys
	2. get-container-keys
	3. get-mnemonic-seed

5. Transactions
	1. get-transactions
	2. get-transaction-details
	3. get-unconfirmed-transactions
	4. get-unconfirmed-transactions-address
	5. get-transactions-from-height
	6. get-transactions-startheight-endheight
	7. get-transactions-address-startheight
	8. get-transactions-address-startheight-endheight
	9. basic-send
	10. prepare-basic-send
	11. advanced-send
	12. prepare-advanced-send
	13. send-prepared-transactions
	14. cancel-preparedtransaction
	15. send-fusion-transaction
	16. send-advanced-fusion-transaction
	17. get-transaction-private-key

6. Balance functions
	1. balance
	2. balance-address
	3. get-balances

7. Misc. functions
	1. save
	2. export-wallet-data
	3. reset-wallet
	4. validate-address
	5. get-status


# Functions

Refer to the [Wallet-API documentation](https://turtlecoin.github.io/wallet-api-docs/) to find the associated http status code.

Each function is listed in the same order as the Wallet-API documentation.

Before continuing please note the variable `endpoint` specifies the address the Wallet-API is launched on and `api-key` is the password chosen when launching the Wallet-API with the flag `--rpc-password`.


## Wallet Functions


### open-wallet

Opens a specified wallet.

```lisp
(open-wallet endpoint daemonHost daemonPort filename wallet-password api-key)
```


### import-wallet-key

Imports a wallet with a given starting scan-height, view-key, spend-key.

```lisp
(import-wallet-key endpoint daemonHost daemonPort filename wallet-password scan-height view-key spend-key api-key)
```


### import-wallet-seed

Imports a wallet with a given mnemonic seed and starting scan-height.

```listp
(import-wallet-seed endpoint daemonHost daemonPort filename wallet-password scan-height mnemonicseed api-key)
```

### import-view-wallet

Imports a view only wallet.

```lisp
(import-view-wallet endpoint daemonHost daemonPort filename wallet-password scan-height view-key address api-key)
```

### create-wallet

Creates a wallet.

```lisp
(create-wallet endpoint daemonHost daemonPort filename wallet-password api-key)
```

### close-wallet

Closes the currently opened wallet.

```lisp
(close-wallet endpoint api-key)
```

## Address Functions


### get-addresses 

Returns a list of all addresses in the wallet container.

```lisp
(get-addresses endpoint api-key)
```

### delete-wallet

Deletes a specified wallet.

```lisp 
(delete-wallet endpoint wallet-address api-key)
```

### get-primary-address

Returns the primary address in the wallet container.

```lisp
(get-primary-address endpoint api-key)
```

### create-random-wallet

Creates a random wallet.

```lisp
(create-random-wallet endpoint api-key)
```

### import-wallet-private-key

Imports a wallet with a given private key and start scan-height.

```lisp
(import-wallet-private-key endpoint private-key scanheight api-key)
```

### import-wallet-public-key

Imports a wallet with a given public key and start scan-height.

```lisp 
(import-wallet-public-key endpoint public-key scanheight api-key)
```

### create-integrated-wallet

Creates an integrated wallet given an address and payment-id.

```lisp
(create-integrated-wallet endpoint address payment-id api-key)
```

## Node Functions

### get-node-info

Returns info regarding the node you are currently connected to.

```lisp
(get-node-info endpoint api-key)
```

### set-node

Set the Wallet-API to a selected node address and port.

```lisp
(set-node daemonhost daemonport api-key)
```

## Key Functions

### get-container-private-keys

Returns the containers shared private key.

```lisp
(get-container-private-keys endpoint api-key)
```

### get-container-keys

Returns the public and private key for the given address.

```lisp
(get-container-keys endpoint address api-key)
```

### get-mnemonic-seed

Returns the mnemonic seed for the given address.

```lisp 
(get-mnemonic-seed endpoint address api-key)
```

## Transaction Functions

### get-transactions

Returns a list of all transactions.

```lisp
(get-transactions endpoint api-key)
```

### get-transaction-details

Returns details for a transaction with a given transaction hash.

```lisp
(get-transaction-details endpoint hash api-key)
```

### get-unconfirmed-transactions

Returns a list of all unconfirmed transactions.

```lisp
(get-unconfirmed-transactions endpoint api-key)
```

### get-unconfirmed-transactions-address

Returns a list of all unconfirmed transactions for a given address.

```lisp
(get-unconfirmed-transactions endpoint api-key)
```

### get-transactions-from-height

Returns a list of transactions from a given height.

```lisp
(get-transactions-from-height endpoint height api-key)
```

### get-transactions-startheight-endheight

Returns a list of transactions from a given start height and end height.

```lisp
(get-transactions-startheight-endheight endpoint starttheight endheight api-key)
```

### get-transactions-address-startheight

Returns a list of transactions for a given address and startheight.

```lisp
(get-transactions-address-startheight endpoint address startheight api-key)
```

### get-transactions-address-startheight-endheight

Returns a list of transactions for an address given a start height and end height.

```lisp
(get-transactions-address-startheight-endheight endpoint address startheight endheight api-key)
```

### basic-send

Sends a basic transaction.

```lisp
(basic-send address amount paymentid api-key)
```

### prepare-basic-send

Prepares a basic transaction before sending it.

```lisp
(prepare-basic-send endpoint address amount paymentid api-key)
```

### advanced-send

Sends a transaction that can specify multiple destinations and amounts. 

Please note ``addresses`` and ``amounts`` is to be passed a list.

```lisp
(advanced-send endpoint addresses amounts paymentid unlocktime api-key)
```

### prepare-advanced-send

Prepares an advanced transaction before sending it.

As noted in ``advanced-send`` lists are to be passed to ``addresses`` and ``amounts``.

```lisp
(prepare-advanced-send endpoint addresses amounts paymentid unlocktime api-key)
```

### send-prepared-transactions

Broadcast previously prepared transactions to the network.

```lisp
(send-prepared-transactions endpoint hash api-key)
```

### cancel-prepared-transaction

Cancel a previously prepared transaction with a given hash.

```lisp
(cancel-prepared-transaction endpoint hash api-key)
```

### send-fusion-transaction

Sends a fusion transaction.

```lisp
(send-fusion-transaction endpoint api-key)
```

### send-advanced-fusion-transaction

Sends an advanced fusion transaction.

```lisp
(send-advanced-fusion-transaction endpoint mixin addresses destination optimizetarget api-key)
```

### get-transaction-private-key 

Returns the private-key for a given transaction hash.

```lisp
(get-transaction-private-key endpoint hash api-key)
```

## Balance Functions

### balance

Returns the balance for the entire wallet container.

```lisp
(balance endpoint api-key)
```

### balance-address

Returns the balance for the given address.

```lisp 
(balance-address endpoint address api-key)
```

### get-balances 

Returns balances for all addresses.

```lisp 
(get-balances endpoint api-key)
```

## Misc. Functions

### save 

Saves the wallet.

```lisp
(save endpoint api-key)
```

### export-wallet-data

Exports wallet data as JSON.

```lisp
(export-wallet-data endpoint filename api-key)
```

### reset-wallet

Saves the wallet and scans from a beginning start height.

```lisp
(reset-wallet endpoint scanheight api-key)
```

### validate-address

Checks if an address is valid.

```lisp
(validate-address endpoint address api-key)
```

### get-status 

Returns the wallet sync status, peer count, and hashrate.

```lisp
(get-status endpoint api-key)
```
