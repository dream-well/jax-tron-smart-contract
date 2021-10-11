pragma solidity ^0.8.3;

import "./TRC20Burnable.sol";
import "./TRC20Capped.sol";
import "./TRC20Mintable.sol";
import "./TRC20Fee.sol";

/**
 * @title XTRC20 token
 * @dev The decimals are only for visualization purposes.
 * All the operations are done using the smallest and indivisible token unit,
 * just as on TRON all the operations are done in sun.
 *
 * Example inherits from basic TRC20 implementation but can be modified to
 * extend from other ITRC20-based tokens:
 * https://github.com/OpenZeppelin/openzeppelin-solidity/issues/1536
 */
contract XTRC20 is TRC20Detailed, TRC20Capped, TRC20Mintable, TRC20Burnable, TRC20Fee {
    
    constructor (
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 cap
    )
        TRC20Detailed(name, symbol, decimals)
        TRC20Capped(cap)
        payable
    {

    }

}
