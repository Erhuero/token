pragma solidity >=0.4.22 <0.9.0;
//SPDX-License-Identifier:UNLICENSED

//import the interface IERC20
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

//transfert will be between two different smart contract addresses
//define interface for the contract
interface contractB{
    //we have a deposit function in the contract with the same signature
    function deposit(uint amount) external;
    function withdraw(uint amount) external;
}


contract contractA{
    IERC20 public token;
    //pointer for contract B andd pass the adress in parameters
    ContractB public contractB;

    //create a pointer
    //pass address token
    constructor(addess _token, address _contractB){
        //we can interact with our token contract
        token = IERC20(_token);
        contractB = ContractB(_contractB);
    }

    //deposit in contract A
    //external address 
    //need to call an approve function of token for the adddress of contract A
    function deposit(uint amount) external {
        //add transfer to the contract
        token.transferFrom(msg.sender, address(this), amount);
        //after deposit we need to forward to contract B
        token.approve(address(contractB), amount);
        //call the deposit function on contract B
        contractB.deposit(amount);
    }

    function withdraw(uint amount) external {
        //get a token from contract B
        contractB.withdraw(amount);
        //send it back to original address/sender
        token.transfer(msg.sender, amount);
    }
}