pragma solidity >=0.4.22 <0.9.0;
//SPDX-License-Identifier:UNLICENSED

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract TokenOpenZeppelin1 is ERC20 {
    constructor() ERC20('TURBO', 'TRO') {}
}

//mint means create some tokens for an address
contract TokenOpenZeppelin2 is ERC20 {
    constructor() ERC20('TURBO', 'TRO') {
        //function provided by ERC2O implementation
        _mint(msg.sender, 100000);

    }
}

//after deployement, create a dedicate function for minting token
contract TokenOpenZeppelin3 is ERC20 {
    //protection to avoid other people to mint
    address public admin;
    constructor() ERC20('TURBO', 'TRO') {
        //set deployer of the transaction
        //define an admin address
        admin = msg.sender;
        //function provided by ERC2O implementation
        //_mint(msg.sender, 100000);
    }

    function mint(address to, uint amount) external {
        //the caller of the function is admin and we protected the function
        require(msg.sender == admin, 'only admin');
        _mint(to, amount);
    }
}

//create an ERC20 faucet for internal dev
//we dont protect because of faucet
contract TokenOpenZeppelin4 is ERC20 {
     constructor() ERC20('TURBO', 'TRO') {}
    function faucet(address to, uint amount) external {
        _mint(to, amount);
    }
}