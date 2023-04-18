//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;//定义solidity的版本号
contract VendingMachine {
    address public owner;//定义拥有者
    mapping(address => uint) public donutBalances;//创建一个甜甜圈的地址对数量的映射
 constructor() {
     owner = msg.sender;//合约调用者就是owner
     donutBalances[address(this)] = 100;//合约地址的甜甜圈数量为100
 }
 function getVendingMachineBalance() public view returns(uint) {
     return donutBalances[address(this)];//返回部署地址的甜甜圈数量
 }
 function restock(uint amount) public {
     require(msg.sender == owner, "not owner");//判断调用者地址是否为部署合约者地址
     donutBalances[address(this)] += amount;//给甜甜圈的数量进行补货
 }
 function purchase(uint amount) public payable {
     require(msg.value >= amount * 2 ether, "buy a donut at least 2 ether");//判断购买者的余额是否大于等于amount乘以2
     require(donutBalances[address(this)] >= amount, "donutBalances not enough");//判断甜甜圈的余额是否大于等于购买的数量
     donutBalances[address(this)] -= amount;//减去购买数量
     donutBalances[msg.sender] += amount;//增加购买数量
 }
}
