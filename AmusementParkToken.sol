//SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "./ERC20.sol";

contract AmusementParkToken {
    
    // Opening statements

    ERC20 private token;
    address payable public owner;

    constructor() {
        token = new ERC20(10000);
        owner = msg.sender;
    }

    struct customer {
        uint buyedTokens;
        string[] usedRides;
    }

    mapping(address=>customer) public Customers;

    // Token management

    function tokenPrice(uint _tokenQty) internal pure returns(uint) {
        return _tokenQty*(1 ether);
    }

    function buyToken(uint _tokenQty) public payable {
        uint cost = tokenPrice(_tokenQty);
        require(msg.value>=cost, "You do not have the amount of ethers necessary for the purchase.");
        uint returnValue = msg.value-cost;
        msg.sender.transfer(returnValue);
        uint balance = balanceOf();
        require(_tokenQty<=balance, "El número de tokens solicitados supera el número de tokens en venta.");
        token.transfer(msg.sender, _tokenQty);
        Customers[msg.sender].buyedTokens = _tokenQty;
    }

    function balanceOf() public view returns(uint) {
        return token.balanceOf(address(this));
    }

}