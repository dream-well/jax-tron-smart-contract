pragma solidity ^0.8.3;

import "./TRC20.sol";
import "./Ownable.sol";

/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */
contract TRC20Fee is TRC20, Ownable {

    // transaction fee
    uint public transaction_fee = 2500000;
    // transaction fee decimal 
    uint public transaction_fee_decimal = 8;
    // transaction fee wallet
    address public tx_fee_wallet;

    /**
     * @dev Sets the value of the `cap`. This value is immutable, it can only be
     * set once during construction.
     */
    constructor () {
        tx_fee_wallet = msg.sender;
    }

    /**
     * @dev Function to set transaction fee.
     * @param _tx_fee transaction fee
     */
    function setTransactionFee(uint _tx_fee) public onlyOwner {
        transaction_fee = _tx_fee;
    }

    /**
     * @dev Function to set transaction fee wallet.
     * @param _wallet wallet address stores transaction fee
     */
    function setTransactionFeeWallet(address _wallet) public onlyOwner {
        tx_fee_wallet = _wallet;
    }

     /**
     * @dev See {IBEP20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {BEP20}.
     * Take transaction fee from sender and transfer fee to the transaction fee wallet.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        uint fee_amount = calculateFee(amount);
        super.transferFrom(sender, tx_fee_wallet, fee_amount);
        super.transferFrom(sender, recipient, amount - fee_amount);
        return true;
    }

    /**
     * @dev See {IBEP20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        uint fee_amount = calculateFee(amount);
        super.transfer(tx_fee_wallet, fee_amount);
        super.transfer(recipient, amount - fee_amount);
        return true;
    }

    /**
     * @dev Function to set transaction fee wallet.
     * @param amount transaction amount
     */
    function calculateFee(uint256 amount) internal view returns (uint256) {
        return amount * transaction_fee / (10 ** transaction_fee_decimal);
    }
}
