pragma solidity ^0.4.18;

contract Owner {
    address public accountOwner;

    modifier onlyOwner {
        require(msg.sender == accountOwner);
        _;
    }

}