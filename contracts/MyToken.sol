// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Smart Contract Project
// For this project, write a smart contract that implements the require(), assert() and revert() statements.

contract MyToken {
    // public variables here
    string public name = "Cyptite";
    string public symbol = "CPT";
    uint256 public totalSupply = 100000;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // mapping variable here
    mapping(address => uint256) public balanceOf;

    // mint function
    function mint(address _to, uint256 _value) public {
        require(_to != address(0), "MyToken: Can't burn in zero address");
        totalSupply += _value;
        balanceOf[_to] += _value;
    }

    // burn function
    function burn(address _to, uint256 _value) public {
        require(
            balanceOf[_to] >= _value,
            "You don't have enough tokens to burn"
        );

        totalSupply -= _value;
        balanceOf[_to] -= _value;
    }

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
