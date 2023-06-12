// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MyToken {
    // The name of the token
    string public name = "Cyptite";

    // The symbol of the token
    string public symbol = "CPT";

    // The total supply of the token
    uint256 public totalSupply = 100000;

    // mapping variable here

    // Maps addresses to their token balances
    mapping(address => uint256) public balanceOf;

    // Event emitted on token transfer
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() {
        // Assign the total supply to the contract deployer
        balanceOf[msg.sender] = totalSupply;
    }

    // mint function

    /**
     * @dev Mint new tokens and assign them to the specified address.
     * @param _to The address to which the new tokens will be minted.
     * @param _value The amount of tokens to mint.
     */
    function mint(address _to, uint256 _value) public {
        require(_to != address(0), "MyToken: Can't burn in zero address");
        totalSupply += _value;
        balanceOf[_to] += _value;
    }

    // burn function

    /**
     * @dev Burn tokens from the specified address.
     * @param _to The address from which the tokens will be burned.
     * @param _value The amount of tokens to burn.
     */
    function burn(address _to, uint256 _value) public {
        require(
            balanceOf[_to] >= _value,
            "You don't have enough tokens to burn"
        );

        totalSupply -= _value;
        balanceOf[_to] -= _value;
    }

    /**
     * @dev Transfer tokens from the sender's address to the specified address.
     * @param _to The address to which the tokens will be transferred.
     * @param _value The amount of tokens to transfer.
     * @return success A boolean indicating whether the transfer was successful.
     */
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_to != address(0), "MyToken: Can't transfer to zero address");
        require(
            balanceOf[msg.sender] >= _value,
            "MyToken: Insufficient balance"
        );

        if (_value > 1000) {
            revert("MyToken: Sorry, you can't transfer more than 1000");
        }

        uint256 previousSenderBalance = balanceOf[msg.sender];
        uint256 previousRecipientBalance = balanceOf[_to];

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        assert(balanceOf[msg.sender] == previousSenderBalance - _value);
        assert(balanceOf[_to] == previousRecipientBalance + _value);

        emit Transfer(msg.sender, _to, _value);

        return success;
    }
}
