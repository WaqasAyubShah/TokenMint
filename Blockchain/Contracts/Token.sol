pragma solidity ^0.8.2;

contract TokenMint{
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowence;
    uint256 public totalSupply = 100000 * 10 ** 18;
    string public name = "Token Mint";
    string public symble = "TKM";
    uint256 public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed sender, uint value);

    constructor(){
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }

    function transfer(address to, uint value) public returns(bool){
        require(balanceOf(msg.sender) >= value, 'balance too low');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) public returns(bool){
         require(balanceOf(msg.sender) >= value, 'balance too low');
         require(allowence[from][msg.sender] >= value, 'allowence too low' );
         balances[to] += value;
         balances[from] -= value;
         emit Transfer(from, to, value);
         return true;
    }
    function approve(address sender, uint value) public returns(bool){
        allowence[msg.sender][sender] = value;
        emit Approval(msg.sender, sender, value);
        return true;
    }
}
